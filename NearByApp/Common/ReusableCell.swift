//
//  ReusableCell.swift
//  NearByApp
//
//  Created by Dhaval Rajani on 11/25/23.
//

import UIKit

protocol ReusableCell: AnyObject {
  static var identifier: String { get }
}

extension ReusableCell where Self: UIView {
  static var identifier: String {
    return String(describing: self)
  }
}
