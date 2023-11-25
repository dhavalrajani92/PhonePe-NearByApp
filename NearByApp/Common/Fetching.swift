//
//  Fetching.swift
//  NearByApp
//
//  Created by Dhaval Rajani on 11/25/23.
//

import Foundation

protocol Fetching {
  var fetchState: FetchState { get set }
  var fetchCallback: ((FetchState)->Void)? { get set }
}

enum FetchState {
  case inProgress
  case success
  case failure(Error)
  case none
}

extension Fetching {
  func notifyObserver() {
    fetchCallback?(fetchState)
  }
}
