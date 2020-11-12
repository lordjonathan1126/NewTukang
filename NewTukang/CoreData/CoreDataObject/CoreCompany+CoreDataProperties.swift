//
//  CoreCompany+CoreDataProperties.swift
//  NewTukang
//
//  Created by Jonathan Ng on 04/11/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreCompany {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreCompany> {
        return NSFetchRequest<CoreCompany>(entityName: "CoreCompany")
    }

    @NSManaged public var createDate: Date?
    @NSManaged public var desc: String?
    @NSManaged public var id: Int64
    @NSManaged public var img: String?
    @NSManaged public var imgs: [String]?
    @NSManaged public var mobile: String?
    @NSManaged public var name: String?
    @NSManaged public var fav: Bool
    @NSManaged public var stylist: NSSet?

}

// MARK: Generated accessors for stylist
extension CoreCompany {

    @objc(addStylistObject:)
    @NSManaged public func addToStylist(_ value: CoreStylist)

    @objc(removeStylistObject:)
    @NSManaged public func removeFromStylist(_ value: CoreStylist)

    @objc(addStylist:)
    @NSManaged public func addToStylist(_ values: NSSet)

    @objc(removeStylist:)
    @NSManaged public func removeFromStylist(_ values: NSSet)

}

extension CoreCompany : Identifiable {

}
