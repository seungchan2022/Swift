//
//  PaywallViewController.swift
//  SpotifyPaywall
//
//  Created by joonwon lee on 2022/04/30.
//

import UIKit

// https://developer.spotify.com/documentation/general/design-and-branding/#using-our-logo
// https://developer.apple.com/documentation/uikit/nscollectionlayoutsectionvisibleitemsinvalidationhandler
// 과제: 아래 애플 샘플 코드 다운받아서 돌려보기  https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views

class PaywallViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let bannerInfos: [BannerInfo] = BannerInfo.list
    
    // collectionView의 backgroundColor
    let colors: [UIColor] = [.systemPurple, .systemOrange, .systemPink, .systemRed]
    
    typealias Item = BannerInfo
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
     override func viewDidLoad() {
        super.viewDidLoad()
         
         // diffable datasource
         // - presentation
         // snapshot
         // - data
         // compositional layout
         // - layout
         
         // presentation
         dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
             guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as? BannerCell else {
                 return nil
             }
             cell.configure(item)
             cell.backgroundColor = self.colors[indexPath.item]
             return cell
         })
         
        // data
         var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
         snapshot.appendSections([.main])
         snapshot.appendItems(bannerInfos, toSection: .main)
         dataSource.apply(snapshot)
        
         // layout
         collectionView.collectionViewLayout = layout()
         collectionView.alwaysBounceVertical = false
         
         // pageControl의 점 개수
         pageControl.numberOfPages = bannerInfos.count
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 20
        
        section.visibleItemsInvalidationHandler = { (item, offset, env) in
//            print("\(Int(ceil(offset.x / env.container.contentSize.width)))")
            let index = Int(ceil(offset.x / env.container.contentSize.width))
            print("\(index)")
            self.pageControl.currentPage = index
        }
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
