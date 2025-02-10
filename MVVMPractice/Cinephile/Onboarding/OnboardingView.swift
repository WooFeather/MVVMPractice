//
//  OnboardingView.swift
//  MVVMPractice
//
//  Created by 조우현 on 2/10/25.
//

import UIKit
import SnapKit

final class OnboardingView: BaseView {
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    let startButton = ActionButton(title: "시작하기")
    
    override func configureHierarchy() {
        [titleLabel, descriptionLabel, startButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(-18)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(35)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(40)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        titleLabel.text = "Cinephile"
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        
        descriptionLabel.text = "당신만의 영화 세상,\nCinephile을 시작해보세요."
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .cinePrimaryGray
        
        startButton.isEnabled = true
    }
}
