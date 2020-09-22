//
//  CorePost+CoreDataProperties.swift
//  NewTukang
//
//  Created by Jonathan Ng on 21/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//
//

import Foundation
import CoreData


extension CorePost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CorePost> {
        return NSFetchRequest<CorePost>(entityName: "CorePost")
    }

    @NSManaged public var createDate: Date?
    @NSManaged public var desc: String?
    @NSManaged public var discount: Double
    @NSManaged public var endDate: Date?
    @NSManaged public var img: String?
    @NSManaged public var normalPrice: Double
    @NSManaged public var postId: Int64
    @NSManaged public var serviceCatId: Int64
    @NSManaged public var serviceDuration: Int64
    @NSManaged public var serviceName: String?
    @NSManaged public var serviceTypeId: Int64
    @NSManaged public var stat_p: Int64
    @NSManaged public var stat_v: Int64
    @NSManaged public var stylistId: Int64
    @NSManaged public var stylists: CoreStylist?

}

extension CorePost : Identifiable {

}
