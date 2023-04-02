//
//  ViewController.swift
//  iDeluxeApp
//
//  Created by admin1 on 2.04.23.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    private let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        view.addSubview(button)
        button.backgroundColor = .green
        
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(100)
            
        }
    }


}

