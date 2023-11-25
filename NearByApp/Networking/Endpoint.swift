//
//  Endpoint.swift
//  NearByApp
//
//  Created by Dhaval Rajani on 11/25/23.
//

import Foundation

protocol Endpoint {
  var scheme: String { get }
  var baseUrl: String { get }
  var path: String { get }
  var parameters: [URLQueryItem] { get }
  var method: String { get }
}

