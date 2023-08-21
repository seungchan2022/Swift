//
//  StockRankDetatilView.swift
//  StockRank-SwiftUI
//
//  Created by 승찬 on 2023/03/10.
//

import SwiftUI

struct StockRankDetatilView: View {
    
    @Binding var stock: StockModel
    
    var body: some View {
        VStack(spacing: 40) {
            Image(stock.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
            Text(stock.name)
                .font(.system(size: 40, weight: .bold))
            Text("\(stock.price) 원")
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(stock.diff > 0 ? .red : .blue)
        }
    }
}

struct StockRankDetatilView_Previews: PreviewProvider {
    static var previews: some View {
        // @Binding으로 묶은 데이터를 임의로 보여주기 위해서 .constant사용
        StockRankDetatilView(stock: .constant( StockModel.list[0]))
            .preferredColorScheme(.dark)
    }
}
