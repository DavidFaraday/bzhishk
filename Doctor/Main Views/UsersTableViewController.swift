//
//  UsersTableViewController.swift
//  HorseDoctor
//
//  Created by David Kababyan on 20/09/2020.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    //MARK: - Vars
    var allStables:[User] = []

    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        navigationItem.largeTitleDisplayMode = .always
        
        downloadStablesUsers()
        
    }

    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return allStables.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserTableViewCell

        cell.configure(user: allStables[indexPath.row])
        
        return cell
    }
    
    //MARK: - TableView Delegates
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        showUserProfile(allStables[indexPath.row])
    }


    
    //MARK: - Download users
    private func downloadStablesUsers() {
        FirebaseUserListener.shared.downloadUsers(with: UserType.Stable) { (allStables) in

            self.allStables = allStables

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    //MARK: - Navigation
    private func showUserProfile(_ user: User) {
        let profileVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProfileView") as! UserProfileTableViewController
        
        profileVc.user = user
        self.navigationController?.pushViewController(profileVc, animated: true)
    }

}
