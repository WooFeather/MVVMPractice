//
//  BaseViewController.swift
//  MVVMPractice
//
//  Created by 조우현 on 2/10/25.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cineWhite
        
        configureView()
        configureEssential()
        configureAction()
        bindData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func configureView() { }
    
    func configureEssential() { }
    
    func configureAction() { }
    
    func bindData() { }
}
