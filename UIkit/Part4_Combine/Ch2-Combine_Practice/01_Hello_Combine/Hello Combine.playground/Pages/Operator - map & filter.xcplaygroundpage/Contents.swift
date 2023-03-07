//: [Previous](@previous)

import Foundation
import Combine

// Operator
// * Publisher에게 받은 값을 가공해서 Subscriber에게 제공
// * Input, Output, Failure type을 받는데 타입이 다를수 있음
// * 빌트인 오퍼레이터가 많이 있음 -> 필요할때 마다 찾아서 사용하기

// Transform - Map

let numPublisher = PassthroughSubject<Int, Never>()

let subscription1 = numPublisher
    .map { $0 * 2 }
    .sink { value in
        print("Transformed value: \(value)")
    }

numPublisher.send(10)
numPublisher.send(20)
numPublisher.send(30)
subscription1.cancel()

// Filter

let stringPublisher = PassthroughSubject<String, Never>()

let subscription2 = stringPublisher
    .filter { $0.contains("a") }    // => a가 포함된것만 넘겨라
    .sink { value in
        print("Filtered value: \(value)")
    }

stringPublisher.send("abc")
stringPublisher.send("Jack")
stringPublisher.send("Joon")
stringPublisher.send("Jenny")
stringPublisher.send("Jason")
subscription2.cancel()

//: [Next](@next)
