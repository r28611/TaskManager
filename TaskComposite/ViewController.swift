//
//  ViewController.swift
//  TaskComposite
//
//  Created by Margarita Novokhatskaia on 15/10/2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let taskTable = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = taskTable
        taskTable.dataSource = self
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    
}

