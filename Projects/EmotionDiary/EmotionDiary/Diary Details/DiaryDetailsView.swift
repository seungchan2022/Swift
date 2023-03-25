//
//  DiaryDetailsView.swift
//  EmotionDiary
//
//  Created by joonwon lee on 2022/07/02.
//

import SwiftUI

struct DiaryDetailsView: View {
    
    @StateObject var vm: DiaryDetailsViewModel
    
    // 다크 모드일때와 라이트 모드일때 다른 색으로 보이기 위해 환경변수 사용
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        VStack {
            ScrollView {
                VStack(spacing: 60) {
                    
                    Text(formattedDate(dateString: vm.diary.date))
                        .font(.system(size: 30, weight: .bold))
                    Image(systemName: vm.diary.mood.imageName)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 0)
                        .frame(height: 80)
                        .padding()
                    Text(vm.diary.text)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                .frame(maxWidth: .infinity)
            }
            
            Spacer()
            
            HStack {
                Button {
                    print("Delete Button Tapped")
                    vm.delete()
                } label: {
                    Image(systemName: "trash")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                }
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding()
                
                Spacer()
            }
        }
    }
}

extension DiaryDetailsView {
    private func formattedDate(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let date = formatter.date(from: dateString)

        formatter.dateFormat = "EEE, MMM d, yyyy"
        return formatter.string(from: date!)
    }
}

struct DiaryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = DiaryDetailsViewModel(diaries: .constant(MoodDiary.list), diary: MoodDiary.list.first!)
        DiaryDetailsView(vm: vm)
    }
}
