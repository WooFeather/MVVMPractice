//
//  ImageSettingViewModel.swift
//  MVVMPractice
//
//  Created by 조우현 on 2/10/25.
//

import Foundation

final class ImageSettingViewModel: BaseViewModel {
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        // viewWillDisappear될 때 NotificationCenter를 통해 이미지를 넘겨주기
        let previewImage: Observable<ProfileImageView?> = Observable(nil)
        // cell을 탭했을 때 알리기
        let cellSelected: Observable<ProfileImage?> = Observable(nil)
    }
    
    struct Output {
        // settingView에 있던 랜덤으로 설정된 이미지를 view에 보여주기 위함
        let receiveImage: Observable<ProfileImageView?> = Observable(nil)
        // cell을 탭했다는 사실을 돌려주기 위함, input으로 온 이미지를 view에 보여주기
        let cellSelected: Observable<ProfileImage?> = Observable(nil)
    }
    
    // MARK: - Initializer
    init() {
        print("ImageSettingViewModel Init")
        
        input = Input()
        output = Output()
        transform()
    }
    
    deinit {
        print("ImageSettingViewModel Deinit")
    }
    
    // MARK: - Functions
    func transform() {
        input.cellSelected.bind { [weak self] _ in
            self?.output.cellSelected.value = self?.input.cellSelected.value
        }
        
        input.previewImage.bind { [weak self] _ in
            self?.saveImage()
        }
    }
    
    private func saveImage() {
        guard let imageValue = input.previewImage.value?.image else { return }
        NotificationCenter.default.post(
            name: NSNotification.Name("ImageReceived"),
            object: nil,
            userInfo: [
                "image": imageValue
            ]
        )
    }
}
