//
//  ViewController.swift
//  rn78
//
//  Created by John on 7/16/15.
//  Copyright (c) 2015 Flare Labs. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    var viewModel: ViewModel
    
    var dweetObject: DweetObject = DweetObject.emptyDweet() // Empty so we can still display an empty VC
    var dweetDictionary = Dictionary<String, String>()
    
    var dweetArray = ["temperature", "light", "potentiometer", "button_1", "button_2", "button_3", "tilt_x", "tilt_y", "tilt_z", "Send Bleep"]
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.fetchedDweetObject.bind(self) { [unowned self] in
            self.dweetObject = $0 // We can now update our visuals
            self.dweetDictionary = DweetObject.dweet(self.dweetObject)
            self.tableView.reloadData()
            self.title = self.dweetObject.thing
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dweetArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        if let value = dweetDictionary[self.dweetArray[indexPath.row]] {
            cell.textLabel?.text = "\(self.dweetArray[indexPath.row]): \(value)"
        } else if self.dweetArray[indexPath.row] == "Send Bleep" {
            cell.textLabel?.text = self.dweetArray[indexPath.row]
            cell.backgroundColor = UIColor.redColor()
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if let label = cell?.textLabel?.text {
            if label == "Send Bleep" {
                self.viewModel.callBleep()
            } else {
                // what ever you want to do with the other cells when touched
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}