//
//  BaseView.swift
//  UIComponents
//
//  Created by admin1 on 2.04.23.
//

import UIKit

open class BaseView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required public init?(coder: NSCoder) {
        super.init(frame: .zero)

        setup()
    }
}

extension BaseView {
    @objc func setup() {}
}
