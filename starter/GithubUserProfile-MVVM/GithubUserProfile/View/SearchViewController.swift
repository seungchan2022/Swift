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
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
//    @Published private(set) var user: UserProfile?
    var subscriptions = Set<AnyCancellable>()
    var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchViewModel(network: NetworkService(configuration: .default), selectedUser: nil)
        setupUI()
        embedSearchControl()
        bind()
    }
    
    private func setupUI() {
        thumbnail.layer.cornerRadius = 80
    }
    
    private func embedSearchControl() {
        self.navigationItem.title = "Search"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "cafielo"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    private func bind() {
//        viewModel.$user
//            .receive(on: RunLoop.main)
//            .sink { [unowned self] result in
//                self.update(result)
//            }.store(in: &subscriptions)
        
        
        viewModel.selectedUser
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                self.nameLabel.text = self.viewModel.name
                self.loginLabel.text = self.viewModel.login
                self.followerLabel.text = self.viewModel.followers
                self.followingLabel.text = self.viewModel.following
                self.thumbnail.kf.setImage(with: self.viewModel.imageURL)
            }.store(in: &subscriptions)

    }
    
//    private func update(_ user: UserProfile?) {
////        guard let user = user else {
////            self.nameLabel.text = "n/a"
////            self.loginLabel.text = "n/a"
////            self.followerLabel.text = ""
////            self.followingLabel.text = ""
////            self.thumbnail.image = nil
////            return
////        }
////
////        self.nameLabel.text = user.name
////        self.loginLabel.text = user.login
////        self.followerLabel.text = "follower: \(user.followers)"
////        self.followingLabel.text = "following: \(user.following)"
////        self.thumbnail.kf.setImage(with: user.avatarUrl)
//
//        self.nameLabel.text = viewModel.name
//        self.loginLabel.text = viewModel.login
//        self.followerLabel.text = viewModel.followers
//        self.followingLabel.text = viewModel.following
//        self.thumbnail.kf.setImage(with: viewModel.imageURL)
//
//    }
}

extension UserProfileViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text
        print("search: \(keyword)")
    }
}

extension UserProfileViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        viewModel.search(keyword: keyword)
    }
}
