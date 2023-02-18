//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

// removeDuplicates
let words = "hey hey there! Mr Mr ?"
    .components(separatedBy: " ")
    .publisher

words
    .removeDuplicates()     // 중복 제거
    .sink { value in
        print(value)
    }.store(in: &subscriptions) // 여러 subscription을 위의 하나의 통에 저장하는 방식

// compactMap
let strings = ["a", "1.24", "3", "dfd", "45", "0.334"].publisher

strings
    .compactMap { Float($0) }   // 변환
    .sink { value in
        print(value)
    }.store(in: &subscriptions)

// ignoreOutput
let numbers = (1...10_000).publisher

numbers
    .ignoreOutput()     // data 무시
    .sink(receiveCompletion: { print("Completed with: \($0)") }, receiveValue: { print($0) })
    .store(in: &subscriptions)


// prefix

let tens = (1...10).publisher

tens
    .prefix(5)      // 괄호 안에 까지만 받기
    .sink(receiveCompletion: { print("Completed with: \($0)") }, receiveValue: { print($0) })
    .store(in: &subscriptions)

//: [Next](@next)
