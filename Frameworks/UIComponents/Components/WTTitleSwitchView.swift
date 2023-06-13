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
    
    private let animationTimeInterval: TimeInterval = 0.4
    private var animationPoint: CGFloat = 0
    private var animationTimer = Timer()
    
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
        separatorView.font = .systemFont(ofSize: 30, weight: .medium)
      
        separatorView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
        }
    }
    
    func setupFirstLable() {
        addSubview(firstLable)
        
        firstLable.font = .systemFont(ofSize: 30, weight: .medium)
        firstLable.layoutMargins.bottom = 0
        
        firstLable.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview()
            $0.trailing.equalTo(separatorView.snp.leading).offset(-10)
        }
    }
    
    func setupSecondLable() {
        addSubview(secondLable)
        
        secondLable.font = .systemFont(ofSize: 20, weight: .regular)
        secondLable.layoutMargins.bottom = 0
        secondLable.alpha = 0.3
        
        secondLable.snp.makeConstraints {
            $0.leading.equalTo(separatorView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(2.5)
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
        
        UIView.animate(withDuration: animationTimeInterval / 4) {
            self.separatorView.alpha = 0.1
        } completion: { _ in
            UIView.animate(withDuration: self.animationTimeInterval / 4,
                           delay: self.animationTimeInterval / 2) {
                self.separatorView.alpha = 1
            }
        }
        
        UIView.animate(withDuration: animationTimeInterval) {
            activeLable.alpha = 0.3
            inactiveLable.alpha = 1
              
            inactiveLable.snp.remakeConstraints {
                $0.leading.bottom.equalToSuperview()
                $0.trailing.equalTo(self.separatorView.snp.leading).offset(-10)
            }
            
            activeLable.snp.remakeConstraints {
                $0.trailing.equalToSuperview()
                $0.leading.equalTo(self.separatorView.snp.trailing).offset(10)
                $0.bottom.equalToSuperview().inset(2.5)
            }
            
            self.layoutIfNeeded()
        }
        
        animationTimer.invalidate()
        
        animationTimer = Timer.scheduledTimer(withTimeInterval: animationTimeInterval / 25,
                                              repeats: true,
                                              block: { timer in
            if self.animationPoint < 10 {
                self.animationPoint += 0.4
                
                let inactiveSize = 20 + self.animationPoint
                inactiveLable.font = inactiveSize > 25
                ? .systemFont(ofSize: inactiveSize, weight: .medium)
                : .systemFont(ofSize: inactiveSize, weight: .regular)
                
                let activeSize = 30 - self.animationPoint
                activeLable.font = activeSize < 25
                ? .systemFont(ofSize: activeSize, weight: .regular)
                : .systemFont(ofSize: activeSize, weight: .medium)
                
            } else {
                timer.invalidate()
                self.animationPoint = 0
            }
        })
    }
}
