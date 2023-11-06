//
//  DatabaseFunctions.swift
//  MyLibrary
//
//  Created by Julia Gurbanova on 06.11.2023.
//

import CloudKit
import UIKit

class DatabaseFunctions: NSObject {
    class Book {
        var bookname: String!
        var authorname: String!
        var genre: String!
        var status: String!
    }

    let group = DispatchGroup()
    let syncQueue = DispatchQueue(label: "iCloud.me.gurbanova.julia.MyLibrary")

    func saveBook(book: Book) {
        let ckRecordZoneID = CKRecordZone(zoneName: "_defaultZone")
        let privateDatabase = CKContainer.default().privateCloudDatabase
        let ckRecordID = CKRecord.ID(zoneID: ckRecordZoneID.zoneID)
        let aRecord = CKRecord(recordType: "Book", recordID: ckRecordID)
        aRecord["bookname"] = book.bookname
        aRecord["authorname"] = book.authorname
        aRecord["genre"] = book.genre
        aRecord["status"] = book.status

        privateDatabase.save(aRecord, completionHandler: { (record, error) -> Void in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.syncQueue.async {
                        self.group.leave()
                    }
                }
            }
        })
    }
}
