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
        
        // 인스턴스 생성시 위의 bind가 모두 실행돼서 배열에 무언가 담겨있는 상태로 앱이 시작함 => 그걸 방지하기 위해 빈배열로 초기화해줌
        people.value = []
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
