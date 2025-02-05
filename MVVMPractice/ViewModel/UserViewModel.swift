//
//  UserViewModel.swift
//  MVVMPractice
//
//  Created by 조우현 on 2/5/25.
//

import Foundation

class UserViewModel {
    
    var people: Observable<[Person]> = Observable([])
    var loadButtonTapped = Observable(())
    var resetButtonTapped = Observable(())
    var addButtonTapped = Observable(())
    // TODO: NavigationTitle이나 Button의 타이틀도 여기서 설정해보기
    // TODO: TableView에 더미데이터 하나 들어있는거 해결..?
    
    init() {
        loadButtonTapped.bind { _ in
            self.load()
        }
        
        resetButtonTapped.bind { _ in
            self.reset()
        }
        
        addButtonTapped.bind { _ in
            self.add()
        }
    }
    
    private func load() {
        people.value = [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
    
    private func reset() {
        people.value.removeAll()
    }
    
    private func add() {
        let names = ["James", "Mary", "John", "Patricia", "Robert", "Jennifer", "Michael", "Linda", "William", "Elizabeth", "David", "Barbara", "Richard", "Susan", "Joseph", "Jessica", "Thomas", "Sarah", "Charles", "Karen"]
        let user = Person(name: names.randomElement()!, age: Int.random(in: 20...70))
        people.value.append(user)
    }
}
