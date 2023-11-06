//
//  AddBookViewController.swift
//  MyLibrary
//
//  Created by Julia Gurbanova on 12.10.2023.
//

import UIKit

class AddBookViewController: UIViewController {
    let commonFunctions = CommonFunctions()
    let databaseFunctions = DatabaseFunctions()
    let book = DatabaseFunctions.Book()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawInputScreen()
        // Do any additional setup after loading the view.
    }

    private let addNavigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.backgroundColor = UIColor.init(red: 171/255, green: 189/255, blue: 217/255, alpha: 1)

        let navItem = UINavigationItem(title: "Add a Book")

        let resetSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 15, weight: .black)

        let resetImage = UIImage(systemName: "arrowshape.turn.up.left.fill", withConfiguration: resetSymbolConfiguration)

        let editItem = UIBarButtonItem(image: resetImage, landscapeImagePhone: resetImage, style: .plain, target: nil, action: #selector(resetButtonAction))

        let saveSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .black)

        let saveImage = UIImage(systemName: "s.circle.fill", withConfiguration: saveSymbolConfiguration)

        let saveItem = UIBarButtonItem(image: saveImage, landscapeImagePhone: saveImage, style: .plain, target: nil, action: #selector(saveButtonAction))

        navItem.rightBarButtonItem = saveItem
        navItem.leftBarButtonItem = editItem
        navigationBar.setItems([navItem], animated: false)
        return navigationBar
    }()

    @objc func resetButtonAction(sender: UIButton) {

    }

    @objc func saveButtonAction(sender: UIButton) {
        var canSave: Bool = true

        if bookTextField.text == "" {
            bookTextField.placeholder = "Book Name cannot be blank"
            bookTextField.layer.borderWidth = 2
            bookTextField.layer.cornerRadius = 5
            bookTextField.layer.borderColor = UIColor.red.cgColor
            canSave = false
        } else {
            bookTextField.layer.borderWidth = 0
        }

        if authorTextField.text == "" {
            authorTextField.placeholder = "Author Name cannot be blank"
            authorTextField.layer.borderWidth = 2
            authorTextField.layer.cornerRadius = 5
            authorTextField.layer.borderColor = UIColor.red.cgColor
            canSave = false
        } else {
            authorTextField.layer.borderWidth = 0
        }

        if genreTextField.text == "" {
            genreTextField.placeholder = "Genre cannot be blank"
            genreTextField.layer.borderWidth = 2
            genreTextField.layer.cornerRadius = 5
            genreTextField.layer.borderColor = UIColor.red.cgColor
            canSave = false
        } else {
            genreTextField.layer.borderWidth = 0
        }

        if statusTextField.text == "" {
            statusTextField.placeholder = "Status cannot be blank"
            statusTextField.layer.borderWidth = 2
            statusTextField.layer.cornerRadius = 5
            statusTextField.layer.borderColor = UIColor.red.cgColor
            canSave = false
        } else {
            statusTextField.layer.borderWidth = 0
        }

        if canSave {
            book.bookname = bookTextField.text!
            book.authorname = authorTextField.text!
            book.genre = genreTextField.text!
            book.status = statusTextField.text!
            saveBook()
        }
    }

    fileprivate func saveBook() {
        databaseFunctions.group.enter()
        databaseFunctions.saveBook(book: book)
        databaseFunctions.group.notify(queue: .main) {
            print("Record Saved")
        }
    }

    private let bookTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .darkGray
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: "Enter The Book Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
        textField.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        return textField
    }()

    private let authorTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .darkGray
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: "Enter Author Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
        textField.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        return textField
    }()

    private let genreTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .darkGray
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: "Enter Genre", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
        textField.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        return textField
    }()

    private let statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .darkGray
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: "Enter Status (Read/Reading/To Read)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
        textField.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        return textField
    }()

    @objc func textFieldEditingDidBegin(sender: UITextField) {
        sender.layer.borderWidth = 0
    }

    func drawInputScreen() {
        view.addSubview(addNavigationBar)
        commonFunctions.setFieldLayout(mainField: addNavigationBar, constraintField: view!, topAnchor: 60, leftAnchor: 0, rightAnchor: 0, heightAnchor: 40)
        view.addSubview(bookTextField)
        commonFunctions.setFieldLayout(mainField: bookTextField, constraintField: addNavigationBar, topAnchor: 60, leftAnchor: 5, rightAnchor: -5, heightAnchor: 40)
        view.addSubview(authorTextField)
        commonFunctions.setFieldLayout(mainField: authorTextField, constraintField: bookTextField, topAnchor: 60, leftAnchor: 0, rightAnchor: 0, heightAnchor: 40)
        view.addSubview(genreTextField)
        commonFunctions.setFieldLayout(mainField: genreTextField, constraintField: authorTextField, topAnchor: 60, leftAnchor: 0, rightAnchor: 0, heightAnchor: 40)
        view.addSubview(statusTextField)
        commonFunctions.setFieldLayout(mainField: statusTextField, constraintField: genreTextField, topAnchor: 60, leftAnchor: 0, rightAnchor: 0, heightAnchor: 40)
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
