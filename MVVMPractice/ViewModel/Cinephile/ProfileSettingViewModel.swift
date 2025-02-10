//
//  ProfileSettingViewModel.swift
//  MVVMPractice
//
//  Created by 조우현 on 2/10/25.
//

import Foundation

final class ProfileSettingViewModel: BaseViewModel {
    private(set) var input: Input
    private(set) var output: Output
    // view의 배열을 여기에 만들기?
    
    struct Input {
        let viewDidLoadTrigger: Observable<ProfileImageView?> = Observable(nil)
        let nicknameTextFieldEditingChanged: Observable<String?> = Observable(nil)
        let doneButtonTapped: Observable<Void?> = Observable(nil)
    }
    
    struct Output {
        let viewDidLoadTrigger: Observable<Void?> = Observable(nil)
        let profileImageNotification: Observable<NSNotification?> = Observable(nil)
        // isDoneButtonEnabled의 조건과 statusLabel의 textColor에서도 사용될 예정
        let textValidation: Observable<Bool> = Observable(false)
        let statusLabelText: Observable<String?> = Observable("")
        let doneButtonTapped: Observable<Void?> = Observable(nil)
    }
    
    // MARK: - Initializer
    init() {
        print("ProfileSettingViewModel Init")
        
        input = Input()
        output = Output()
        transform()
    }
    
    deinit {
        print("ProfileSettingViewModel Denit")
    }
    
    // MARK: - Functions
    func transform() {
        input.viewDidLoadTrigger.bind { _ in
            self.receiveImage()
            self.output.viewDidLoadTrigger.value = ()
        }
        
        input.nicknameTextFieldEditingChanged.bind { _ in
            self.validateText()
        }
        
        input.doneButtonTapped.bind { _ in
            self.output.doneButtonTapped.value = ()
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
    private func imageReceivedNotification(value: NSNotification) {
        output.profileImageNotification.value = value
    }
    
    private func validateText() {
        guard let text = input.nicknameTextFieldEditingChanged.value else { return }
        let trimmingText = text.trimmingCharacters(in: .whitespaces)
        
        // 숫자가 포함되어있는지 확인하는법
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = trimmingText.rangeOfCharacter(from: decimalCharacters)
        // 위의 코드를 참고해 특수문자도 적용
        let spacialRange = trimmingText.rangeOfCharacter(from: ["@", "#", "$", "%"])
        
        if trimmingText.count < 2 || trimmingText.count > 10 {
            output.statusLabelText.value = "2글자 이상 10글자 미만으로 설정해주세요"
            output.textValidation.value = false
        } else if spacialRange != nil {
            output.statusLabelText.value = "닉네임에 @, #, $, % 는 포함될 수 없어요"
            output.textValidation.value = false
        } else if decimalRange != nil {
            output.statusLabelText.value = "닉네임에 숫자는 포함할 수 없어요"
            output.textValidation.value = false
        } else {
            output.statusLabelText.value = "사용할 수 있는 닉네임이에요"
            output.textValidation.value = true
        }
    }
}
