//
//  OnboardingViewController.swift
//  NRCOnboarding
//
//  Created by 승찬 on 2023/03/03.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let message: [OnboardingMessage] = OnboardingMessage.messages

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Data, Presentation, Layout
        collectionView.dataSource = self
        collectionView.delegate = self

        if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.estimatedItemSize = .zero
        }
        
        // pageController의 점 개수
        pageControl.numberOfPages = message.count
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    
    // 몇개의 셀을 표현할 것인가?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return message.count
    }
    
    // 셀을 어떻게 표현할 것인가
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as? OnboardingCell else {
            return UICollectionViewCell()
        }
        
        let data = message[indexPath.item]
        cell.configure(data)
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size   // size 안에 width,height 둘다 들어있음
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    // 인덱스를 계산해서 아래 함수에 index로 넣어준다
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(Int(scrollView.contentOffset.x / collectionView.bounds.width))
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / collectionView.bounds.width)
        pageControl.currentPage = index     // 움직일때 바뀌는 것
    }
}
