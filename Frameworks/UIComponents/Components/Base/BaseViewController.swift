//
//  BaseViewController.swift
//  UIComponents
//
//  Created by admin1 on 2.04.23.
//

import UIKit

open class BaseViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

extension BaseViewController {
    @objc open func setup() {}
}
