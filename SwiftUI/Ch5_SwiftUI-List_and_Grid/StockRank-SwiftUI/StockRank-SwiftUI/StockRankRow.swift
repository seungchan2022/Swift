//
//  StockRankRow.swift
//  StockRank-SwiftUI
//
//  Created by 승찬 on 2023/03/10.
//

import SwiftUI

struct StockRankRow: View {
    
    var stock: StockModel
    
    var body: some View {
        HStack {
            Text("\(stock.rank)")
                .font(.system(size: 16, weight: .bold))
                .frame(width: 30)
                .foregroundColor(.blue)
            Image("\(stock.imageName)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("\(stock.name)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                
                HStack{
                    Text("\(stock.price) 원")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text("\(stock.diff, specifier: "%.2f")%")
                        .font(.system(size: 12))
                        .foregroundColor(stock.diff > 0 ? .red : .blue)
                }
            }
            
            Spacer()
            
            Image(systemName: "heart.fill")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

struct StockRankRow_Previews: PreviewProvider {
    static var previews: some View {
        StockRankRow(stock: StockModel.list[2])
    }
}


// # TL;DR

// - 리스트 표현시, `List` 사용
//     - 사용시 고려사항
//         - style
//         - separator
//         - inset
// - 작업 순서
//     - ListCell(Row) 먼저 만들고 → List 구현
// - 리스트에 사용되는 모델 이용시 알아두면 좋은 팁
//     - `Identifiable` 을 해당 모델이 conform 하고 있으면
//     - `List`, `ForEach` 사용시, id를 따로 지정해주지 않아도 됨
