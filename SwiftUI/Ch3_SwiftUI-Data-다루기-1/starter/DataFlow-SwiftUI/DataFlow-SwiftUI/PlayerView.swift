//
//  PlayerView.swift
//  DataFlow-SwiftUI
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct PlayerView: View {
    let episode: Episode
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text(episode.title)
                .font(.largeTitle)
            Text(episode.showTitle)
                .font(.title3)
                .foregroundColor(.gray)
            
            PlayButton(isPlaying: $isPlaying)
            
            PlayingStatusView(isPlaying: $isPlaying)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(episode: Episode.list[0])
    }
}




//- SwiftUI 에서는  Single source of truth 에 상태 관리가 중요함
//- SwiftUI 에서는   `@State` 를 이용해서 Single source of truth 상태를 나타낼수 있음
//- `@Binding` 을 통해서 Single source of truth 상태 정보에 접근 가능
//- SwiftUI 에서는 상태가 변하면, 뷰는 상태를 반영하여 자동으로 그려짐
