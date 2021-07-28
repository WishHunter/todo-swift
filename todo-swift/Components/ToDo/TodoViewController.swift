//
//  TodoViewController.swift
//  todo-swift
//
//  Created by Denis Molkov on 28.07.2021.
//

import UIKit

class TodoViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var addTaskField: UITextField!
    @IBOutlet weak var addTaskView: UIView!
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var task: TaskProtocol = Task(name: "main", parent: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        updateView()
        
        addTaskView.isHidden = true
        task.addTask(name: "my first task")
        task.tasks[0].addTask(name: "my second task")
        
    }
    
    //MARK: - Actions
    
    @IBAction func addTaskOpen(_ sender: Any) {
        addTaskView.isHidden = false
    }
    
    @IBAction func addTaskClose(_ sender: Any) {
        addTaskView.isHidden = true
    }
    
    @IBAction func addTask(_ sender: Any) {
        guard let name = addTaskField.text,
              name != "" else {
            addTaskField.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        task.addTask(name: name)
        addTaskClose(self)
        
        addTaskField.text = ""
        tableView.reloadData()
        updateView()
    }
    
    @IBAction func goBack(_ sender: Any) {
        let activeTask = self.task.parent

        guard activeTask != nil else { return }
        self.task = activeTask!
        tableView.reloadData()
        updateView()
    }
    
    //MARK: - update view
    
    func updateView() {
        navigationBar.topItem?.title = task.name
        
        if task.parent == nil {
            goBackButton.isHidden = true
        } else {
            goBackButton.isHidden = false
        }
    }
}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskViewCell", for: indexPath) as! TaskViewCell
        
        let activeTask = task.tasks[indexPath.item]
        
        cell.nameLabel.text = "\(activeTask.name) (\(activeTask.tasks.count))"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activeTask = task.tasks[indexPath.item]
        self.task = activeTask
        tableView.reloadData()
        updateView()
    }
}
