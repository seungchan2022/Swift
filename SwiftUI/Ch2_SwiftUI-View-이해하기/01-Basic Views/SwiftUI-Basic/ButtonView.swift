//
//  ButtonView.swift
//  SwiftUI-Basic
//
//  Created by 승찬 on 2023/03/09.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        Button {
            print("button tapped")
        } label: {
            Text("Click Me")
        }

    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
