//: [Previous](@previous)

import Foundation
import Combine


// Basic CombineLatest

let strPublisher = PassthroughSubject<String, Never>()
let numPublisher = PassthroughSubject<Int, Never>()

//strPublisher.combineLatest(numPublisher).sink { (str, num) in
//    print("Receive: \(str), \(num)")    // 둘다 보내느 데이터가 있어야 출려됨
//}

Publishers.CombineLatest(strPublisher, numPublisher).sink { (str, num) in
    print("Receive: \(str), \(num)")
}


//strPublisher.send("a")
//strPublisher.send("b")
//strPublisher.send("c")
//
//numPublisher.send(1)
//numPublisher.send(2)
//numPublisher.send(3)

strPublisher.send("a")
numPublisher.send(1)
strPublisher.send("b")
strPublisher.send("c")

numPublisher.send(2)
numPublisher.send(3)


// Advanced CombineLatest

let usernamePublisher = PassthroughSubject<String, Never>()
let passwordPublisher = PassthroughSubject<String, Never>()

let validatedCredentialsSubscription = Publishers.CombineLatest(usernamePublisher, passwordPublisher)
    .map { (username, password) -> Bool in
        !username.isEmpty && !password.isEmpty && password.count > 12
    }
    .sink { valid in
        print("CombineLatest: are the credentials valid? \(valid)")
    }

usernamePublisher.send("jasonlee")
passwordPublisher.send("weakpw")
passwordPublisher.send("verystrongpassword")

// Merge => 같은 타입이어야 한다

let publisher1 = [1,2,3,4,5].publisher
let publisher2 = [300,400,500].publisher
//let publisher1 = ["1","2","3","4","5"].publisher
//let publisher2 = ["300","400","500"].publisher

let mergedPublishersSubscription = Publishers
    .Merge(publisher1, publisher2)
    .sink { value in
        print("Merge: subscription received value \(value)")
    }

//let mergerPublishersSubscirption = publisher1
//    .merge(with: publisher2)
//    .sink { value in
//        print("Merge: subscription received value \(value)")
//    }



//: [Next](@next)
