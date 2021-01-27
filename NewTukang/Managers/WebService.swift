//
//  WebService.swift
//  NewTukang
//
//  Created by Jonathan Ng on 03/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//
import Foundation
import Combine
import CoreLocation

//Web Service to download data from API
class WebService: ObservableObject{
    @Published var posts = [Post]()
    @Published var stylists = [Stylist]()
    @Published var companies = [Company]()
    @Published var json4Swift = [Json4Swift_Base]()
    @Published var locationManager = LocationManager()
    
    let defaults = UserDefaults.standard
    var updateDate: Date = Date()
    
    var latitude: Double  { return( locationManager.location?.latitude ?? 0) }
    var longitude: Double { return( locationManager.location?.longitude ?? 0) }
    var url:URL = URL(string: "")!
    
    func getPosts(){
        let userLocation = CLLocationCoordinate2DMake(latitude,longitude)
        print(userLocation)
        if defaults.bool(forKey: "First Launch") == true {
            print("Second+")
            // Run Code After First Launch
            defaults.set(true, forKey: "First Launch")
            url = URL(string: "")!
        } else {
            print("First")
            // Run Code During First Launch
            defaults.set(true, forKey: "First Launch")
            
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard data != nil else{
                return
            }
            do{
                //Decode Json
                let jsonDecoder = JSONDecoder()
                print("Started decoding Json")
                let responseModel = try jsonDecoder.decode(Json4Swift_Base.self, from: data!)
                
                self.updateDate = responseModel.updateDate!
                self.defaults.set(self.updateDate, forKey: "updateDate")
                
                DispatchQueue.main.async {
                    //Saving stylists from JSON into struct object
                    self.stylists = responseModel.delta!.stylist!
                    //Save stylist into CoreData
                    print("Started saving stylist into coredata")
                    let cdManager = CoreDataManager()
                    cdManager.saveStylist(self.stylists)
                }
                
                DispatchQueue.main.async {
                    //Save posts from JSON into struct object
                    self.posts = responseModel.delta!.post!
                    //Save posts into CoreData
                    print("Started saving post into coredata")
                    let cdManager = CoreDataManager()
                    cdManager.savePost(self.posts, stylists: self.stylists, userLocation: userLocation)
                    cdManager.deleteEndedPost()
                }
                
                DispatchQueue.main.async {
                    //Save Companies from Json into struct object
                    self.companies = responseModel.delta!.company!
                    //Save Companies into CoreData
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
