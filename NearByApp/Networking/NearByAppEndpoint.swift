//
//  NearByAppEndpoint.swift
//  NearByApp
//
//  Created by Dhaval Rajani on 11/25/23.
//

import Foundation

enum NearByAppEndpoint: Endpoint {
  case getAllVenues(query: [URLQueryItem])

  var scheme: String {
    switch self {
    default:
      return "https"
    }
  }

  var baseUrl: String {
    return "api.seatgeek.com"
  }

  var path: String {
    switch self {
    case .getAllVenues:
      return "/2/venues"
    }
  }

  var parameters: [URLQueryItem] {
    switch self {
    case .getAllVenues(let query):
      return query
    }
  }

  var method: String {
    switch self {
    case .getAllVenues:
      return "GET"
    }
  }

}

