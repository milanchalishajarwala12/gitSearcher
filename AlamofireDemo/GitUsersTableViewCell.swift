//
//  RestaurantTableViewCell.swift
//  AlamofireDemo
//
//  Created by Milan Chalishajarwala on 9/23/20.
//  Copyright © 2020 Milan Chalishajarwala. All rights reserved.
//

import UIKit

class GitUsersTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var restaurantImage: UIImageView!
    
    @IBOutlet weak var restaurantName: UILabel!
    
    @IBOutlet weak var actMonitor: UIActivityIndicatorView!
    func configureRestaurantCell(id: Int, login: String, avatar_url: String, repos_url: String){
        restaurantImage.layer.borderWidth = 0.4
        restaurantImage.layer.cornerRadius = 30
        restaurantImage.layer.borderColor = UIColor.white.cgColor
        bgView.layer.cornerRadius = 7.5
        self.restaurantName.text = login
        actMonitor.isHidden = false
        DispatchQueue.main.async {
            guard let url = URL(string: avatar_url) else { return }
            do{
                let data =  try Data(contentsOf: url)
                self.restaurantImage.image = UIImage(data: data)
            }catch{
                print(error.localizedDescription)
            }
            self.actMonitor.isHidden = true
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName:"GitUsersTableViewCell" , bundle: nil)
    }
    
}
