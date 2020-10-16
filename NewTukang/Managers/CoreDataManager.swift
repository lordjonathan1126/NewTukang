//
//  CoreDataManager.swift
//  NewTukang
//
//  Created by Jonathan Ng on 10/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//
import SwiftUI
import CoreData
import CoreLocation

class CoreDataManager : NSObject{
    public static let sharedInstance = CoreDataManager()
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    @ObservedObject var locationManager = LocationManager()
    
    override init() {}
    
    func savePost(_ posts: [Post], stylists: [Stylist]){
        let context = self.appDelegate!.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        for post in posts{
            let newPost = NSEntityDescription.insertNewObject(forEntityName: "CorePost", into: context)
            
            newPost.setValue(post.postID, forKey: "postId")
            newPost.setValue(post.price?.normal, forKey: "normalPrice")
            newPost.setValue(post.price?.discount, forKey: "discount")
            newPost.setValue(post.createDate, forKey: "createDate")
            newPost.setValue(post.endDate, forKey: "endDate")
            newPost.setValue(post.img, forKey: "img")
            newPost.setValue(post.service?.catID, forKey: "serviceCatId")
            newPost.setValue(post.service?.duration, forKey: "serviceDuration")
            newPost.setValue(post.service?.typeID, forKey: "serviceTypeId")
            newPost.setValue(post.service?.name, forKey: "serviceName")
            newPost.setValue(post.notes?.desc, forKey: "desc")
            newPost.setValue(post.stat?.p, forKey: "stat_p")
            newPost.setValue(post.stat?.v, forKey: "stat_v")
            newPost.setValue(post.stylistID, forKey: "stylistId")
            newPost.setValue(post.stat?.trending, forKey: "trending")
            newPost.setValue(post.imgs, forKey: "imgs")
            for stylist in stylists{
                if (post.stylistID == stylist.id){
                    var distance: Double? {
                        var latitude: Double  { return( Double("\(locationManager.location?.latitude ?? 0)") ?? 0) }
                        var longitude: Double { return( Double("\(locationManager.location?.longitude ?? 0)") ?? 0) }
                        let userLocation = CLLocationCoordinate2DMake(latitude, longitude)
                        let postLocation = CLLocationCoordinate2DMake(stylist.location?.lat ?? 0, stylist.location?.lat ?? 0)
                        return locationManager.distance(from: userLocation, to: postLocation)
                    }
                    newPost.setValue(distance, forKey: "distance")
                }
            }
        }
        do {
            try context.save()
            print("Saved Post to Core Data")
        } catch {
            print("Error saving: \(error) \(error.localizedDescription)")
        }
    }
    
    func saveStylist(_ stylists: [Stylist]){
            let context = self.appDelegate!.persistentContainer.viewContext
            context.automaticallyMergesChangesFromParent = true
            context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            
            for stylist in stylists{
                let newStylist = NSEntityDescription.insertNewObject(forEntityName: "CoreStylist", into: context)
                newStylist.setValue(stylist.id, forKey: "id")
                newStylist.setValue(stylist.name, forKey: "name")
                newStylist.setValue(stylist.mobile, forKey: "mobile")
                newStylist.setValue(stylist.location?.city, forKey: "location")
                newStylist.setValue(stylist.location?.lon, forKey: "lon")
                newStylist.setValue(stylist.location?.lat, forKey: "lat")
                newStylist.setValue(stylist.img, forKey: "img")
                newStylist.setValue(stylist.createDate, forKey: "createDate")
                newStylist.setValue(stylist.loginDate, forKey: "loginDate")
                newStylist.setValue(stylist.companyID, forKey: "companyId")
                newStylist.setValue(stylist.notes?.desc, forKey: "desc")
                newStylist.setValue(stylist.imgs, forKey: "imgs")
            }
            do {
                try context.save()
                print("Saved Stylist to Core Data")
            } catch {
                print("Error saving: \(error) \(error.localizedDescription)")
            }
    }
    
    func saveCompany(_ companies: [Company]){
        let context = self.appDelegate!.persistentContainer.viewContext
            context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            
            for company in companies{
                let newCompany = NSEntityDescription.insertNewObject(forEntityName: "CoreCompany", into: context )
                newCompany.setValue(company.id, forKey: "id")
                newCompany.setValue(company.createDate, forKey: "createDate")
                newCompany.setValue(company.img, forKey: "img")
                newCompany.setValue(company.mobile, forKey: "mobile")
                newCompany.setValue(company.notes?.desc, forKey: "desc")
                newCompany.setValue(company.name, forKey: "name")
                newCompany.setValue(company.imgs, forKey: "imgs")
            }
            do {
                try context.save()
                print("Saved Company to Core Data")
            } catch {
                print("Error saving: \(error) \(error.localizedDescription)")
            }
    }
}
