//
//  ViewController.swift
//  BucketList
//
//  Created by admin on 15/12/2021.
//

import UIKit

class BucketListTableViewController: UITableViewController {
    
    var list = ["1", "b2", "3", "4", "b5"]
    var newItem: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }
    
    @IBAction func addBarBtnPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "cellSegue", sender: sender)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "cellSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        list.remove(at: indexPath.row)
        tableView.reloadData()
    }

}

extension BucketListTableViewController: AddItemTableViewControllerDelegate {
    
    func cancel(by controller: AddItemTableViewController) {
            print("BucketListVC: cancel")
            dismiss(animated: true, completion: nil)
    }
    
    func addItem(by controller: AddItemTableViewController, with item: String, at indexPath: NSIndexPath?) {
        print("BucketListVC: addItem --> \(item)")
        if let ip = indexPath {
            list[ip.row] = item
        }
        else {
            list.append(item)
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //I know that in the tutorial, if and if-else wareused, but I don't see a need fot them here.
        let navigationC = segue.destination as! UINavigationController
        let addItemCV = navigationC.topViewController as! AddItemTableViewController
        addItemCV.delegate = self
        if sender is IndexPath {
            let indexPath  = sender as! NSIndexPath
            let item = list[indexPath.row]
            addItemCV.item = item
            addItemCV.indexPath = indexPath
        }
    }
}

