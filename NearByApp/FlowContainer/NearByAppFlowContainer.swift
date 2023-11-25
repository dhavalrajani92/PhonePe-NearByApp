//
//  NearByAppFlowContainer.swift
//  NearByApp
//
//  Created by Dhaval Rajani on 11/25/23.
//

import UIKit
import CoreLocation

final class NearByAppFlowContainer: NSObject {
  private let navController: UINavigationController
  private let viewModel: NearByAppFlowViewModel

  private lazy var initialController: UIViewController = {
    guard let listViewModel = viewModel.listViewModel else { return UIViewController() }
    let viewController = NearByAppListViewController(viewModel: listViewModel)
    return viewController
  }()

  private lazy var loadingViewController: LoadingViewController = {
    let viewController = LoadingViewController()
    return viewController
  }()

  init(navController: UINavigationController, viewModel: NearByAppFlowViewModel) {
    self.navController = navController
    self.viewModel = viewModel
    super.init()
    viewModel.fetchCallback = { fetchState in
      switch fetchState {
      case .success:
        DispatchQueue.main.async {
          self.resetRootViewController()
        }

      case .inProgress:
        DispatchQueue.main.async {
          self.showLoadingViewController()
        }
      case .failure(let error):
        print(error.localizedDescription)
      default:
        break
      }
    }
    let locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    DispatchQueue.global(qos: .userInteractive).async {
      if CLLocationManager.locationServicesEnabled() {
        locationManager.startUpdatingLocation()
        self.viewModel.currentLat = locationManager.location?.coordinate.latitude
        self.viewModel.currentLong = locationManager.location?.coordinate.longitude
        viewModel.fetchAllVenues()
      }
    }


  }

  private func resetRootViewController() {
    DispatchQueue.main.async {
      self.navController.viewControllers = [self.initialController]
    }
  }

  private func showLoadingViewController() {
    DispatchQueue.main.async {
      self.navController.viewControllers = [self.loadingViewController]
    }
    loadingViewController.startAnimating()
  }
}

extension NearByAppFlowContainer: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      let userLocation :CLLocation = locations[0] as CLLocation

      print("user latitude = \(userLocation.coordinate.latitude)")
      print("user longitude = \(userLocation.coordinate.longitude)")

    viewModel.currentLat = userLocation.coordinate.latitude
    viewModel.currentLong = userLocation.coordinate.longitude

  }
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print("Error \(error)")
  }

}
