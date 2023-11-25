//
//  NearByAppFlowViewModel.swift
//  NearByApp
//
//  Created by Dhaval Rajani on 11/25/23.
//

import Foundation
import CoreLocation

final class NearByAppFlowViewModel: Fetching {
  private let networkEngine: ApiProtocol

  var allVenues: Venues? = nil
  var currentLat: CLLocationDegrees? = nil
  var currentLong: CLLocationDegrees? = nil

  init(networkEngine: ApiProtocol) {
    self.networkEngine = networkEngine
  }
  var fetchState: FetchState = .none {
    didSet {
      notifyObserver()
    }
  }

  var fetchCallback: ((FetchState) -> Void)?

  var listViewModel: NearByAppListViewModel? {
    guard let allVenues = allVenues else { return nil }
    return NearByAppListViewModel(allVenues: allVenues, networkEngine: networkEngine, currentLat: currentLat?.description, currentLong: currentLong?.description)
  }

  func fetchAllVenues() {
    fetchState = .inProgress
    var query = [
      URLQueryItem(name: "per_page", value: "10"),
      URLQueryItem(name: "page", value: "1")
    ]

    if let lat = currentLat, let long = currentLong {
      query.append(URLQueryItem(name: "lat", value: lat.description))
      query.append(URLQueryItem(name: "lon", value: long.description))
    }

    networkEngine.request(endpoint: NearByAppEndpoint.getAllVenues(query: query)) { (result: Result<Venues, Error>) in
      switch result {
      case.success(let venues):
        self.allVenues = venues
        self.fetchState = .success
      case .failure(let error):
        self.fetchState = .failure(error)
      }
    }
  }
}
