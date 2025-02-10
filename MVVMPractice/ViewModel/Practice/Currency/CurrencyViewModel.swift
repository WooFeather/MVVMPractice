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
    
    let exchangeRateLabelText = "현재 환율: 1 USD = 1,444 KRW"
    let amountTextFieldPlaceHolder = "원화 금액을 입력하세요"
    let convertButtonTitle = "환전하기"
    let resultLabelText = "환전 결과가 여기에 표시됩니다"
    
    // Label의 textColor 적용
    let outputTextColor = Observable(false)
    
    init() {
        inputText.bind { _ in
            self.convertCurrency()
        }
    }
    
    private func convertCurrency() {
        guard let amountText = inputText.value,
              let amount = Double(amountText) else {
            outputText.value = "올바른 금액을 입력해주세요"
            outputTextColor.value = false
            return
        }
        
        // TODO: 실시간 환율 API 적용해보기??
        let exchangeRate = 1444.5
        let convertedAmount = amount / exchangeRate
        outputText.value = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
        outputTextColor.value = true
    }
}
