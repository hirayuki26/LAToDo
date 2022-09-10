//
//  DetailViewController.swift
//  LAToDo
//
//  Created by Yuki Hirayama on 2022/09/11.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var limitLabel: UILabel!
    
    var todo: Todo!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.layer.borderWidth = 0.1
        titleLabel.layer.cornerRadius = 5.0
        contentLabel.layer.borderWidth = 0.1
        contentLabel.layer.cornerRadius = 5.0
        limitLabel.layer.borderWidth = 0.1
        limitLabel.layer.cornerRadius = 5.0

        if todo.title != "" {
            titleLabel.text = todo.title
        }
        
        if todo.content != "" {
            contentLabel.text = todo.content
        }
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if todo.limit != nil {
            limitLabel.text = "\(formatter.string(from: todo.limit))"
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEdit" {
            guard let destination = segue.destination as? AddViewController else {
                fatalError("Failed to prepare DetailViewController.")
            }
            destination.pretodo = todo
            destination.navititle = "編集"
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
