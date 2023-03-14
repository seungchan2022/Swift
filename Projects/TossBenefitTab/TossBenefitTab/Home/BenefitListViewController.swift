//
//  BenefitListViewController.swift
//  TossBenefitTab
//
//  Created by 승찬 on 2023/03/14.
//

import UIKit

class BenefitListViewController: UIViewController {
    
    // 사용자 관점
    // - 사용자는 포인트를 볼수있다.
    // - 사용자는 오늘의 혜택을 볼수있다.
    
    // - 사용자는 나머지 혜택을 볼수있다.
    
    // - 사용자는 포인트 셀을 눌렀을때, 포인트 상세뷰로 넘어간다.
    // - 사용자는 혜택 셀을 눌렀을때, 혜택 상세뷰로 넘어간다.
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias Item = AnyHashable
    enum Section: Int { // Section(rawValue: indexPath.section)으로 사용할 것이므로 Int준수
        case today
        case other
    }
    
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    //  포인트, 오늘의 혜택을 하나로 묶어서 표헌하기 위해 model을 만들어서 관리
    //                                                      [포인트. 혜택]
    //    var todaySectionItems = [AnyHashable] = [MyPoint.default, Benefit.today]
    var todaySectionItems: [AnyHashable] = TodaySectionItem(point: .defalut, today: .today).sectionItems
    var otherSectionItems: [AnyHashable] = Benefit.others
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let section = Section(rawValue: indexPath.section) else { return nil}
            let cell = self.configureCell(for: section, item: item, collectionView: collectionView, indexPath: indexPath)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.today, .other])
        snapshot.appendItems(todaySectionItems, toSection: .today)
        snapshot.appendItems(otherSectionItems, toSection: .other)
        datasource.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self
        
        navigationItem.title = "혜택"
        
    }
    
    private func configureCell(for section: Section, item: Item, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        
        switch section {
        case .today:        // [포인트, 혜택]
            if let point = item as? MyPoint {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPointCell", for: indexPath) as! MyPointCell
                cell.configure(item: point)
                return cell
            } else if let benefit = item as? Benefit {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodaytBenefitCell", for: indexPath) as! TodaytBenefitCell
                cell.configure(item: benefit)
                return cell
            } else {
                return nil
            }
            
        case .other:
            if let benefit = item as? Benefit {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BenefitCell", for: indexPath) as! BenefitCell
                cell.configure(item: benefit)
                return cell
            } else {
                return nil
            }
        }
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let spacing: CGFloat = 10
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16)
        section.interGroupSpacing = spacing
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension BenefitListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = datasource.itemIdentifier(for: indexPath)
        print("=====> \(item)")
        
        if let benefit = item as? Benefit {
            let sb = UIStoryboard(name: "ButtonBenefit", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "ButtonBenefitViewController") as! ButtonBenefitViewController
            vc.benefit = benefit
            navigationController?.pushViewController(vc, animated: true)

        } else if let point = item as? MyPoint {
            let sb = UIStoryboard(name: "MyPoint", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "MyPointViewController") as! MyPointViewController
            vc.point = point
            navigationController?.pushViewController(vc, animated: true)
        } else {
            // no-op        
        }
    }
}
