//
//  ViewController.swift
//  TaskComposite
//
//  Created by Margarita Novokhatskaia on 15/10/2021.
//

import UIKit

let reuseIdentifier = "Cell"

protocol AddTasksDelegate {
    func addTasks(tasks: [TaskProtocol])
}

class ViewController: UIViewController {
    
    var addTasksDelegate: AddTasksDelegate?
    
    private let taskTable = UITableView()
    private var currentTask = Task(name: "main task", subtask: [Task]())

    override func viewDidLoad() {
        super.viewDidLoad()
        taskTable.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view = taskTable
        title = currentTask.name
        taskTable.dataSource = self
        taskTable.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(handleAddTask))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                           target: self,
                                                           action: #selector(handleGoBack))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskTable.reloadData()
    }

    // MARK: - Initialisation
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(task: Task) {
        self.init()
        self.currentTask = task
    }
    
    // MARK: - Private methods

    @objc private func handleAddTask() {
        currentTask.addSubtask(task: Task(name: "newtask", subtask: [TaskProtocol]()))
        taskTable.reloadData()
    }
    
    @objc private func handleGoBack() {
        print("added subtasks")
        navigationController?.popViewController(animated: true)
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTask.subtask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTable.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = currentTask.subtask[indexPath.row].name + " " + "(\(currentTask.subtask[indexPath.row].subtask.count))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = currentTask.subtask[indexPath.row] as? Task {
            let nextVC = ViewController(task: task)
            nextVC.addTasksDelegate = self
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension ViewController: AddTasksDelegate {
    func addTasks(tasks: [TaskProtocol]) {
    }
    
    
}

