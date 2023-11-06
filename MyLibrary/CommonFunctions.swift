//
//  CommonFunctions.swift
//  MyLibrary
//
//  Created by Julia Gurbanova on 06.11.2023.
//

import UIKit

class CommonFunctions: NSObject {

    func setFieldLayout(mainField: Any, constraintField: Any, topAnchor: CGFloat, leftAnchor: CGFloat, rightAnchor: CGFloat, heightAnchor: CGFloat) {
        (mainField as AnyObject).topAnchor.constraint(equalTo: (constraintField as AnyObject).topAnchor, constant: topAnchor).isActive = true
        (mainField as AnyObject).leftAnchor.constraint(equalTo: (constraintField as AnyObject).leftAnchor, constant: leftAnchor).isActive = true
        (mainField as AnyObject).rightAnchor.constraint(equalTo: (constraintField as AnyObject).rightAnchor, constant: rightAnchor).isActive = true
        (mainField as AnyObject).heightAnchor.constraint(equalToConstant: heightAnchor).isActive = true
    }

}
