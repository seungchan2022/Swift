//: [Previous](@previous)

import Foundation
import Combine

// Subscription
// * Subscriber와 Publisher가 연결됨을 나타내는 녀석
//  - 쉽게 생각하면, Publisher가 발행한 구독 티켓
//  - 이 구독 티켓만 있으면, 데이터를 받을수 있음
//  - 이 구독 티켓이 사라지면 구독 관계도 사라짐
// * Cancellable 프로토콜을 따르고 있음
//  - 따러서, Subscription을 통해 연결을 Cancel 할수 있음

let subject = PassthroughSubject<String, Never>()
let subscription = subject
    .print("[Debug]")   // The print() operator prints you all lifecycle events
    .sink { value in
        print("Subsciber reveiced value: \(value)")
    }


subject.send("Hello!")
subject.send("Hello again!")
subject.send("Hello for the last time!")
subject.send(completion: .finished)     // ==> publisher에서 관계 끊는 방법
//subscription.cancel() ==> subscription에서 관계 끊는 방법
subject.send("Hello?? :(")


//: [Next](@next)
