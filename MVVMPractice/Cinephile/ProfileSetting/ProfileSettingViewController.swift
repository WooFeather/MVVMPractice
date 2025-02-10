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
        viewModel.input.viewDidLoadTrigger.value = profileSettingView.profileImageView
        
        viewModel.output.profileImageNotification.bind { value in
            if let image = value?.userInfo!["image"] as? UIImage {
                self.profileSettingView.profileImageView.image = image
            }
        }
        
        viewModel.output.statusLabelText.bind { text in
            self.profileSettingView.statusLabel.text = text
        }
        
        viewModel.output.textValidation.bind { status in
            self.profileSettingView.statusLabel.textColor = status ? .cineConditionBlue : .cineConditionRed
            self.isNicknameValidate = status
        }
        
        viewModel.output.doneButtonTapped.lazyBind { _ in
            let vc = MainViewController()
            self.changeRootViewController(vc: vc)
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
    
    // MARK: - Actions
    @objc
    private func profileImageTapped() {
        let vc = ImageSettingViewController()
        vc.viewModel.output.receiveImage.value = profileSettingView.profileImageView
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func nicknameTextFieldEditingChanged() {
        viewModel.input.nicknameTextFieldEditingChanged.value = profileSettingView.nicknameTextField.text

        // TODO: 이부분 로직도 빼기
        profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
    }
    
    @objc
    private func doneButtonTapped() {
        viewModel.input.doneButtonTapped.value = ()
    }
    
    // TODO: MBTI 버튼 로직 빼기
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
