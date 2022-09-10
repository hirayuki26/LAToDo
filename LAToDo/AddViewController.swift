//
//  AddViewController.swift
//  LAToDo
//
//  Created by Yuki Hirayama on 2022/09/05.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextView: UITextView!
    @IBOutlet var limitTextField: UITextField!
    
    var pretodo: Todo!
    var navititle: String = ""
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    var editflag: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if navititle == "" {
            editflag = false
            self.navigationItem.title = "追加"
        } else {
            editflag = true
            self.navigationItem.title = navititle
            
            titleTextField.text = pretodo?.title
            contentTextView.text = pretodo?.content
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if pretodo.limit != nil {
                limitTextField.text = "\(formatter.string(from: pretodo.limit))"
            }
        }
        
        
        contentTextView.layer.borderWidth = 0.1
        contentTextView.layer.cornerRadius = 5.0
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        limitTextField.inputView = datePicker
        
        datePicker.preferredDatePickerStyle = .wheels
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        
        limitTextField.inputView = datePicker
        limitTextField.inputAccessoryView = toolbar
        

        // Do any additional setup after loading the view.
    }
    
    @objc func done() {
        limitTextField.endEditing(true)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        limitTextField.text = "\(formatter.string(from: datePicker.date))"
    }
    
    func read() -> Todo? {
        return realm.objects(Todo.self).first
    }
    
    @IBAction func save() {
        
        let savetitle: String = titleTextField.text!
        let savecontent: String = contentTextView.text!
        let savelimit: Date = datePicker.date
        
        let newTodo = Todo()
        newTodo.title = savetitle
        newTodo.content = savecontent
        newTodo.limit = savelimit
        
        print("あ")
        
        if editflag == false {
            try! realm.write {
                realm.add(newTodo)
                print(newTodo.title)
    //            print("\(newTodo.limit)")
                print("success")
            }
        } else {
            try! realm.write {
                pretodo.title = savetitle
                pretodo.content = savecontent
                pretodo.limit = savelimit
            }
        }
        
        
//        let alert: UIAlertController = UIAlertController(title: "成功", message: "保存しました", preferredStyle: .alert)
//
//        alert.addAction(
//            UIAlertAction(title: "OK", style: .default, handler: nil)
//        )
//
//        present(alert, animated: true, completion: nil)
        
//        self.performSegue(withIdentifier: "AddToList", sender: nil)
        
        performSegue(withIdentifier: "AddToList", sender: nil)
//        self.navigationController?.popViewController(animated: true)
        
//        let ListViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
//        self.present(ListViewController, animated: true, completion: nil)
//        if todo != nil {
//            try! realm.write {
//                todo!.title = title
//                todo!.content = content
//            }
//        } else {
//            let newTodo = Todo()
//            newTodo.title = title
//            newTodo.content = content
//
//            try! realm.write {
//                realm.add(newTodo)
//            }
//        }
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
