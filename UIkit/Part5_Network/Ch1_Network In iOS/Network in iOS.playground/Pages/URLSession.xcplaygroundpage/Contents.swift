//: [Previous](@previous)

import Foundation

// configuration -> urlsession -> urlsessionTask

let configuration = URLSessionConfiguration.default
let session = URLSession(configuration: configuration)

let url = URL(string: "https://api.github.com/users/seungchan2022")!

                // 서버에서 받은 내용: 요청한 데이터, 서버로부터의 응답, 에러
let task = session.dataTask(with: url) { data, response, error in
    guard let httpResponse = response as? HTTPURLResponse,
    // status code가 2xx 여야 성공한 것
    (200...300).contains(httpResponse.statusCode) else {
        print("---> response: \(response)")
        return
    }
    
    // 위에서 받은 데이터가 옵셔널이기 때문에 guard 구문 사용
    guard let data = data else {
        return
    }
    
    let result = String(data: data, encoding: .utf8)
    print(result)
    
}

// 생성된 dataTask는 바로 시작하지 않으므로 시작하려면 resume() 사용
task.resume()

//: [Next](@next)
