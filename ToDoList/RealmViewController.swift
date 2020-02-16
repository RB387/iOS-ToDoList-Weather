//
//  RealmViewController.swift
//  ToDoList
//
//  Created by Nikita Robertson on 15.02.2020.
//  Copyright © 2020 Nikita Robertson. All rights reserved.
//

import UIKit

class RealmViewController: UIViewController {

    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateName()
    }
    
    @IBAction func addTask(_ sender: Any) {
        let alert = UIAlertController(title: "New task", message: "Add new task", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { [unowned self] (action) in
            guard let name = alert.textFields?.first?.text else { return }
            addItemRealm(name)
            self.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @IBAction func changeName(_ sender: Any) {
        let alert = UIAlertController(title: "Change Name", message: "Enter new name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { [unowned self] (action) in
            guard let correctName = alert.textFields?[0].text else { return }
            guard let correctSecondName = alert.textFields?[1].text else { return }
            name = correctName
            secondName = correctSecondName
            self.updateName()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField(configurationHandler: { (field) in field.placeholder = "Name" })
        alert.addTextField(configurationHandler: { (field) in field.placeholder = "Second Name" })
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func updateName(){
        if let correctName = name,
            let correctSecondName = secondName {
            welcomeText.text = "Hello, \(correctName) \(correctSecondName)"
        } else {
            welcomeText.text = "Hello, anon"
        }
    }
    
}

extension RealmViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksRealm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell")!
        cell.textLabel?.text = tasksRealm[indexPath.row].name
        return cell
    }
}

extension RealmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItemRealm(at: indexPath.row)
        }
        tableView.reloadData()
    }
}
