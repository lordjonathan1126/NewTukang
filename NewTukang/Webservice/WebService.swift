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
    
    init(){
        getPosts()
    }
    
    func getPosts(){
        let cdManager = CoreDataManager()
        let url = URL(string: "https://m5.tunai.io/tukang/post")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard data != nil else{
                return
            }
            do{
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(Json4Swift_Base.self, from: data!)
                DispatchQueue.main.async{
                    self.posts = responseModel.delta!.post!
                    cdManager.savePost(self.posts)
                }
                
                DispatchQueue.main.async{
                    self.companies = responseModel.delta!.company!
                    cdManager.saveCompany(self.companies)
                }
                
                DispatchQueue.main.async{
                    self.stylists = responseModel.delta!.stylist!
                    cdManager.saveStylist(self.stylists)
                }
                
            }catch{
                print(error)
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
