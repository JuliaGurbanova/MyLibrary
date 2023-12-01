//
//  SearchBookViewController.swift
//  MyLibrary
//
//  Created by Julia Gurbanova on 01.12.2023.
//

import UIKit

class SearchBookViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    var searchbooks = [DatabaseFunctions.Book]()
    let databaseFunctions = DatabaseFunctions()
    let commonFunctions = CommonFunctions()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        bookQuery()

        // Do any additional setup after loading the view.
    }

    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect

        textField.attributedPlaceholder = NSAttributedString(string: "Search Terms", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.textColor = .black

        return textField
    }()

    let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.init(red: 255/255, green: 253/255, blue: 208/255, alpha: 1)
        tableView.layer.cornerRadius = 5
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.black.cgColor
        tableView.isScrollEnabled = false
        return tableView
    }()

    func setup() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchcell")
        searchTableView.backgroundColor = UIColor.init(red: 202/255, green: 202/255, blue: 202/255, alpha: 1)

        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        searchTextField.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        searchTextField.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
    }

    @objc func textFieldEditingDidBegin(sender: UITextField) {
        if sender == searchTextField {
            searchbooks = databaseFunctions.books
        }
    }

    @objc func textFieldEditingChanged(sender: UITextField) {
        if sender == searchTextField {
            databaseFunctions.books = searchbooks
            databaseFunctions.books = searchbooks.filter { item in
                return item.bookname.lowercased().contains(searchTextField.text!.lowercased())
            }

            databaseFunctions.books.append(contentsOf: searchbooks.filter { item in
                return item.authorname.lowercased().contains(searchTextField.text!.lowercased())
            })

            removeTableConstraints()
            drawSearchTable()

            if databaseFunctions.books.count > 0 {
                searchTableView.isHidden = false
                searchTableView.reloadData()
            } else {
                searchTableView.isHidden = true
            }
        }
    }

    @objc func textFieldEditingDidEnd(sender: UITextField) {
        if sender == searchTextField {
            databaseFunctions.books = searchbooks
        }
    }

    func removeTableConstraints() {
        searchTableView.removeConstraints(searchTableView.constraints)
        searchTableView.removeFromSuperview()
    }

    func drawInputScreen() {
        view.addSubview(searchTextField)
        commonFunctions.setFieldLayout(mainField: searchTextField, constraintField: view!, topAnchor: 60, leftAnchor: 5, rightAnchor: -5, heightAnchor: 40)
    }

    func drawSearchTable() {
        let tableHeight = CGFloat(databaseFunctions.books.count * 40)
        view.addSubview(searchTableView)
        commonFunctions.setFieldLayout(mainField: searchTableView, constraintField: searchTextField, topAnchor: 60, leftAnchor: 5, rightAnchor: -5, heightAnchor: tableHeight)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return databaseFunctions.books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "searchcell")
        let attrsList = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributedStringList = NSMutableAttributedString(string: databaseFunctions.books[indexPath.row].bookname, attributes: attrsList)
        cell.textLabel?.attributedText = attributedStringList
        cell.detailTextLabel?.text = databaseFunctions.books[indexPath.row].authorname
        return cell
    }

    fileprivate func bookQuery() {
        databaseFunctions.group.enter()
        databaseFunctions.bookQuery()
        databaseFunctions.group.notify(queue: .main) {
            self.setup()
            self.drawInputScreen()
        }
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
