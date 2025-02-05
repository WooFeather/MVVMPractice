//
//  WordCountViewModel.swift
//  MVVMPractice
//
//  Created by 조우현 on 2/5/25.
//

import Foundation

class WordCountViewModel {
    
    let inputCount: Observable<Int?> = Observable(nil)
    let outputText = Observable("")
    // TODO: Label에 표시되는 기본값도 여기서 설정해보기
    
    init() {
        inputCount.bind { _ in
            self.updateCharacterCount()
        }
    }
    
    private func updateCharacterCount() {
        guard let count = inputCount.value else {
            outputText.value = "글자를 입력해주세요."
            return
        }

        outputText.value = "현재까지 \(count)글자 작성중"
    }
}
