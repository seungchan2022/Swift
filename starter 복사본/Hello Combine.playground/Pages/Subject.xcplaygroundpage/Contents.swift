import Foundation
import Combine

// Subject (Publisher)
// send(_:) 메소드를 이용해서 이벤트 값을 주입시킬수 있는 퍼블리셔
// 기존의 비동기처리 방식에서 Combine으로 전환시 유용
// 2가지 빝트인 타입이 있음
// PassthroughSubject, CurrentValueSubject

// PassthroughSubject
// - Subscriber가 달라고 요청하면,
// - 그때 부터, 받은 값을 전달해주기만 함
// - 전달한 값을 들고 있지 않음
let relay = PassthroughSubject<String, Never>() // 퍼블리셔는 아웃풋과 에러 타입 지정해야함
let subscription1 = relay.sink { value in
    print("subscription1 received value: \(value)")
}

relay.send("Hello")
relay.send("World!")

// CurrentValueSubject
// - Subscriber가 달라고 요청하면,
// - 최근에 가지고 있던 값을 전달하고, 그때 부터, 받은 값을 전달 함
// - 전달한 값을 들고 있음
// CurrentValueSubject 는 초기값을 설정 해주어야 한다.
let variable = CurrentValueSubject<String, Never>("")

// subscription 되기 전에 초기값을 설전한 것이므로 이 값이 초기값이 된다.
variable.send("Intial text")

let subscription2 = variable.sink { value in
    print("subscription2 received value: \(value)")
}

variable.send("More text")
variable.value      // 현재 데이터 확인 메서드

let pulisher = ["Here", "we", "go"].publisher
pulisher.subscribe(relay)
pulisher.subscribe(variable)
print(variable.value)
