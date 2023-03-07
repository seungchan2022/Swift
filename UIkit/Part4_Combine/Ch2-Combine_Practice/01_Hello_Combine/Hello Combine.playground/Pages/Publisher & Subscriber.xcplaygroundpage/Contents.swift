//: [Previous](@previous)

import Foundation
import Combine

// Publisher & Subscriber

// Publisher
// * 데이터를 배출하는 친구
//  - 구체적인 output 및 실패 타입을 정의함
//  - Subscriber가 요청한것 만큼 데이터를 제공
// * 빌트인 Publisher인 Just, Future가 있음
//  - Just는 값을 다루고
//  - Future는 Function을 다룸
// * iOS에서는 자동으로 제공해주는 녀석들이 있음
//  - NotificationCenter, Timer, URLSession.dataTask

// Subscriber
// * Publisher에게 데이터를 요청함
// * Input, Failure 타입 정의가 필요함
// * Publisher 구독후, 갯수를 요청함
// * 파이프라인을 취소할 수 있음
// * 빌트인 Subscriber인 assign과 sink가 있음
//  - assign은 Publisher가 제공한 데이터를 특정 객채의 키패스에 할당
//  - sink는 Publisher가 제공한 데이터를 받을수 있는 클로져를 제공함

let just = Just(100)    // Just 자체가 Publisher
let subscription1 = just.sink { value in
    print("Received Value: \(value)")
}


let arrPublisher = [1, 3, 5, 7, 9].publisher
let subscription2 = arrPublisher.sink { value in
    print("Received Value: \(value)")
}


class MyClass {
    var property: Int = 0 {
        didSet {
            print("Did set property to \(property)")
        }
    }
}

let object = MyClass()
let subscription3 = arrPublisher.assign(to: \.property, on: object) // 어떤 object에 어떤 property에 세팅하겠다.
print("Final Value: \(object.property)")



//: [Next](@next)
