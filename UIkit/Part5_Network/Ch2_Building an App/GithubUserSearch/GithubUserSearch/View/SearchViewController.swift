//
//  SearchViewController.swift
//  GithubUserSearch
//
//  Created by joonwon lee on 2022/05/25.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    let network = NetworkService(configuration: .default)
    
    // searchController
    // collectionView 구성
    // bind()
    // - 데이터 -> 뷰
    //   - 검색된 사용자를 collectionView에 업데이트
    // - 사용자 인터랙션 대응
    //   - 서치컨트롤에서 텍스트 -> 네트워크 요청

    @Published private(set) var users: [SearchResult] = []
    var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias Item = SearchResult
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embedSearchControl()
        configureCollectionView()
        bind()
    }
    
    private func embedSearchControl() {
        self.navigationItem.title = "Search"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "seungchan2022"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    private func configureCollectionView() {
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell else { return nil }
            
            cell.user.text = item.login
            return cell
        })
        
        collectionView.collectionViewLayout = layout()
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func bind() {
        // - 데이터 -> 뷰
        //   - 검색된 사용자를 collectionView에 업데이트
        $users
            .receive(on: RunLoop.main)
            .sink { users in
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.main])
                snapshot.appendItems(users, toSection: .main)
                self.datasource.apply(snapshot)
            }.store(in: &subscriptions)
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text
        print("search: \(keyword)")
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("button clicked: \(searchBar.text)")
        
        // - 사용자 인터랙션 대응
        //   - 서치컨트롤에서 텍스트 -> 네트워크 요청
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
//        let base = "https://api.github.com/"
//        let path = "search/users"
//        let params: [String: String] = ["q": keyword]
//        let header: [String: String] = ["Content-Type": "application/json"]
//
//
//        var urlComponents = URLComponents(string: base + path)!
//        let queryItems = params.map { (key: String, value: String) in
//            return URLQueryItem(name: key, value: value)
//        }
//
//        urlComponents.queryItems = queryItems
//
//        var request = URLRequest(url: urlComponents.url!)
//        header.forEach { (key: String, value: String) in
//            request.addValue(value, forHTTPHeaderField: key)
//        }
        
        let resource = Resource<SearchUserResponse>(
            base: "https://api.github.com/",
            path: "search/users",
            params: ["q": keyword],
            header: ["Content-Type": "application/json"])
        
        network.load(resource)
            .map { $0.items}
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.users, on: self)
            .store(in: &subscriptions)
        
//        URLSession.shared.dataTaskPublisher(for: request)
//            .map { $0.data }
//            .decode(type: SearchUserResponse.self, decoder: JSONDecoder())
//            .map { $0.items }
//            .replaceError(with: [])
//            .receive(on: RunLoop.main)
//            .assign(to: \.users, on: self)
//            .store(in: &subscriptions)
    }
}


