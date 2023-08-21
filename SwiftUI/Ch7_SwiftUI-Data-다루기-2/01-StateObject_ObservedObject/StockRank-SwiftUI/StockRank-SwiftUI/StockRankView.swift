//
//  ContentView.swift
//  StockRank-SwiftUI
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct StockRankView: View {
    
    // viewModel
    // - list
    // - favorite
    // 단순히 Model만 들고 있으므로 viewModel을 따로 만든다
//    @State var list = StockModel.list
    @StateObject var vm = StockViewModel()
    
    var body: some View {
        NavigationView {
            List($vm.models) { $item in
                ZStack {
                    NavigationLink {
                        StockDetailView(viewModel: vm, stock: $item)
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
