//
//  BaseViewModel.swift
//  MVVMPractice
//
//  Created by 조우현 on 2/10/25.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    func transform()
}
