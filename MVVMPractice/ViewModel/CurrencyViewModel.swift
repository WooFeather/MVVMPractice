//
//  CurrencyViewModel.swift
//  MVVMPractice
//
//  Created by 조우현 on 2/5/25.
//

import Foundation

class CurrencyViewModel {
    
    let inputText: Observable<String?> = Observable(nil)
    let outputText = Observable("")
    // TODO: Label에 표시되는 기본값도 여기서 설정해보기
    // TODO: 환전하기 버튼 비활성화도 구현해보기
    // TODO: Label의 textColor도 적용해보기
    
    init() {
        inputText.bind { _ in
            self.convertCurrency()
        }
    }
    
    private func convertCurrency() {
        guard let amountText = inputText.value,
              let amount = Double(amountText) else {
            outputText.value = "올바른 금액을 입력해주세요"
            return
        }
        
        // TODO: 실시간 환율 API 적용해보기??
        let exchangeRate = 1444.5
        let convertedAmount = amount / exchangeRate
        outputText.value = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
