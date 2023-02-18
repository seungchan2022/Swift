//: [Previous](@previous)

import Foundation
import UIKit
import Combine

// @Published (Publisher)
// @Published로 선언된 프로퍼티를 퍼블리셔롤 만들어줌
// 클래스에 한해서 사용됨 (구조체에서 사용안됨)
// $ 를 이용해서 퍼블리셔에 접근할수 있음
final class SomeViewModel {
    @Published var name: String = "Jack"
    var age: Int = 20
}

final class Label {
    var text: String = ""
}

let label = Label()
let vm = SomeViewModel()
print("text: \(label.text)")        // ""
print("text: \(vm.name)")           // Jack

vm.$name.assign(to: \.text, on: label)
print("text: \(label.text)")        // Jack

vm.name = "Jason"
print("text: \(label.text)")        // Jason

vm.name = "Hoo"
print("text: \(label.text)")        // Hoo
//: [Next](@next)
