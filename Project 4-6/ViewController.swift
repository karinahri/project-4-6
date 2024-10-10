//
//  ViewController.swift
//  Project 4-6
//
//  Created by Karina Dolmatova on 10.10.2024.
//

import UIKit

class ViewController: UITableViewController {
    var writtenItem = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem)),
            UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        ]
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartList))
        
        startList()
        
    }
    
    func startList() {
        title = "Shopping List"
        writtenItem.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return writtenItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = writtenItem[indexPath.row]
        return cell
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Add item to the list", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let newItem = ac?.textFields?[0].text else { return }
            self?.submit(newItem)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func shareList() {
        let list = writtenItem.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func restartList() {
        let ac = UIAlertController(title: "Do you want to clean the list?", message: nil, preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Yes", style: .default) {
            [weak self] _ in
            self?.startList()
        }
        
        let cancelAction = UIAlertAction(title: "No", style: .default)
        
        
        ac.addAction(cancelAction)
        ac.addAction(restartAction)
        present(ac, animated: true)
    }
    
    func submit(_ item: String) {
        writtenItem.append(item)
        let indexPath = IndexPath(row: writtenItem.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}

