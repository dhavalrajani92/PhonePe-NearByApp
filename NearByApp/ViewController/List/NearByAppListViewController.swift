//
//  NearByAppListViewController.swift
//  NearByApp
//
//  Created by Dhaval Rajani on 11/25/23.
//

import UIKit

final class NearByAppListViewController: UIViewController {
  private let viewModel: NearByAppListViewModel

  enum Sections: CaseIterable {
    case item
    case loading
  }

  init(viewModel: NearByAppListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    return nil
  }

  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.fetchCallback = { result in
      switch result {
      case .success:
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }

      default:
        break
      }
    }
    setupView()
    registerCells()
  }

  private func registerCells() {
    tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)
  }

  private func setupView() {
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

}

extension NearByAppListViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return Sections.allCases.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let sectionType = Sections.allCases[section]
    switch sectionType {
    case .loading:
      return 1
    case .item:
      return viewModel.venueList.count
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let sectionType = Sections.allCases[indexPath.section]
    switch sectionType {
    case .loading:
      return UITableViewCell()
    case .item:
      let cellData = viewModel.venueList[indexPath.row]
      guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier) as? ItemTableViewCell else {
        return UITableViewCell()
      }
      cell.configure(title: cellData.name, subTitle: cellData.address)
      return cell
    }

  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let sectionType = Sections.allCases[indexPath.section]
    if sectionType == .item && indexPath.row == viewModel.venueList.count - 1 && viewModel.shouldFecthMore {
      viewModel.fetchMoreData()
    }
  }


}
