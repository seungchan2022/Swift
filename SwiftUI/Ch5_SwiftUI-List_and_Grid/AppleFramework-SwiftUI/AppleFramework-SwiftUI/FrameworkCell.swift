//
//  FrameworkCell.swift
//  AppleFramework-SwiftUI
//
//  Created by 승찬 on 2023/03/10.
//

import SwiftUI

struct FrameworkCell: View {
    
    var framework: AppleFramework
    
    var body: some View {
        VStack {
            Image(framework.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            
            Text(framework.name)
                .font(.system(size: 16, weight: .bold))
            
            Spacer()
        }
    }
}

struct FrameworkCell_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkCell(framework: AppleFramework.list[0])
        // 셀을 만들때 특정 사이즈 확인하면서 변경하고 싶을때
            .previewLayout(.fixed(width: 160, height: 200))
    }
}
