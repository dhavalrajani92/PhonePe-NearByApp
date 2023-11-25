//
//  NearByAppListViewModel.swift
//  NearByApp
//
//  Created by Dhaval Rajani on 11/25/23.
//

import Foundation

final class NearByAppListViewModel: Fetching {
  var fetchState: FetchState = .none {
    didSet {
      notifyObserver()
    }
  }

  var fetchCallback: ((FetchState) -> Void)?

  var allVenues: Venues
  var venueList: [Venue] = []
  private (set) var isLoading: Bool = false
  private let networkEngine: ApiProtocol
  private let currentLat: String?
  private let currentLong: String?
  
  init(allVenues: Venues,
       networkEngine: ApiProtocol,
       currentLat: String?,
       currentLong: String?){
    self.allVenues = allVenues
    self.venueList = allVenues.venues
    self.networkEngine = networkEngine
    self.currentLat = currentLat
    self.currentLong = currentLong
  }

  enum Constants {
    static let defaultPageSize = "10"
  }

  var totalData: Int {
    return allVenues.meta.total
  }

  var currentPageNumber: Int {
    allVenues.meta.page
  }

  var shouldFecthMore: Bool {
    if !isLoading && allVenues.venues.count < totalData {
      return true
    }
    return false
  }

  func fetchMoreData() {
    isLoading = true
    var queryParams = [
      URLQueryItem(name: "page", value: String(currentPageNumber + 1)),
      URLQueryItem(name: "per_page", value: Constants.defaultPageSize)
    ]
    fetchState = .inProgress
    networkEngine.request(endpoint: NearByAppEndpoint.getAllVenues(query: queryParams)) { (result: Result<Venues, Error>) in
      switch result {
      case .success(let data):
        self.venueList.append(contentsOf: data.venues)
        self.isLoading = false
        self.fetchState = .success
      case .failure(let failure):
        print(failure.localizedDescription)
        self.isLoading = false
        self.fetchState = .failure(failure)
      }
    }
  }
}
