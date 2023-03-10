//
//  ContentView.swift
//  SymbolRoller-SwiftUI
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct SymbolRollerView: View {
    
    let symbols: [String] = ["sun.min", "moon", "cloud", "wind", "snowflake"]
    
    @State var imageNames = "moon"
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Image(systemName: imageNames)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Spacer()
            
            Text(imageNames)
                .font(.system(size: 40, weight: .bold))
            
            Button {
                print("button tapped")
                // 버튼 눌릴때마다 이미지가 바뀌어야함
                imageNames = symbols.randomElement()!
            } label: {
                // 좌 - 이미지, 우 (상 - 텍스트, 하 - 텍스트)
                HStack {
                    Image(systemName: "arrow.3.trianglepath")
                    
                    VStack {
                        Text("Reload")
                            .font(.system(size: 30, weight: .bold))
                        Text("click me to reload")
                    }
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, minHeight: 80)
            .background(.pink)
            .cornerRadius(40)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolRollerView()
    }
}
