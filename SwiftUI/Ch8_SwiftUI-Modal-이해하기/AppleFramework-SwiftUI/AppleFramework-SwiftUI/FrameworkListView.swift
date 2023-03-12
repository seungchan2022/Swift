//
//  ContentView.swift
//  AppleFramework-SwiftUI
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct FrameworkListView: View {
    

    
//    눌렀을때 띄우기 위한 추가적인 변수를 만들기 위해
//    ViewModel을 따로 만들고 ViewModel 안에서 받도록함
//    @State var list: [AppleFramework] = AppleFramework.list
//    @State var isPresented: Bool = false
    
    @StateObject var vm = FrameworkListViewModel()
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        
        // Grid 만들기
        // - UIKit : UICollectionView
        //   - Data, Presentaion, Layout
        // - SwiftUI : LazyVGrid, LazyHGrid
        //   - ✅ Data, ✅ Presentaion, ✅ Layout
        
        NavigationView {
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach($vm.models) { $item in
                        FrameworkCell(framework: $item)
                            .onTapGesture {
                                vm.isShowingDetail = true
                                vm.isSelectedItem = item
                            }
                    }
                }
                .padding([.top, .leading, .trailing], 16.0)
            }
            .navigationTitle("☀️ Apple Framework")
        }
                        // binding된 값
        .sheet(isPresented: $vm.isShowingDetail) {
//             띄울 view
            let vm = FrameworkDetailViewModel(framework: vm.isSelectedItem!)
            FrameworkDetailView(viewModel: vm)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkListView()
    }
}
