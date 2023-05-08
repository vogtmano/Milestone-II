//
//  ViewController.swift
//  Milestone II.1
//
//  Created by Maks Vogtman on 04/08/2022.
//

import UIKit

class ViewController: UITableViewController {
    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let clear = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clear))
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProduct))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        
        toolbarItems = [clear, spacer, add, spacer, share]
        navigationController?.isToolbarHidden = false
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        centerTitle()
    }
    
    
    @objc func clear() {
        items.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    
    @objc func addProduct() {
        let ac = UIAlertController(title: "Add Product", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] _ in
            guard let text = ac?.textFields?[0].text else { return }
            self?.submit(text)
        }
        
        ac.addAction(UIAlertAction(title: "Back", style: .cancel))
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    func submit(_ text: String) {
        let lowerText = text.lowercased()
        items.insert(lowerText, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    @objc func share() {
        let ac = UIActivityViewController(activityItems: [items.joined(separator: "\n")], applicationActivities: [])
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
}


extension UIViewController {
    func centerTitle() {
        for navItem in(self.navigationController?.navigationBar.subviews)! {
             for itemSubView in navItem.subviews {
                 if let largeLabel = itemSubView as? UILabel {
                    largeLabel.center = CGPoint(x: navItem.bounds.width/2, y: navItem.bounds.height/2)
                    return
                 }
             }
        }
    }
}

