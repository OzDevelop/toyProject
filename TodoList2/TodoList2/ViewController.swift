//
//  ViewController.swift
//  TodoList2

import UIKit

var list = [TodoList]() // TodoList형 배열 생성
    // 테이블 뷰에 리스트로 출력할 것이므로, 전역변수로 생성



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView와 연결
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
        
        
        
//        list.append(TodoList(title: "test", content:"testdata"))

    }
    
    override func viewDidAppear(_ animated: Bool) {
        todoListTableView.reloadData()
    }

    @IBOutlet var todoListTableView: UITableView!
    @IBOutlet var editButton: UIBarButtonItem!
    

    
    /// 완료 버튼
    lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTap))
        return button
    }()
    
    @objc func doneButtonTap() {
        self.navigationItem.leftBarButtonItem = editButton
        todoListTableView.setEditing(false, animated: true)
        
        doneButton.style = .plain
        doneButton.target = self
    }
    
    func saveAllData() {
        let data = list.map {
            [
            "title": $0.title,
            "content": $0.content,
            "isComplete": $0.isComplete
            ]
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "items")
        userDefaults.synchronize()
    }
    
    func loadAllData() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "items") as? [[String : AnyObject]] else { return }
        
        print(data.description)
        
        print(type(of: data))
        list = data.map {
            let title = $0["title"] as? String
            let content = $0["content"] as? String
            let isComplete = $0["isComplete"] as? Bool
            
            return TodoList(title: title!, content: content!, isComplete: isComplete!)
        }
    }
    
    
    
    
    @IBAction func editButton(_ sender: Any) {
        guard !list.isEmpty else {
            return
        }
        self.navigationItem.leftBarButtonItem = doneButton
        todoListTableView.setEditing(true, animated: true)
    }
    
    //선택하면 background가 파란색으로, 한번 더 선택하면 none이 된다.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {  
        let cell = tableView.cellForRow(at: indexPath)
//           cell.backgroundColor = .blue
//            cell.accessoryType = .checkmark
//            list[indexPath.row].isComplete = true
//            todoListTableView.reloadData()
//            print("\(indexPath)가 클릭됨.")
            tableView.deselectRow(at: indexPath, animated: true)
            print(list[indexPath.row].isComplete)
        
        if list[indexPath.row].isComplete == false {
            list[indexPath.row].isComplete = true
            cell!.backgroundColor = .blue
            
        } else {
            list[indexPath.row].isComplete = false
            cell!.backgroundColor = .none
        }

        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count //리스트의 개수만큼 출력되도록 할려고
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = list[indexPath.row].title
        cell.detailTextLabel?.text = list[indexPath.row].content
        if list[indexPath.row].isComplete {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        list.remove(at: indexPath.row)
        todoListTableView.reloadData()
    }
}


