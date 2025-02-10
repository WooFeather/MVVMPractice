//
//  ActionButton.swift
//  MVVMPractice
//
//  Created by 조우현 on 2/10/25.
//

import UIKit

class ActionButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(.cineWhite, for: .normal)
        setTitleColor(.cineSecondaryGray, for: .disabled)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        layer.cornerRadius = 22
    }
    
    override var isEnabled: Bool {
        didSet {
            if self.isEnabled {
                backgroundColor = .cineConditionBlue
            } else {
                backgroundColor = .cineConditionGray
            }
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
