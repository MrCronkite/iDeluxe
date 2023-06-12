//
//  WTTitleSwitchView.swift
//  UIComponents
//
//  Created by admin1 on 2.04.23.
//

import UIKit
import SnapKit

extension WTTitleSwitchView {
    public enum ActivityState {
        case left
        case right
        
        mutating func toggle() {
            self = self == .left ? .right : .left
        }
    }
}

open class WTTitleSwitchView: BaseView {
    private let firstLable = UILabel()
    private let secondLable = UILabel()
    
    private let separatorView = UILabel()
    
    private let button = UIButton()
    
    private let animatiomTimeInterval: TimeInterval = 0.3
    
    public var state = ActivityState.left {
        didSet {
            animateStateSetting()
        }
    }
    
    public var titles: (firstTitle: String, secondTitle: String)? = nil {
        didSet {
            firstLable.text = titles?.firstTitle
            secondLable.text = titles?.secondTitle
        }
    }
    
    override func setup() {
        super.setup()
        
        setupSeparatorView()
        setupFirstLable()
        setupSecondLable()
        setupButton()
        
    }
}

// MARK: - Setup UI
private extension WTTitleSwitchView {
    func setupSeparatorView() {
        addSubview(separatorView)
        
        separatorView.text = "/"
        
        separatorView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
        }
    }
    
    func setupFirstLable() {
        addSubview(firstLable)
        
        firstLable.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview()
            $0.trailing.equalTo(separatorView.snp.leading).offset(-10)
        }
    }
    
    func setupSecondLable() {
        addSubview(secondLable)
        
        secondLable.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.leading.equalTo(separatorView.snp.leading).offset(10)
        }
    }
    
    func setupButton() {
        addSubview(button)
        
        button.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

public extension WTTitleSwitchView {
    @IBAction func buttonHandler() {
        state.toggle()
    }
}

private extension WTTitleSwitchView {
    func animateStateSetting() {
        let activeLable = state == .left ? secondLable : firstLable
        let inactiveLable = state == .left ? firstLable : secondLable
        
        UIView.animate(withDuration: animatiomTimeInterval / 4) {
            self.separatorView.alpha = 0.1
        } completion: { _ in
            UIView.animate(withDuration: self.animatiomTimeInterval / 4,
                           delay: self.animatiomTimeInterval / 2) {
                self.separatorView.alpha = 1
            }
        }
        
        UIView.animate(withDuration: animatiomTimeInterval / 2) {
            activeLable.alpha = 0.3
            inactiveLable.alpha = 1
            
            inactiveLable.snp.remakeConstraints {
                $0.leading.bottom.equalToSuperview()
                $0.trailing.equalTo(self.separatorView.snp.leading).offset(-10)
            }
            
            activeLable.snp.remakeConstraints {
                $0.leading.equalTo(self.separatorView.snp.trailing).offset(10)
                $0.trailing.bottom.equalToSuperview()
            }
            self.layoutIfNeeded()
        }
        
    }
}
