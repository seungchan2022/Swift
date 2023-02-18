//: [Previous](@previous)

import Foundation
import Combine

// Operator

// Publisher에게 받은 값을 가공해서 Subscriber에게 제공
// Input, Output, Failure type을 받는데 타입이 다를수 있음
// 빝트인 오퍼레이터가 많이 있음
// - map, filter, reduce, collect, combineLatest ...

// Transform - Map

let numPublisher = PassthroughSubject<Int, Never>() // publisher
let subscription1 = numPublisher    // subscriber
    .map { $0 * 2 }     // operator
    .sink { value in    // 빌트인 subscriber
        print("Transformed Value: \(value)")
    }

numPublisher.send(10)
numPublisher.send(20)
numPublisher.send(30)
subscription1.cancel()

// Filter

let stringPublisher = PassthroughSubject<String, Never>()
let subscription2 = stringPublisher
    .filter { $0.contains("a") }
    .sink { value in
        print("Filltered Value: \(value)")
    }

stringPublisher.send("abc")
stringPublisher.send("Jack")
stringPublisher.send("Joon")
stringPublisher.send("Jenny")
stringPublisher.send("Jason")
subscription2.cancel()
    
//: [Next](@next)
