//: [Previous](@previous)

import Foundation

enum NetworkError: Error {
  case invalidRequest
  case transportError(Error)
  case responseError(statusCode: Int)
  case noData
  case decodingError(Error)
}

struct GithubProfile: Codable {
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let followers: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case followers
        case following
    }
}

final class NetworkService {
    let session: URLSession    // network작업을 할때 주요 객체: URLSession
    
    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }
                                                            // Result<성공했을때, 실패했을때>
    func fetchProfile(userName: String, completion: @escaping (Result<GithubProfile, Error>) -> Void){

        let url = URL(string: "https://api.github.com/users/\(userName)")!

        let task = session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(NetworkError.transportError(error)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
                  !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.responseError(statusCode: httpResponse.statusCode)))
                      return
                  }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            // data -> GithubProfile
            
            do {
                let decoder = JSONDecoder()
                let profile = try decoder.decode(GithubProfile.self, from: data)
                completion(.success(profile))
            } catch let error as NSError {
                completion(.failure(NetworkError.decodingError(error)))
            }
        }

        task.resume()
    }
}

// network 담당 NetworkService
// NetworkService 이용한 네트워크 작업

let networkService = NetworkService(configuration: .default)

networkService.fetchProfile(userName: "seungchan2022") { result in
    switch result {
    case .success(let profile):
        print("Profile: \(profile)")
    case .failure(let error):
        print("Error: \(error)")
    }
}



//: [Next](@next)
