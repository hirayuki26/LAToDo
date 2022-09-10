//
//  ListViewController.swift
//  LAToDo
//
//  Created by Yuki Hirayama on 2022/09/05.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    @IBOutlet var celltitle: UILabel!
    @IBOutlet var celldate: UILabel!

    let realm = try! Realm()
    
    var todos: Results<Todo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        todos = realm.objects(Todo.self)
        
        table.reloadData()
        print(todos.count)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let indexPath = table.indexPathForSelectedRow {
                guard let destination = segue.destination as? DetailViewController else {
                    fatalError("Failed to prepare DetailViewController.")
                }
                
                destination.todo = todos[indexPath.row]
            }
        }
    }
    
//    func read() -> Todo {
//        return realm.objects(Todo.self)
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel!.text = todos[indexPath.row].title
        
//        if todos.count != 0 {
//            celltitle.text = todos[indexPath.row].title
//
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd"
//
//            celldate.text = "\(formatter.string(from: todos[indexPath.row].limit))"
//        }
        
        return cell
    }
    
    //削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let task = todos[indexPath.row]
        
        do {
            try realm.write {
            realm.delete(task)
            }
        } catch {
            print("Error \(error)")
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func unwindToListController(segue: UIStoryboardSegue) {
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
