//
//  UserInfoView.swift
//  Tund-MVVM-Refactor
//
//  Created by Dawei Hao on 2025/9/4.
//

import SwiftUI

struct UserInfoView: View {
    
    let name: String
    
    var body: some View {
        VStack {
            Text(name)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.gray.opacity(0.1),
                    in: RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(name: "Dawei")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
