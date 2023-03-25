//
//  ContentView.swift
//  EmotionDiary
//
//  Created by joonwon lee on 2022/07/02.
//

import SwiftUI

// 섹션을 월별로 나누고, 한줄에 5개의 아이템이 들어가도록

struct DiaryListView: View {
    
    // 섹션뷰 고도화
    // - 월, 년
    
    // 네비게이션 뷰 + 뉴 버튼
    
    // 그리드 아이템 탭할때
    // - 상세뷰 이동 (navigationLink)
    
    @StateObject var vm: DiaryListViewModel
    @State var isPresenting: Bool = false    // 모달로 띄울것
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: layout) {
                        // 각 섹션별로 구분을 한 다음
                        ForEach(vm.keys, id:\.self) { key in
                            // key를 이용해서 섹션을 만듬
                            Section {
                                // Section에 들어갈 아이템들을 구하고 그것을 정렬 (기준: date)
                                let items = vm.dic[key] ?? []
                                let orderedItems = items.sorted { $0.date < $1.date }
                                // 각 섹션 별로 그 안에 셀을 표현함
                                ForEach(orderedItems) { item in
                                    NavigationLink {
                                        let vm = DiaryDetailsViewModel(diaries: $vm.list, diary: item)
                                        DiaryDetailsView(vm: vm)
                                    } label: {
                                        MoodDiaryCell(diary: item)
                                            .frame(height: 50)
                                    }
                                }
                            } header: {
                                Text(formattedSectionTitle(key))
                                    .font(.system(size: 30, weight: .black))
                            }
                            .frame(height: 60)
                            .padding()
                        }
                    }
                }
                
                HStack {
                    Button {
                        print("Button Tapped")
                        isPresenting = true
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                    }
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
                    .background(.pink)
                    .cornerRadius(40)
                    
                }
            }
            .navigationTitle("Emotion Diary")
        }
        // 모달
        .sheet(isPresented: $isPresenting) {
            // 띄울 대상이 되는 view
            let vm = DiaryVieModel(isPresented: $isPresenting, diaries: $vm.list) 
            DiaryDateInputView(vm: vm)
        }
        .onAppear {
            vm.fetch()
        }
    }
}

extension DiaryListView {
    // "2022-04" -> "April 2022" or "4월 2022"
    private func formattedSectionTitle(_ id: String) -> String {
        let dateComponents = id
            .components(separatedBy: "-")
            .compactMap{ Int($0) }
        guard let year = dateComponents.first, let month = dateComponents.last else {
            return id
        }
        
        
        let calendar = Calendar(identifier: .gregorian)
        let dateComponent = DateComponents(calendar: calendar, year: year, month: month)
        let date = dateComponent.date!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListView(vm: DiaryListViewModel(storage: MoodDiaryStorage()))
    }
}
