//
//  DiaryTextInputView.swift
//  EmotionDiary
//
//  Created by joonwon lee on 2022/07/02.
//

import SwiftUI

struct DiaryTextInputView: View {
    
    @ObservedObject var vm: DiaryVieModel
    
    // 키보드를 바로 올라가게 하기 위해
    @FocusState var focused: Bool
    
    var body: some View {
        VStack {
            TextEditor(text: $vm.text)
                .focused($focused)
                .border(.gray.opacity(0.2), width: 2)
            
            Button {
                vm.completed()
            } label: {
                Text("Done")
                    .frame(width: 200, height: 80)
                    .foregroundColor(.white)
                    .background(.pink)
                    .cornerRadius(40)
            }
        }
        .padding()
        .onAppear {
            print("on appear")
            focused = true
        }
    }
}

struct DiaryTextInputView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryTextInputView(vm: DiaryVieModel(isPresented: .constant(false), diaries: .constant(MoodDiary.list)))
    }
}
