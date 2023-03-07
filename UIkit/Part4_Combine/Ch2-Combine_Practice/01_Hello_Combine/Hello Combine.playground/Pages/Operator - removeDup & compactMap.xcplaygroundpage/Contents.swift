//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

// removeDuplicates => 중복 제거

let words = "hey hey there! Mr Mr ?"
    .components(separatedBy: " ")
    .publisher


//let subscriptions = words
//  .removeDuplicates()
//  .sink(receiveValue: {
//    print($0)
//  })
//  .store(in: &subscriptions)
// 와 같이 subscriptions와의 관계를 하나씩 만드는것 보다
// 여러개 담을수 있는 통(var subscriptions = Set<AnyCancellable>())을 하나 만들어서 통에 담는 방법이 있음

words
    .removeDuplicates()
    .sink(receiveValue: {
        print($0)
    })
    .store(in: &subscriptions)


// compactMap       => nil이 아닌 제대로 변환이 된 경우에만 output을 낸다

let strings = ["a", "1.24", "3", "def", "45", "0.23"].publisher

strings
    .compactMap { Float($0) }
    .sink(receiveValue: {
        print($0)
    })
    .store(in: &subscriptions)


// ignoreOutput

let numbers = (1...10_000).publisher

numbers
    .ignoreOutput()
    .sink(receiveCompletion: { print("Completed with: \($0)") }, receiveValue: { print($0) })
    .store(in: &subscriptions)


// prefix

let tens = (1...10).publisher

tens
    .prefix(2)      // 앞에 2개만 받겠다.
    .sink(receiveCompletion: { print("Completed with: \($0)") }, receiveValue: { print($0) })
    .store(in: &subscriptions)

//: [Next](@next)
