//
//  ItemTableViewCell.swift
//  NearByApp
//
//  Created by Dhaval Rajani on 11/25/23.
//

import UIKit

final class ItemTableViewCell: UITableViewCell, ReusableCell {
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }

  required init?(coder: NSCoder) {
    return nil
  }

  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    return stackView
  }()

  private lazy var verticalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 10
    return stackView
  }()

  private lazy var title: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    return label
  }()

  private lazy var subTitle: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    return label
  }()

  private func setupView() {
    contentView.addSubview(stackView)
    stackView.addArrangedSubview(verticalStackView)

    verticalStackView.addArrangedSubview(title)
    verticalStackView.addArrangedSubview(subTitle)

    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
    ])
  }

  func configure(title: String, subTitle: String) {
    self.title.text = title
    self.subTitle.text = subTitle
  }
}
