//
//  MainViewController.swift
//  MVVMPractice
//
//  Created by 조우현 on 2/10/25.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {
    private let titleLabel = UILabel()
    private let resignButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MainViewController Init")
        configureLayout()
    }
    
    override func configureEssential() {
        view.addSubview(titleLabel)
        view.addSubview(resignButton)
        
        resignButton.addTarget(self, action: #selector(resignButtonTapped), for: .touchUpInside)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(20)
        }
        
        resignButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalTo(titleLabel.snp.centerX)
            make.height.equalTo(20)
        }
    }
    
    override func configureView() {
        titleLabel.text = "메인화면"
        resignButton.setTitle("탈퇴하기", for: .normal)
        resignButton.setTitleColor(.cineAccent, for: .normal)
    }
    
    @objc
    private func resignButtonTapped() {
        let vc = UINavigationController(rootViewController: OnboardingViewController())
        changeRootViewController(vc: vc)
    }
}
