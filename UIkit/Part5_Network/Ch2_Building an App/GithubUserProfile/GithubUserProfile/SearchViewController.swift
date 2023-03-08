//
//  SearchViewController.swift
//  GithubUserSearch
//
//  Created by joonwon lee on 2022/05/25.
//

import UIKit
import Combine
import Kingfisher

class UserProfileViewController: UIViewController {

    // setupUI
    // userprofile(data)
    // bind -> user가 업데이트 되면 UI 업데이트
    // searchcontrol -> network
    // network(search conrtol에서 엔터를 눌렀을때 네트워크를 통해 데이터를 요청, 받기 위해)
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    // NetworkService객체 가져오기
    let network = NetworkService(configuration: .default )
    
    // userprofile(data)
    @Published private(set) var user: UserProfile?      // user가 업데이트 되면서 UI가 변경되게 하기 위해 @Published 사용

    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        embedSearchControl()
        bind()
    }
    
    // searchcontrol
    private func embedSearchControl() {
        self.navigationItem.title = "Search"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "cafielo"
        searchController.searchResultsUpdater = self    // update
        searchController.searchBar.delegate = self  // search클릭
        self.navigationItem.searchController = searchController
    }
    
    // bind
    private func bind() {
        $user
            .receive(on: RunLoop.main)
            .sink { [unowned self] result in
                self.update(result)
            }.store(in: &subscriptions)
    }
    
    // user가 업데이트 되면 UI 업데이트
    private func update(_ user: UserProfile?) {
        // user가 없을수도 있으므로 guard 구문 사용
        guard let user = user else {
            self.nameLabel.text = "n/a"
            self.loginLabel.text = "n/a"
            self.followerLabel.text = ""
            self.followingLabel.text = ""
            self.thumbnail.image = nil
            return
        }
        self.nameLabel.text = user.name
        self.loginLabel.text = user.name
        self.followerLabel.text = "followers: \(user.followers)"
        self.followingLabel.text = "following: \(user.following)"

//        let url = URL(string: "https://example.com/image.png")
//        imageView.kf.setImage(with: url)
        self.thumbnail.kf.setImage(with: user.avatarUrl)
    }
    
    // setupUI
    private func setupUI() {
        thumbnail.layer.cornerRadius = 80
    }
}

extension UserProfileViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text
        print("search: \(keyword)")
    }
}

extension UserProfileViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("button clicked: \(searchBar.text)")
        
        // searhBar에 키워드 입력조건
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        
        // Resource
        
//        let base = "https://api.github.com/"
//        let path = "users/\(keyword)"
//        let params: [String: String] = [:]
//        let header: [String: String] = ["Content-Type" : "application/json"]
//
//        var urlComponets = URLComponents(string: base + path)!
//        let queryItems = params.map { (key: String, value: String) in
//            return URLQueryItem(name: key, value: value)
//        }
//        urlComponets.queryItems = queryItems
//
//        // 네트워크를 요청하기 위해 URLRequest를 만듬
//        var request = URLRequest(url: urlComponets.url!)
//        header.forEach { (key: String, value: String) in
//            request.addValue(value, forHTTPHeaderField: key)
//        }
        
        // UserProfile을 받기위한 resource 만들기
        let resource = Resource<UserProfile>(
            base:  "https://api.github.com/",
            path:  "users/\(keyword)",
            params: [:],
            header: ["Content-Type" : "application/json"]
        )
        
        // NetworkService
        network.load(resource)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.user = nil
                case .finished: break
                }
            } receiveValue: { user in
                self.user = user
            }
            .store(in: &subscriptions)
        
        
//        URLSession.shared
//            .dataTaskPublisher(for: request)    // 만들어진 URLRequest를 dataTaskPublisher를 이용해서 서버에 데이터 요청
//            .tryMap { result -> Data in
//                guard let response = result.response as? HTTPURLResponse,
//                      (200...300).contains(response.statusCode) else {
//                    let response = result.response as? HTTPURLResponse
//                    let statusCode = response?.statusCode ?? -1
//                    throw NetworkError.responseError(statusCode: statusCode)
//                }
//                return result.data
//            }
//            .decode(type: UserProfile.self, decoder: JSONDecoder())     // 받은 데이터를 가지고 UserProfile로 디코딩
//            .receive(on: RunLoop.main)
//            .sink { completion in   // 그렇게 만들어진 퍼블리셔를 sink
//                print("completion: \(completion)")
//                switch completion {
//                case .failure(let error):
//                    self.user = nil
//                case .finished: break
//                }
//            } receiveValue: { user in
//                self.user = user
//            }
//            .store(in: &subscriptions)
    }
}
