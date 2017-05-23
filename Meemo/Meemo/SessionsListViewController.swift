//
//  SessionsListViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/22/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class SessionsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sessions:[Session]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor.clear
        tableView.isOpaque = false
        tableView.backgroundView = nil

        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension SessionsListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sessions?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath) as! SessionTableViewCell
        cell.session = self.sessions?[indexPath.row]        
        return cell
    }

}

extension SessionsListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
