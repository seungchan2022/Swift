//
//  BenefitListViewController.swift
//  TossBenefitTab
//
//  Created by 승찬 on 2023/03/14.
//

import UIKit
import Combine

class BenefitListViewController: UIViewController {
    
    // 사용자 관점
    // - 사용자는 포인트를 볼수있다.
    // - 사용자는 오늘의 혜택을 볼수있다.
    
    // - 사용자는 나머지 혜택 리스트를 볼수있다.
    
    // - 사용자는 포인트셀을 누르면, 포인트 상세뷰로 넘어간다.
    // - 사용자는 혜택셀을 누르면, 혜택 상세뷰로 넘어간다.
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias Item = AnyHashable
    enum Section: Int {     // indexPath.section을 통해 rawValue에 접근하기 위해 Int준수
        case today
        case other
    }
    
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    var subscriptions = Set<AnyCancellable>()
    let viewModel: BenefitListViewModel = BenefitListViewModel()
    
    // 아이템들이 네트워크를 타고 올때 딜레이 되는 상황이 생긴다고 가정했을때
//    var todaySectionItems: [AnyHashable] = [포인트, 오늘의 혜택]
    // 포인트, 오늘의 혜택을 하나로 묶어서 표현하기 위해 model을 만들어 관리
//    var todaySectionItems: [AnyHashable] = [MyPoint.default, Benefit.today]
//    var todaySectionItems: [AnyHashable] = TodaySectionItem(point: MyPoint.default, today: .today).sectionItems
//    var otherSectionItems: [AnyHashable] = [나머지 혜택 리스트]
//    var otherSectionItems: [AnyHashable] = Benefit.others

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureCollectionView()
        bind()
        viewModel.fetchItems()  // viewModel 데이터 세팅
    }
    
    private func setupUI() {
        navigationItem.title = "혜택"
    }
    
    private func configureCollectionView() {
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let section = Section(rawValue: indexPath.section) else { return nil }
            let cell = self.configureCell(for: section, item: item, collectionView: collectionView, indexPath: indexPath)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.today, .other])
        snapshot.appendItems([], toSection: .today)
        snapshot.appendItems([], toSection: .other)
        datasource.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self

    }
        
    private func bind() {
        // output: data
        // view를 렌더링 하는 로직
        viewModel.$todaySectionItems
            .receive(on: RunLoop.main)
            .sink { items in
                self.applySnapsht(items: items, section: .today)
            }.store(in: &subscriptions)
        
        viewModel.$otherSectionItems
            .receive(on: RunLoop.main)
            .sink { items in
                self.applySnapsht(items: items, section: .other)
            }.store(in: &subscriptions)
        
        // input: user interaction
        // user interaction을 받았을때 처리 하는 로직
        viewModel.benefitDidTapped
            .receive(on: RunLoop.main)
            .sink { benefit in
                let sb = UIStoryboard(name: "ButtonBenefit", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "ButtonBenefitViewController") as! ButtonBenefitViewController
//                vc.benefit = benefit
                vc.viewModel = ButtonBenefitViewModel(benefit: benefit)
                self.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &subscriptions)
        
        viewModel.pointDidTapped
            .receive(on: RunLoop.main)
            .sink { point in
                let sb = UIStoryboard(name: "MyPoint", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "MyPointViewController") as! MyPointViewController
//                vc.point = point
                vc.viewModel = MyPointViewModel(point: point) 
                self.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &subscriptions)
    }
    
    private func applySnapsht(items: [Item], section: Section) {
        var snapshot = datasource.snapshot()
        snapshot.appendItems(items, toSection: section)
        datasource.apply(snapshot)
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
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureCell(for section: Section, item: Item, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        switch section {
        case .today:    // 포인트, 오늘의 혜택
            if let point = item as? MyPoint {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPointCell", for: indexPath) as! MyPointCell
                cell.configure(item: point)
                return cell
            } else if let benefit = item as? Benefit {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayBenefitCell", for: indexPath) as! TodayBenefitCell
                cell.configure(item: benefit)
                return cell
            } else {
                return nil
            }
            
        case .other:    // 나머지 혜택 리스트
            if let benefit = item as? Benefit {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BenefitCell", for: indexPath) as! BenefitCell
                cell.configure(item: benefit)
                return cell
            } else {
                return nil
            }
        }
    }
}


extension BenefitListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = datasource.itemIdentifier(for: indexPath)
        print("--=--> \(item) ")
        
        if let benefit = item as? Benefit {
            viewModel.benefitDidTapped.send(benefit)
        } else if let point = item as? MyPoint {
            viewModel.pointDidTapped.send(point)
        } else {
            // no - op
        }
    }
}
