//
//  DiaryListViewModel.swift
//  EmotionDiary
//
//  Created by 승찬 on 2023/03/23.
//

import Foundation
import Combine

final class DiaryListViewModel: ObservableObject {
    
    //    원하는것
    //    Sequence -> Dictionary
    //
    //    AS-IS
    //    [MoodDiary]
    //
    //    ->
    //
    //    TO-BE
    //    [String: [MoodDiary]]
    //    "2022-04" : [MoodDiary]
    //    "2022-05" : [MoodDiary]
    //    "2022-06" : [MoodDiary]
    //    "2022-07" : [MoodDiary]
    
    
    let storage: MoodDiaryStorage
    
    // Diary Creation에서 만든 다이어리를 list에 추가 하면 변경이 되서 아래 로직을 타 다른 내용들이 업데이트 된다.
    @Published var list: [MoodDiary] = []
    @Published var dic: [String: [MoodDiary]] = [:]
    
    var subscriptions = Set<AnyCancellable>()
    
    // 데이터 파일에서 일기 리스트 가져오기
    // list에 해당 일기 객체들 세팅
    // list 세팅 되면, dic도 세팅하기
    
    init(storage: MoodDiaryStorage) {
        self.storage = storage
        bind()
    }
    
    // dic의 key들을 표현
    var keys: [String] {
        // given: "2022-04", "2022-06", "2022-05"
        // sotred: "2022-04", "2022-05", "2022-06" 
        return dic.keys.sorted { $0 < $1 }
    }
    
    private func bind() {
        $list.sink { items in
            print("==> List Changed: \(items)")
                                                    // grouping 시키는 기준
            self.dic =  Dictionary(grouping: items, by: { $0.monthlyIdentifier })
            self.persist(items: items)  // list가 업데이트 될때마다 저장 
        }.store(in: &subscriptions)
    }
    
    func persist(items: [MoodDiary]) {
        guard items.isEmpty == false else { return }
        self.storage.persist(items)
    }
    
    func fetch() {
        self.list = storage.fetch()
    }
}
