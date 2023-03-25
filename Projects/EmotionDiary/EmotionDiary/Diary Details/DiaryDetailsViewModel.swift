//
//  DiaryDetailsViewModel.swift
//  EmotionDiary
//
//  Created by 승찬 on 2023/03/23.
//

import Foundation
import SwiftUI

final class DiaryDetailsViewModel: ObservableObject {
    
    @Published var diaries: Binding<[MoodDiary]>
    @Published var diary: MoodDiary
    
    init(diaries: Binding<[MoodDiary]>, diary: MoodDiary) {
        self.diaries = diaries
        self.diary = diary
    }
    
    func delete() {
        diaries.wrappedValue = diaries.wrappedValue.filter { $0.id != diary.id }
    }
}
