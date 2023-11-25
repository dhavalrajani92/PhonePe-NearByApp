//
//  Venues.swift
//  NearByApp
//
//  Created by Dhaval Rajani on 11/25/23.
//

import Foundation

struct Venues: Decodable {
  var venues: [Venue]
  var meta: Meta
}

struct Venue: Decodable {
  var name: String
  var address: String
  var location: Location

  enum CodingKeys: String, CodingKey {
    case name = "name"
    case address = "address"
    case location = "location"
  }
}

struct Location: Decodable {
  var lat: Double
  var lon: Double
}

struct Meta: Decodable {
  var total: Int
  var page: Int
  var perPage: Int

  enum CodingKeys: String, CodingKey {
    case total = "total"
    case page = "page"
    case perPage = "per_page"
  }
}
