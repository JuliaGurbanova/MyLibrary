//
//  BooksViewController.swift
//  MyLibrary
//
//  Created by Julia Gurbanova on 12.11.2023.
//

import UIKit

class BooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let commonFunctions = CommonFunctions()
    let databaseFunctions = DatabaseFunctions()

    private let bookTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = true
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        bookQuery()
    }

    fileprivate func bookQuery() {
        databaseFunctions.group.enter()
        databaseFunctions.bookQuery()
        databaseFunctions.group.notify(queue: .main) {
            print("Number of books: \(self.databaseFunctions.books.count)")
            self.setup()
            self.drawBookDisplay()
            self.bookTableView.reloadData()
        }
    }

    func setup() {
        bookTableView.delegate = self
        bookTableView.dataSource = self
        bookTableView.register(UITableViewCell.self, forCellReuseIdentifier: "book")
    }

    func drawBookDisplay() {
        view.addSubview(bookTableView)
        commonFunctions.setFieldLayout(mainField: bookTableView, constraintField: view!, topAnchor: 100, leftAnchor: 0, rightAnchor: 0, heightAnchor: 400)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.databaseFunctions.books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "book")
        cell.textLabel?.text = self.databaseFunctions.books[indexPath.row].bookname
        cell.detailTextLabel?.text = self.databaseFunctions.books[indexPath.row].authorname
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Books"
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
