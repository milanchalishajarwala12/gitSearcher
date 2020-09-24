//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by Milan Chalishajarwala on 9/4/20.
//  Copyright © 2020 Milan Chalishajarwala. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var users: [User] = []
    var response: Response?
    var page_number = 1

    @IBOutlet weak var tableView: UITableView!
    let apiHandler = APIHandler()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.isHidden = true
        searchTextView.isHidden = true
        tableView.register(GitUsersTableViewCell.nib(), forCellReuseIdentifier: "GitUsersTableViewCell")
        searchTextView.layer.cornerRadius = 7.5
        
    }
    
    @IBOutlet weak var searchTextView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchButtonOutlet: UIButton!
    
    
    @IBAction func searchButtonAcion(_ sender: Any) {
        searchTextView.isHidden = true
        searchBar.resignFirstResponder()
        apiHandler.getData(type: Response.self, login: searchBar.searchTextField.text!, page_number: self.page_number)
        receiveDataFromAPI()
    }
    
    func receiveDataFromAPI(){
        self.apiHandler.completionHandler = {
            response  in
            DispatchQueue.main.async {
                self.response = response as? Response
                if let resp = self.response{
                    self.users.append(contentsOf: resp.items)
                    print(self.users.count)
                    self.tableView.isHidden = false
                self.tableView.reloadData()
                }
        }
    }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
        self.tableView.isHidden = true
        self.searchTextView.isHidden = false
        }
        else{
            self.tableView.isHidden = true
            self.searchTextView.isHidden = true
            self.users = []

        }
        self.searchButtonOutlet.setTitle( "Search for User: \(searchText)", for: .normal)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.text = ""
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GitUsersTableViewCell") as! GitUsersTableViewCell
        let model = users[indexPath.row]
        let viewModel = ViewModel(login: model.login, id: model.id , avatar_url: model.avatar_url, url: model.url, repos_url: model.repos_url)
        cell.configureRestaurantCell(id: viewModel.id, login: viewModel.login, avatar_url: viewModel.avatar_url, repos_url: viewModel.repos_url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == users.count-1) && (users.count>19){
            self.page_number += 1
            apiHandler.getData(type: Response.self, login: searchBar.searchTextField.text!, page_number: self.page_number)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier:"GitDetailViewController") as! GitDetailViewController
        let model = users[indexPath.row]
        vc.profileUrl = model.url
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

