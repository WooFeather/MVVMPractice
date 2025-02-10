//
//  CurrencyViewController.swift
//  SeSACSevenWeek
//
//  Created by Jack on 2/5/25.
//

import UIKit
import SnapKit

class CurrencyViewController: UIViewController {
    
    private lazy var exchangeRateLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.exchangeRateLabelText
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = viewModel.amountTextFieldPlaceHolder
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        return textField
    }()
    
    private lazy var convertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(viewModel.convertButtonTitle, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.resultLabelText
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let viewModel = CurrencyViewModel()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        bind()
    }
     
    private func setupUI() {
        view.backgroundColor = .white
        
        [exchangeRateLabel, amountTextField, convertButton, resultLabel].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        exchangeRateLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(exchangeRateLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        convertButton.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(convertButton.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupActions() {
        convertButton.addTarget(self, action: #selector(convertButtonTapped), for: .touchUpInside)
    }
     
    @objc private func convertButtonTapped() {
        // 여기서 실제 동작을 하는게 아니라 그냥 값만 VM으로 넘겨주기
        viewModel.inputText.value = amountTextField.text
    }
    
    private func bind() {
        // 여기에서 VM의 로직을 통해 나온 output을 다루기
        // lazyBind 사용해보기
        viewModel.outputText.lazyBind { text in
            self.resultLabel.text = text
        }
        
        viewModel.outputTextColor.lazyBind { color in
            self.resultLabel.textColor = color ? .blue : .red
        }
    }
}
