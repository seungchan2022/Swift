//
//  DiaryVieModel.swift
//  EmotionDiary
//
//  Created by 승찬 on 2023/03/23.
//

import Foundation
import SwiftUI
import Combine


final class DiaryVieModel: ObservableObject {
 
    //  생성한 다이어리(diaries)를 list에 추가 해주면 ListViewModel 의아래 로직들이 업데이트 되면서 View가 자동으로 렌더링 된다
    
    // => DiaryListViewModel에 있는 list -> diaries를 참조하는 데이터로 만들어야 한다.
    @Published var diaries: Binding<[MoodDiary]>
    //  결국 버튼을 눌러서 만들고 싶은 것은 다이어리 통째로 하나이다. 그래서 MoodDairy의 내용들이 업데이트되면 되는것
    @Published var diary: MoodDiary = MoodDiary(date: "", text: "", mood: .great )
    
    @Published var date: Date = Date()
    @Published var mood: Mood = .great
    @Published var text: String = ""
    @Published var isPresented: Binding<Bool>
    
    var subscriptions = Set<AnyCancellable>()
    
    init(isPresented: Binding<Bool>, diaries: Binding<[MoodDiary]>) {
        self.isPresented = isPresented
        self.diaries = diaries
        
        $date.sink { date in
            self.updateDate(date: date)
        }.store(in: &subscriptions)
        
        $mood.sink { mood in
            self.updateMood(mood: mood)
        }.store(in: &subscriptions)
        
        $text.sink { text in
            self.updateText(text: text)
        }.store(in: &subscriptions)
    }
    
    private func updateDate(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        self.diary.date = formatter.string(from: date)
    }
    
    private func updateMood(mood: Mood) {
        self.diary.mood = mood
    }
    
    private func updateText(text: String) {
        self.diary.text = text
    }
    
    func completed() {
        guard diary.date.isEmpty == false else { return }
        print("다이어리 추가")
        
        // 저장하고 (바인딩으로 받아온 데이터를 원본데이터에 추가)
        diaries.wrappedValue.append(diary)
        
        // 닫기 (모달을 닫는것)
        isPresented.wrappedValue = false
    }
}
