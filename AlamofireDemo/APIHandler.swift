//
//  APIHandler.swift
//  AlamofireDemo
//
//  Created by Milan Chalishajarwala on 9/7/20.
//  Copyright © 2020 Milan Chalishajarwala. All rights reserved.
//

import Foundation
import CoreLocation
class APIHandler{
  
    typealias completion = (Any?) -> ()
    var completionHandler: completion?
    var completionHandlerRepo: completion?
    func getData<T: Decodable>(type: T.Type, login: String, page_number: Int){
        let endpoint = "https://api.github.com/search/users?q=\(login)&page=\(page_number)&per_page=20"
        guard let url = URL(string: endpoint)
            else {
                print("Valid URL not found")
                return
        }
        let request = URLRequest(url:url)
        URLSession.shared.dataTask(with: request){
            (data, response, error) in
            if let data = data{
                do{
                    let json = try JSONDecoder().decode(type.self, from: data)
                    guard let completionBlock = self.completionHandler else { return }
                    completionBlock(json)
                }catch{
                    print(error.localizedDescription)
                }
            }else{
                print("Data is nil")
            }
        }.resume()
        
    }
    
    
    func getProfileDetails(url: String){
        guard let url = URL(string: url)
            else {
                print("Valid URL not found")
                return
        }
        let request = URLRequest(url:url)
        
        URLSession.shared.dataTask(with: request){
            (data, response, error) in
            if let data = data{
                do{
                    let json = try JSONDecoder().decode(Profile.self, from: data)
                    guard let completionBlock = self.completionHandler else { return }
                    completionBlock(json)
                }catch{
                    print(error.localizedDescription)
                }
            }else{
                print("Data is nil")
            }
        }.resume()
    }
    
    
    func getRepositories(url: String){
        guard let url = URL(string: url)
            else {
                print("Valid URL not found")
                return
        }
        let request = URLRequest(url:url)
        
        URLSession.shared.dataTask(with: request){
            (data, response, error) in
            if let data = data{
                do{
                    let json = try JSONDecoder().decode([Repo].self, from: data)
                    guard let completionBlock = self.completionHandlerRepo else { return }
                    completionBlock(json)                    
                }catch{
                    print(error.localizedDescription)
                }
            }else{
                print("Data is nil")
            }
        }.resume()
    }
    
    
    
}

