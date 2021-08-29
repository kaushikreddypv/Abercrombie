//
//  Bindable.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/26/21.
//

import UIKit
import Combine

protocol Bindable: AnyObject {
  associatedtype VM: ViewModel
  var viewModel: VM! { get }
  var subscribers: Set<AnyCancellable> { get }
  func set(_ viewModel: VM)
  func setupSubscribers()
}

extension Bindable {
  func setupSubscribers() {}
}
