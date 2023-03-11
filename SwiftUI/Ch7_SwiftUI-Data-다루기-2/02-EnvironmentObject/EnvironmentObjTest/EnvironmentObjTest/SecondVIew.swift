//
//  SecondVIew.swift
//  EnvironmentObjTest
//
//  Created by 승찬 on 2023/03/11.
//

import SwiftUI

struct SecondVIew: View {
    
    var body: some View {
        
        VStack {
            NavigationLink {
                ThirdView()
            } label: {
                Text("Third View")
            }
        }
        .navigationTitle("Second View")
    }
}

struct SecondVIew_Previews: PreviewProvider {
    static var previews: some View {
        SecondVIew()
    }
}
