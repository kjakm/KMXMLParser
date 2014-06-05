//
//  MainViewController.swift
//  KMRSS
//
//  Created by Kieran McGrady on 04/06/2014.
//  Copyright (c) 2014 HotRod Software. All rights reserved.
//

import Foundation
import UIKit

class MainViewController : UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataArray : NSArray = []
    
    override func viewDidLoad() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 60
    }
    
    override func viewDidAppear(animated: Bool) {
        var url = NSURL.URLWithString("http://mf.feeds.reuters.com/reuters/technologyNews")
        var parser : KMXMLParser = KMXMLParser.alloc().initWithURL(url) as KMXMLParser
        dataArray = parser.posts

        tableView.reloadData()
    }
    
    // Tableview datasource
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    override func tableView (tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        
        if !cell {
            cell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier:"cell")
        }
        
        var dict : NSDictionary! = dataArray.objectAtIndex(indexPath.row) as NSDictionary
        cell!.textLabel.text = dict.objectForKey("title") as String
        cell!.detailTextLabel.text = dict.objectForKey("date") as String
        return cell
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        var vc : WebViewController = WebViewController.alloc()
        var dict : NSDictionary! = dataArray.objectAtIndex(indexPath.row) as NSDictionary
        vc.link = dict.objectForKey("link") as NSString
        vc.title = dict.objectForKey("title") as NSString
        
        self.navigationController.pushViewController(vc, animated: true)

    }

}