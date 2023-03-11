//
//  UserProfileSettings.swift
//  EnvironmentObjTest
//
//  Created by 승찬 on 2023/03/11.
//

import Foundation

final class UserProfileSettings: ObservableObject {
    @Published var age: Int = 0
    
    func havingBirthParty() {
        age += 1
    }
}
