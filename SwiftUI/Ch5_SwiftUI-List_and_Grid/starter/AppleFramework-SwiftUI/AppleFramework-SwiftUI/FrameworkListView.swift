//
//  ContentView.swift
//  AppleFramework-SwiftUI
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct FrameworkListView: View {
    
    @State var list: [AppleFramework] = AppleFramework.list
    
    let layout: [GridItem] = [
        GridItem(.flexible()),  // 하나만 입력하면 한줄
        GridItem(.flexible()),  // 줄수에 맞춰서 입력
        GridItem(.flexible()),
    ]
    
    var body: some View {
        // Grid 만들기
        // - UIKit: UICollectionView
        //  - Data, Presentation, Layout
        // - SWiftUI: LazyVGrid, LazyHGrid
        //  - Data, Presentation, Layout
        
        NavigationView {
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(list) { item in
                        FrameworkCell(framework: item)
                    }
                }.padding([.top, .leading, .trailing], 16.0)
            }.navigationTitle("🌞 Apple Framework")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkListView()
    }
}
