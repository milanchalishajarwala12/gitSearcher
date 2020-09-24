//
//  GitDetailViewController.swift
//  AlamofireDemo
//
//  Created by Milan Chalishajarwala on 9/24/20.
//  Copyright © 2020 Milan Chalishajarwala. All rights reserved.
//

import UIKit

class GitDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var repos = [Repo]()
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    let apiHandler = APIHandler()
    var profileUrl: String = ""
    
    @IBOutlet weak var fullName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        repoTable.delegate = self
        repoTable.dataSource = self
        configureProfileDetails()
        fetchProfileDetails()
    }
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var publicRepos: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var blog: UILabel!
    @IBOutlet weak var userNameBGView: UIView!
    func fetchProfileDetails(){
        let profileEndpoint = self.profileUrl
        apiHandler.getProfileDetails(url: profileEndpoint)
        apiHandler.completionHandler = {
            profile  in
            let profDetails = profile as! Profile
            DispatchQueue.main.async {
                
                if let name = profDetails.name{
                    self.fullName.text = name
                }else{
                    self.fullName.text = ""
                }
                
                
                if let username = profDetails.login{
                    self.userName.text = username
                }else{
                    self.userName.text = ""
                }
                
               
                
                
                if let location = profDetails.location{
                    self.location.text = location
                }else{
                    self.location.text = ""
                }
                
                
                
                if let bio = profDetails.bio{
                    self.bio.text = "\(bio)"
                }else{
                    self.bio.text = ""
                }
                
                if let blog = profDetails.blog{
                    self.blog.text = blog
                }else{
                    self.blog.text = ""
                }
                
                if let email = profDetails.email{
                    self.email.text = email
                }else{
                    self.email.text = ""
                }
                
                if let publicrepos = profDetails.public_repos{
                    self.publicRepos.text = "\(publicrepos) Public Repositories"
                }
                
                guard let avatarurl = profDetails.avatar_url else { return }
                if let url = URL(string: avatarurl){
            let data = try! Data(contentsOf: url)
            self.profileImage.image = UIImage(data: data)
            }
            }
            self.apiHandler.getRepositories(url: profDetails.repos_url!)
            self.apiHandler.completionHandlerRepo = { repos in
                DispatchQueue.main.async {
                    self.repos = repos as! [Repo]
                    self.repoTable.reloadData()
                }
            }

        }
        
    }
    
    
    @IBOutlet weak var repoTable: UITableView!
    
    func configureProfileDetails(){
        self.profileImage.layer.cornerRadius = 40
        self.profileImage.layer.borderWidth = 1
        self.profileImage.layer.borderColor = UIColor.white.cgColor
        self.userNameBGView.layer.cornerRadius = 7.5
        self.userNameBGView.layer.zPosition = -1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = self.repos[indexPath.row].name
        cell.detailTextLabel?.text = self.repos[indexPath.row].full_name
        return cell
    }
}
