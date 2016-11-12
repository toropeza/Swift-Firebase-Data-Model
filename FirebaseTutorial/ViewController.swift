//
//  ViewController.swift
//  FirebaseTutorial
//
//  Created by Thomas Oropeza on 11/10/16.
//  Copyright © 2016 Thomas Oropeza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    //UI Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    //reference to the Data Model Class
    var dataModel: FirebaseDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataModel = appDelegate.dataModel
        
        //add Notification Center Observer for reloading Table View Data
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshList), name:NSNotification.Name(rawValue: "refresh"), object: nil)
    }
    
    //Notification Center Method for Reloading Table View
    func refreshList(){
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell")!
        let label = cell.viewWithTag(100) as! UILabel
        
        let index = dataModel.data.index(0, offsetBy: indexPath.row)
        label.text = dataModel.data[index]
        
        return cell
    }
    
    @IBAction func addItemClicked(_ sender: UIBarButtonItem) {
        if let text = textField.text {
            if text.characters.count > 0 {
                //call Data Model add Item to add to FireBase
                dataModel.addItem(item: text)
            }
            textField.endEditing(true)
            textField.text = ""
        }
    }
    
    //Toggle Edit state
    @IBAction func editButtonClicked(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.isEditing = false
            editButton.title = "Edit"
        }else {
            tableView.isEditing = true
            editButton.title = "Done"
        }
    }
    
    //On a delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataModel.removeItem(item: dataModel.data[indexPath.row])
    }
}

