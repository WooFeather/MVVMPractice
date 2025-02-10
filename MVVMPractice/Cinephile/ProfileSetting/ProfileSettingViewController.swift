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
    private var isNicknameValidate = false
    private var isButtonValidate = false
    private var buttonArray: [UIButton] = []
    
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
        profileSettingView.mbtiEButton.addTarget(self, action: #selector(mbtiEIButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiIButton.addTarget(self, action: #selector(mbtiEIButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiSButton.addTarget(self, action: #selector(mbtiSNButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiNButton.addTarget(self, action: #selector(mbtiSNButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiTButton.addTarget(self, action: #selector(mbtiTFButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiFButton.addTarget(self, action: #selector(mbtiTFButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiJButton.addTarget(self, action: #selector(mbtiJPButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiPButton.addTarget(self, action: #selector(mbtiJPButtonTapped), for: .touchUpInside)
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
            profileSettingView.statusLabel.textColor = .cineConditionRed
            isNicknameValidate = false
        } else if spacialRange != nil {
            profileSettingView.statusLabel.text = "닉네임에 @, #, $, % 는 포함될 수 없어요"
            profileSettingView.statusLabel.textColor = .cineConditionRed
            isNicknameValidate = false
        } else if decimalRange != nil {
            profileSettingView.statusLabel.text = "닉네임에 숫자는 포함할 수 없어요"
            profileSettingView.statusLabel.textColor = .cineConditionRed
            isNicknameValidate = false
        } else {
            profileSettingView.statusLabel.text = "사용할 수 있는 닉네임이에요"
            profileSettingView.statusLabel.textColor = .cineConditionBlue
            isNicknameValidate = true
        }
    }
    
    private func toggleButton(_ sender: UIButton, array: [UIButton]) {
        for i in array {
            if i == sender {
                if !i.isSelected {
                    i.isSelected = true
                } else {
                    i.isSelected = false
                }
            } else {
                i.isSelected = false
            }
        }
    }
    
    private func validateButton() {
        if (profileSettingView.mbtiEButton.isSelected || profileSettingView.mbtiIButton.isSelected) &&
            (profileSettingView.mbtiSButton.isSelected || profileSettingView.mbtiNButton.isSelected) &&
            (profileSettingView.mbtiTButton.isSelected || profileSettingView.mbtiFButton.isSelected) &&
            (profileSettingView.mbtiJButton.isSelected || profileSettingView.mbtiPButton.isSelected) {
            isButtonValidate = true
        } else {
            isButtonValidate = false
        }
    }
    
    private func isDoneButtonEnabled() -> Bool {
        if isNicknameValidate && isButtonValidate {
            return true
        } else {
            return false
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
        profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
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
    
    @objc
    private func mbtiEIButtonTapped(_ sender: UIButton) {
        buttonArray = [profileSettingView.mbtiEButton, profileSettingView.mbtiIButton]
        toggleButton(sender, array: buttonArray)
        validateButton()
        profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
    }
    
    @objc
    private func mbtiSNButtonTapped(_ sender: UIButton) {
        buttonArray = [profileSettingView.mbtiSButton, profileSettingView.mbtiNButton]
        toggleButton(sender, array: buttonArray)
        validateButton()
        profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
    }
    
    @objc
    private func mbtiTFButtonTapped(_ sender: UIButton) {
        buttonArray = [profileSettingView.mbtiTButton, profileSettingView.mbtiFButton]
        toggleButton(sender, array: buttonArray)
        validateButton()
        profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
    }
    
    @objc
    private func mbtiJPButtonTapped(_ sender: UIButton) {
        buttonArray = [profileSettingView.mbtiJButton, profileSettingView.mbtiPButton]
        toggleButton(sender, array: buttonArray)
        validateButton()
        profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
    }
}

// MARK: - Extension
extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
