//: [Previous](@previous)

import Foundation
import Combine


// Basic CombineLatest

let strPublisher = PassthroughSubject<String, Never>()
let numPublisher = PassthroughSubject<Int, Never>()


Publishers.CombineLatest(strPublisher, numPublisher)
    .sink { (str, num) in
        print("Receive: \(str), \(num)")
    }

// 13 ~ 16과 같은 결과
//strPublisher.combineLatest(numPublisher).sink { (str, num) in
//    print("Receive: \(str), \(num)")
//}

strPublisher.send("a")
numPublisher.send(1)
strPublisher.send("b")
strPublisher.send("c")
numPublisher.send(2)
numPublisher.send(3)

// Advanced CombineLatest

let usernamePublisher = PassthroughSubject<String, Never>()
let passwordPublisehr = PassthroughSubject<String, Never>()

let validatedCrendetialsSubscription = usernamePublisher.combineLatest(passwordPublisehr)
    .map { (username, password) -> Bool in
        return !username.isEmpty && !password.isEmpty && password.count > 12
    }
    .sink { valid in
        print("Credential valid?: \(valid)")
    }

usernamePublisher.send("jason")
passwordPublisehr.send("ads")
passwordPublisehr.send("verystrongpassword")

// Merge

let publisher1 = [1, 2, 3, 4 ,5].publisher
let publisher2 = [300, 400, 500].publisher

//let mergePublisherSubscription = Publishers.Merge(publisher1, publisher2)
//    .sink { value in
//        print("Merge: subscription recevied value: \(value)")
//    }

let mergePublisherSubscription = publisher1.merge(with: publisher2)
    .sink { value in
        print("Merge: subscription recevied value: \(value)")
    }

//: [Next](@next)
