//
//  WordCounterViewController.swift
//  SeSACSevenWeek
//
//  Created by Jack on 2/5/25.
//

import UIKit
import SnapKit
 
class WordCounterViewController: UIViewController {
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.cornerRadius = 8
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        return textView
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemBlue
        return label
    }()
    
    private let viewModel = WordCountViewModel()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupTextView()
        bind()
    }
     
    private func setupUI() {
        view.backgroundColor = .white
        
        [textView, countLabel].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(view.snp.width)
        }
    }
    
    private func setupTextView() {
        textView.delegate = self
    }
     
    private func updateCharacterCount() {
        // 여기에 실제 동작을 하는게 아니라 그냥 값만 VM으로 넘겨주기
        viewModel.inputCount.value = textView.text.count
    }
    
    private func bind() {
        // 여기에서 VM의 로직을 통해 나온 output을 다루기
        countLabel.text = viewModel.countLabelText
        
        viewModel.outputText.lazyBind { text in
            self.countLabel.text = text
        }
    }
}
 
extension WordCounterViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateCharacterCount()
    }
}
