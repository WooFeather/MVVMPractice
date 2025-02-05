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
        
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        outputText.value = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
