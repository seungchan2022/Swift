//
//  EnvironmentObjTestApp.swift
//  EnvironmentObjTest
//
//  Created by joonwon lee on 2022/06/12.
//

import SwiftUI

// 앱이 시작하는 부분
@main
struct EnvironmentObjTestApp: App {
    // 앱시작 부분의 single source of truth를 만든다
    @StateObject var userProfile = UserProfileSettings()
    
    var body: some Scene {
        WindowGroup {    // single source of truth 정보 꽂아주기
            FirstView().environmentObject(userProfile)
        }
    }
}
