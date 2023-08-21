//
//  FrameworkDetailView.swift
//  AppleFramework-SwiftUI
//
//  Created by 승찬 on 2023/03/12.
//

import SwiftUI

struct FrameworkDetailView: View {
    
    @StateObject var viewModel: FrameworkDetailViewModel
    //    var isSafariPresented: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            
            Spacer()
            
            Image(viewModel.framework.imageName)
                .resizable()
                .frame(width: 90, height: 90)
            Text(viewModel.framework.name)
                .font(.system(size: 20, weight: .bold))
            Text(viewModel.framework.description)
                .font(.system(size: 16))
            
            Spacer()
            
            Button {
                // print("Safari 띄우기")
                viewModel.isSafariPresented = true
            } label: {
                Text("Learn More")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                
            }
            .frame(maxWidth: .infinity, minHeight: 80)
            .background(.pink)
            .cornerRadius(40)
        }
        .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
        // sheet를 사용할때는 binding된 데이터가 있어야 된다.
        .sheet(isPresented: $viewModel.isSafariPresented) {
            let url = URL(string: viewModel.framework.urlString)!
            SafariView(url: url)
        }
    }
}

struct FrameworkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = FrameworkDetailViewModel(framework: AppleFramework.list[0])
        FrameworkDetailView(viewModel: vm)
    }
}
