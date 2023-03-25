//
//  DiaryDateInputView.swift
//  EmotionDiary
//
//  Created by joonwon lee on 2022/07/02.
//

import SwiftUI

// 새로 생성 버튼 -> 날짜 입력 -> 감정 입력 -> 일기 입력 -> 저장

struct DiaryDateInputView: View {
    
    // DatePicker
    // - selection date 가 저장될 곳
    
    // isPresented가 저장될 곳
    
    // ViewModel 만들기
    
    // NavigationView
    
    //   이 두개가 viewModel로 들어감
    //    @State var date: Date = Date()
    //    @Binding var isPresented: Bool
    
    @StateObject var vm: DiaryVieModel
    
    var body: some View {
        
        NavigationView {
            VStack {
                Spacer()
                
                DatePicker(
                    "Start Date",
                    selection: $vm.date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                
                Spacer()
                
                NavigationLink {
                    DiaryMoodInputView(vm: vm)
                } label: {
                    Text("Next")
                        .frame(width: 200, height: 80)
                        .foregroundColor(.white)
                        .background(.pink)
                        .cornerRadius(40)
                }
                
            }
            
        }
    }
    
}

struct DiaryDateInputView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = DiaryVieModel(isPresented: .constant(false), diaries: .constant(MoodDiary.list))
        DiaryDateInputView(vm: vm)
    }
}
