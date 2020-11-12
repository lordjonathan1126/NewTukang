//
//  FetchedCorePost.swift
//  NewTukang
//
//  Created by Jonathan Ng on 02/11/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import Foundation

struct FetchedCorePost :Codable{
    let createDate: Date?
    let desc: String?
    let discount: Double
    let endDate: Double
    let img: String?
    let imgs: [String]?
    let normalPrice: Double
    let postId: Int64
    let serviceCatId: Int
    let serviceDuration: Int
    let serviceName: String?
    let serviceTypeId: Int
    let stat_p: Int
    let stat_v: Int
    let stylistId: Int64
    let trending: Double
    let distance: Double
}
