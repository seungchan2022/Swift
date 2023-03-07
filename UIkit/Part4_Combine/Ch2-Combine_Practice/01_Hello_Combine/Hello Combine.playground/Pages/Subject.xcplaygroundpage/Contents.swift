import Foundation
import Combine

// Subject(Publisehr)
// * send(_:) 메서드를 이용해서 이벤트 값을 주입시킬수 있는 퍼블리셔
// * 기존의 비동기처리 방식에서 Combine으로 전환시 유용함
// * 2가지 빌트인 타입이 있음
//  - PassthroughSubject
//      - Subcriber가 달라고 요청하면,
//      - 그때 부터, 받은 값을 전대하주기만 함
//      - 전달한 값을 들고 있지 않음
//  - CurrentValueSubject
//      - Subscriber가 달라고 요청하면,
//      - 최근에 가지고 있던 값을 전달하고, 그때 부터, 받은 값을 전달 함
//      - 전달한 값을 들고 있음

// PassthroughSubject

// Publisher는 output 타입과 실패타입 둘다 설정해줘야 한다.
let relay = PassthroughSubject<String, Never>()
let subscription1 = relay.sink { value in
    print("subscription1 received value: \(value)")
}

// PassthroughSubject, CurrentValueSubject는 send 메서드로 값을 주입시킬수 있음
relay.send("Hello")
relay.send("World!")



// CurrentValueSubject

// CurrentValueSubject는 초기값을 설정해줘야 한다.
let variable = CurrentValueSubject<String, Never>("")

variable.send("Initial text")

let subscription2 = variable.sink { value in
    print("subscription2 received value: \(value)")
}

variable.send("More text")
variable.value  // 현재값 확인

//let publisher = ["Here", "we", "go!"].publisher
//publisher.subscribe(relay)
//publisher.subscribe(variable)
