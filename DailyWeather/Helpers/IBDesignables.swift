//
//  IBDesignables.swift
//  DailyWeather
//
//  Created by Alexander Supe on 20.03.20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit

// MARK: - I'm aware this is bad code, I'll redo it another time
@objc
@IBDesignable class CustomSegmentedControl: UIView {
    @objc private(set) var selectedIndex = 0
    private let buttons = [SegmentButton(), SegmentButton(), SegmentButton()
    ]
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    func sharedInit() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        buttons[0].setTitle("Detail", for: .normal)
        buttons[1].setTitle("Hourly", for: .normal)
        buttons[2].setTitle("Daily", for: .normal)
        for button in buttons {
            stack.addSubview(button)
            button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        }
        selectButton(0)
    }
    
    func selectButton(_ index: Int) {
        for i in 0..<buttons.count {
            if i == index {
                selectedIndex = i
                buttons[i].backgroundColor = .white
                buttons[i].setTitleColor(.systemBlue, for: .normal)
            } else {
                buttons[i].backgroundColor = .clear
                buttons[i].setTitleColor(.white, for: .normal)
            }
        }
    }
    
    @objc func buttonTapped(sender: UIButton) {
        for (i, button) in buttons.enumerated() {
            if button == sender {
                selectButton(i)
                NotificationCenter.default.post(name: NSNotification.Name("SegmentChanged"), object: nil, userInfo: [1:i])
            }
        }
    }
}

@IBDesignable class SegmentButton: UIButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    func sharedInit() {
        layer.cornerRadius = 15
        heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}

