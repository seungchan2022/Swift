//: [Previous](@previous)

import Foundation
import Combine

// Publisher & Subscriber

// - Publisher
// 데이터를 배출
// - 구체적인 output 및 실패 타입을 정의
// - Subscriber 가 요청한것 만큼 데이터 제공
// 빌트인 Publisher인 Just, Future가 있음
// - Just는 값을 다루고, Future는 Function을 다룸
// iOS에서는 자동으로 제공해주는 녀석들이 있음
// - NotificationCenter, Timer, URLSession.dataTask

// - Subscriber
// Publisher에게 데이터 요청
// Input, Failure 타입이 정의 필요
// Publisher 구독후, 갯수를 요청
// 파이프라인을 취소할 수 있음
// 빌트인 Subscriber인 assign 과 sink가 있음
// - assign 은 Publisher가 제공한 데이터를 특정 객체의 키패스에 할당
// - sink 는 Publisher가 제공한 데이터를 받을수 있는 클로져를 제공함

let just = Just(1000)
let subscription1 = just.sink { value in
    print("Received value: \(value)")
}

let arrPublisher = [1, 3, 5, 7, 9].publisher
let subscription2 = arrPublisher.sink { value in
    print("Received value: \(value)")
}

class MyClass {
    var property: Int = 0 {
        didSet {
            print("Did set property to \(property)")
        }
    }
}

let object = MyClass()
let subscription3 = arrPublisher.assign(to: \.property, on: object)


//: [Next](@next)


