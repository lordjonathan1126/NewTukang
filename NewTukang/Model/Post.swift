/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Post : Codable {
	let postID : Int?
	let img : String?
	let imgs : [Int]?
	let createDate : Date?
	let endDate : Date?
	let stylistID : Int?
	let price : Price?
	let service : Service?
	let stat : Stat?
	let notes : Notes?

	enum CodingKeys: String, CodingKey {

		case postID = "postID"
		case img = "img"
		case imgs = "imgs"
		case createDate = "createDate"
		case endDate = "endDate"
		case stylistID = "stylistID"
		case price = "price"
		case service = "service"
		case stat = "stat"
		case notes = "notes"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		postID = try values.decodeIfPresent(Int.self, forKey: .postID)
		img = try values.decodeIfPresent(String.self, forKey: .img)
		imgs = try values.decodeIfPresent([Int].self, forKey: .imgs)
		createDate = try values.decodeIfPresent(Date.self, forKey: .createDate)
		endDate = try values.decodeIfPresent(Date.self, forKey: .endDate)
		stylistID = try values.decodeIfPresent(Int.self, forKey: .stylistID)
		price = try values.decodeIfPresent(Price.self, forKey: .price)
		service = try values.decodeIfPresent(Service.self, forKey: .service)
		stat = try values.decodeIfPresent(Stat.self, forKey: .stat)
		notes = try values.decodeIfPresent(Notes.self, forKey: .notes)
	}

}
