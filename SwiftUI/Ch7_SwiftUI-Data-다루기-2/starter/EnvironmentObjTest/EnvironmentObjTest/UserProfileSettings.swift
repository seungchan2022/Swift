//
//  UserProfileSettings.swift
//  EnvironmentObjTest
//
//  Created by 승찬 on 2023/02/28.
//

import Foundation

final class UserProfileSettings: ObservableObject {
    
    @Published var name: String = ""
    @Published var age: Int = 0
    
    func haveBirthdayParty() {
        age += 1
    }
}
