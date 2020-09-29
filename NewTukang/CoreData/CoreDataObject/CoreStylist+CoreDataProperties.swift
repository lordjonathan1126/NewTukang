//
//  CoreStylist+CoreDataProperties.swift
//  NewTukang
//
//  Created by Jonathan Ng on 29/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreStylist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreStylist> {
        return NSFetchRequest<CoreStylist>(entityName: "CoreStylist")
    }

    @NSManaged public var companyId: Int64
    @NSManaged public var createDate: Date?
    @NSManaged public var desc: String?
    @NSManaged public var id: Int64
    @NSManaged public var img: String?
    @NSManaged public var location: String?
    @NSManaged public var loginDate: Date?
    @NSManaged public var mobile: String?
    @NSManaged public var name: String?
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var imgs: [String]?
    @NSManaged public var companies: CoreCompany?
    @NSManaged public var posts: NSSet?

}

// MARK: Generated accessors for posts
extension CoreStylist {

    @objc(addPostsObject:)
    @NSManaged public func addToPosts(_ value: CorePost)

    @objc(removePostsObject:)
    @NSManaged public func removeFromPosts(_ value: CorePost)

    @objc(addPosts:)
    @NSManaged public func addToPosts(_ values: NSSet)

    @objc(removePosts:)
    @NSManaged public func removeFromPosts(_ values: NSSet)

}

extension CoreStylist : Identifiable {

}
