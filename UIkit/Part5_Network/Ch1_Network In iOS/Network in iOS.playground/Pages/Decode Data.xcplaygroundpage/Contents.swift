//: [Previous](@previous)

import Foundation

// App Model -> JSON(서버) : Decoding
// App Model <- JSON(서버) : Encoding

struct GithubProfile: Codable {
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let followers: Int
    let following: Int
    
    // 디코딩 할때 스위프트는 캐멀케이스 JSON은 스네이크케이스를 쓰기때문에
    // 호환이 되지않는것 들은 CodingKey를 이용해 맵핑시 켜줄수 있다.
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case followers
        case following
    }
}

let configuration = URLSessionConfiguration.default
let session = URLSession(configuration: configuration)

let url = URL(string: "https://api.github.com/users/seungchan2022")!

let task = session.dataTask(with: url) { data, response, error in
    guard let httpResponse = response as? HTTPURLResponse,
          (200...300).contains(httpResponse.statusCode) else {
            print("---> response: \(response)")
            return
        }
    
    guard let data = data else { return }
    // data를 아래에서 처럼 string이 아니라 data -> GithubProfile 형태로 바꾸는 것이 목표
    
//    let result = String(data: data, encoding: .utf8)
//    print(result)
    
    do {
         let decoder = JSONDecoder()
        // 디코딩이 실패할수 있으므로 try 사용
        let profile = try decoder.decode(GithubProfile.self, from: data)
        print("profile: \(profile)")
        // error 발생하면 catch 구문을 탐
    } catch let error as NSError {
        print("error: \(error)")
    }
}

// 생성된 dataTask는 바로 시작하지 않으므로 시작하려면 resume() 사용
task.resume()





//: [Next](@next)
