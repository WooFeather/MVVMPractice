//
//  ProfileSettingViewController.swift
//  MVVMPractice
//
//  Created by 조우현 on 2/10/25.
//

import UIKit

final class ProfileSettingViewController: BaseViewController {
    
    private var profileSettingView = ProfileSettingView()
    private let viewModel = ProfileSettingViewModel()
    
    // MARK: - Functions
    override func loadView() {
        view = profileSettingView
    }
    
    override func configureEssential() {
        profileSettingView.nicknameTextField.delegate = self
        receiveImage()
    }
    
    override func configureAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileSettingView.profileImageView.addGestureRecognizer(tapGesture)
        profileSettingView.profileImageView.isUserInteractionEnabled = true
        
        profileSettingView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        profileSettingView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldEditingChanged), for: .editingChanged)
        profileSettingView.mbtiEButton.addTarget(self, action: #selector(mbtiEButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiIButton.addTarget(self, action: #selector(mbtiIButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiSButton.addTarget(self, action: #selector(mbtiSButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiNButton.addTarget(self, action: #selector(mbtiNButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiTButton.addTarget(self, action: #selector(mbtiTButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiFButton.addTarget(self, action: #selector(mbtiFButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiJButton.addTarget(self, action: #selector(mbtiJButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiPButton.addTarget(self, action: #selector(mbtiPButtonTapped), for: .touchUpInside)
    }
    
    override func configureView() {
        navigationItem.title = "프로필 설정"
    }
    
    override func bindData() {
        
    }
    
    private func validateText() {
        guard let trimmingText = profileSettingView.nicknameTextField.text?.trimmingCharacters(in: .whitespaces) else { return }
        
        // 숫자가 포함되어있는지 확인하는법
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = trimmingText.rangeOfCharacter(from: decimalCharacters)
        // 위의 코드를 참고해 특수문자도 적용
        let spacialRange = trimmingText.rangeOfCharacter(from: ["@", "#", "$", "%"])
        
        if trimmingText.count < 2 || trimmingText.count > 10 {
            profileSettingView.statusLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
            profileSettingView.doneButton.isEnabled = false
        } else if spacialRange != nil {
            profileSettingView.statusLabel.text = "닉네임에 @, #, $, % 는 포함될 수 없어요"
            profileSettingView.doneButton.isEnabled = false
        } else if decimalRange != nil {
            profileSettingView.statusLabel.text = "닉네임에 숫자는 포함할 수 없어요"
            profileSettingView.doneButton.isEnabled = false
        } else {
            profileSettingView.statusLabel.text = "사용할 수 있는 닉네임이에요"
            profileSettingView.doneButton.isEnabled = true
        }
    }
    
    // MARK: - Actions
    @objc
    private func profileImageTapped() {
        let vc = ImageSettingViewController()
        vc.viewModel.output.receiveImage.value = profileSettingView.profileImageView
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func nicknameTextFieldEditingChanged() {
        validateText()
    }
    
    @objc
    private func doneButtonTapped() {
        let vc = MainViewController()
        changeRootViewController(vc: vc)
    }
    
    @objc
    private func imageReceivedNotification(value: NSNotification) {
        if let image = value.userInfo!["image"] as? UIImage {
            profileSettingView.profileImageView.image = image
        }
    }
    
    private func receiveImage() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(imageReceivedNotification),
            name: NSNotification.Name("ImageReceived"),
            object: nil
        )
    }
    
    @objc
    private func mbtiEButtonTapped(_ sender: UIButton) {
        print(#function)
        // isSelected의 true false의 값을 Bool타입으로 넘겨받으면 되겠따
    }
    
    @objc
    private func mbtiIButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
    @objc
    private func mbtiSButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
    @objc
    private func mbtiNButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
    @objc
    private func mbtiTButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
    @objc
    private func mbtiFButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
    @objc
    private func mbtiJButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
    @objc
    private func mbtiPButtonTapped(_ sender: UIButton) {
        print(#function)
    }
}

// MARK: - Extension
extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
