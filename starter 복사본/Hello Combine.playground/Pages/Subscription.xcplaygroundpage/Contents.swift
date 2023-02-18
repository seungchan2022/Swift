//: [Previous](@previous)

import Foundation
import Combine

// Subscription
// Subscriber 가 Publisher가 연결됨을 나타내는 녀석
// - 쉽게 생각하면, Publisher가 발행한 구독 티켓
// - 이 구독 티켓만 있으면, 데이터를 받을수 있음
// - 이 구독 티켓이 사라지면 구독 관계도 사라짐
// Cancellable 프로토콜을 따르고 있음
// - 따라서, Subscription을 통해 연결을 Cancel 할 수 있음

let subject = PassthroughSubject<String, Never>()

// The print() operator prints you all lifecycle events
let subscription = subject
    .print("Debug")
    .sink { value in
        print("Subscription received value: \(value)")
    }

subject.send("Hello")
subject.send("Hello again")
subject.send("Hello last time")
//subject.send(completion: .finished)   -> Publisher가 관계 끊는 방법
subscription.cancel()   // subscription이 관계 끊는 방법
subject.send("Hello")

//: [Next](@next)
