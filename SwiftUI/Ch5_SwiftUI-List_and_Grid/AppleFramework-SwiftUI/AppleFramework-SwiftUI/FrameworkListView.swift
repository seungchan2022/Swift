//
//  ContentView.swift
//  AppleFramework-SwiftUI
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct FrameworkListView: View {
    
    @State var list: [AppleFramework] = AppleFramework.list
    
    var layout: [GridItem] = [
//        GridItem(.fixed(50)),
//        GridItem(.adaptive(minimum: 80)),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
    // Grid
    // - UIKit: UIcollectionView
    //   - Data, Presentation, Layout
    // SwiftUI: LazyVGrid, LazyHGrid
    //   - Data, Presentation, Layout
        NavigationView {
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(list) { item in
                        FrameworkCell(framework: item)
                    }
                }
                .padding([.top, .leading, .trailing], 16.0)
            }
            .navigationTitle("🤔 Apple Framework")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkListView()
    }
}
