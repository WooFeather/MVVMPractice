//
//  OnboardingViewController.swift
//  MVVMPractice
//
//  Created by 조우현 on 2/10/25.
//

import UIKit

final class OnboardingViewController: BaseViewController {
    private var onboardingView = OnboardingView()
    
    override func loadView() {
        view = onboardingView
    }
    
    override func configureEssential() {
        onboardingView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func startButtonTapped() {
        print(#function)
        let vc = ProfileSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
