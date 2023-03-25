//
//  DiaryMoodInputView.swift
//  EmotionDiary
//
//  Created by joonwon lee on 2022/07/02.
//

import SwiftUI

struct DiaryMoodInputView: View {
    
    // 선택할 감정들 표현
    // 감정 선택시, 저장
    // 뷰모델 앞에 뷰에서 받아오기
    
    @ObservedObject var vm: DiaryVieModel
    
    // 감정 리스트 (감정을 선택하기위해)
    // Mood가 CaseIterable이므로 allCases로 받을 수 있음
    let moods: [Mood] = Mood.allCases
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            HStack {
                ForEach(moods, id:\.self) { mood in
                    Button {
                        vm.mood = mood
                    } label: {
                        
                        VStack {
                            Image(systemName: mood.imageName)
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 60)
                                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
                                .padding()
                            Text(mood.name)
                                .foregroundColor(.gray)
                        }
                        .frame(height: 180)
                        .background(mood == vm.mood ? Color.gray.opacity(0.4) : Color.clear)
                        .cornerRadius(10)
                    }
                }
            }
            .padding()
            
            Spacer()
            
            NavigationLink {
                DiaryTextInputView(vm: vm)
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

struct DiaryMoodInputView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryMoodInputView(vm: DiaryVieModel(isPresented: .constant(false), diaries: .constant(MoodDiary.list)))
    }
}
