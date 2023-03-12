//
//  UserProfileSettings.swift
//  EnvironmentObjTest
//
//  Created by 승찬 on 2023/03/12.
//

import Foundation

final class UserProfileSettings: ObservableObject {
    @Published var age: Int = 0
    
    func havingBirthdayParty() {
        age += 1
    }
}
