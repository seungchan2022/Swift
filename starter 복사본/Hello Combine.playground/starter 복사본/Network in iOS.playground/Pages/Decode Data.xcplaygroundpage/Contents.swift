//: [Previous](@previous)

import Foundation


struct GithubProfile: Codable {
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let followers: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"   // camelcase와 snake_case구분
        case htmlUrl = "html_url"
        case followers
        case following
    }
}

// App Model <- JSON : Decoding    반대: Encoding

let configuration = URLSessionConfiguration.default
let session = URLSession(configuration: configuration)

let url = URL(string: "https://api.github.com/users/seungchan2022")!

let task = session.dataTask(with: url) { data, response, error in
    guard let httpResponse = response as? HTTPURLResponse,
          (200..<300).contains(httpResponse.statusCode) else {
              print("---> response \(response)")
              return
          }
    
    guard let data = data else { return }
    // data -> GithubProfile
    
    do {
        let decoder = JSONDecoder()
        let profile = try decoder.decode(GithubProfile.self, from: data)
        print("profile: \(profile)")    // error가 발생할 수 있으므로 try를 작성하고 error가 발생했을때 catch절로 잡기
    } catch let error as NSError {
        print("error: \(error)")
    }
}

task.resume()



//: [Next](@next)
