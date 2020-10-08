//
//  WebService.swift
//  NewTukang
//
//  Created by Jonathan Ng on 03/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//
import Foundation
import Combine

class WebService: ObservableObject{
    @Published var posts = [Post]()
    @Published var stylists = [Stylist]()
    @Published var companies = [Company]()
    
    func getPosts(){
        let url = URL(string: "https://m5.tunai.io/tukang/post")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard data != nil else{
                return
            }
            do{
                let jsonDecoder = JSONDecoder()
                print("Started decoding Json")
                let responseModel = try jsonDecoder.decode(Json4Swift_Base.self, from: data!)
                
                DispatchQueue.main.async {
                    self.posts = responseModel.delta!.post!
                    print("Started saving post into coredata")
                    let cdManager = CoreDataManager()
                    cdManager.savePost(self.posts)
                }
                
                DispatchQueue.main.async {
                    self.stylists = responseModel.delta!.stylist!
                    print("Started saving stylist into coredata")
                    let cdManager = CoreDataManager()
                    cdManager.saveStylist(self.stylists)
                }
                
                DispatchQueue.main.async {
                    self.companies = responseModel.delta!.company!
                    print("Started saving company into coredata")
                    
                    let cdManager = CoreDataManager()
                    cdManager.saveCompany(self.companies)
                }
                
            }catch{
                print(error)
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}