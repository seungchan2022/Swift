//
//  PlayButton.swift
//  DataFlow-SwiftUI
//
//  Created by 승찬 on 2023/02/25.
//

import SwiftUI



struct PlayButton: View {
    
    // @Binding을 통해서 진짜 데이터인 @State에 접근
    // 상태가 업데이트 되면 뷰는 자동으로 업데이트 된다!!
    @Binding var isPlaying: Bool
    
    var body: some View {
        Button {
            self.isPlaying.toggle()
        } label: {
            Image(systemName: isPlaying ? "pause.circle": "play.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 80)
                .foregroundColor(.primary)
        }
    }
}

