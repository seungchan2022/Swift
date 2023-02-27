//
//  ContentView.swift
//  StockRank-SwiftUI
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct StockRankView: View {
    
    @State var list = StockModel.list
    
    var body: some View {
        
        NavigationView {
            List($list) { $item in
                
                ZStack {
                    NavigationLink {
                        // 눌렀을때 대상이 되는 View
                        StockDetailView(stock: $item)
                    } label: {
                        EmptyView()
                    }
                    StockRankRow(stock: $item)
                }
                .listRowInsets(EdgeInsets())
                .frame(height: 80)

            }
            .listStyle(.plain)
            .navigationTitle("Stock Rank")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StockRankView()
            .preferredColorScheme(.dark)
    }
}


// # TL;DR

// - `NavigationView`  이용해서 네비게이션뷰 + 컨트롤러 표현
//     - `NavigationView` 가 감싸는 View에 `navigationTitle` 지정하기
// - 네비게이션 push 를 구현하기 위해서 (상세뷰로 들어가기)
//     - `NavigationLink` 이용
//     - destination View 제작하기
