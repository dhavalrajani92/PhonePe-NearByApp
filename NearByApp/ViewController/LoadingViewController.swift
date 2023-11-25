//
//  LoadingViewController.swift
//  NearByApp
//
//  Created by Dhaval Rajani on 11/25/23.
//

import UIKit

final class LoadingViewController: UIViewController {

  private lazy var loadingView: UIActivityIndicatorView = {
    let loadingView = UIActivityIndicatorView()
    loadingView.translatesAutoresizingMaskIntoConstraints = false
    return loadingView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
  }

  private func setupView() {
    view.addSubview(loadingView)
    view.backgroundColor = .white

    NSLayoutConstraint.activate([
      loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      loadingView.widthAnchor.constraint(equalToConstant: 100),
      loadingView.heightAnchor.constraint(equalToConstant: 100)
    ])
  }

  func startAnimating() {
    loadingView.startAnimating()
  }

  func stopAnimating() {
    loadingView.stopAnimating()
  }
}
