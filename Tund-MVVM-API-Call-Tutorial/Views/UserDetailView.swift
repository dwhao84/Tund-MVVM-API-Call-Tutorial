//
//  UserDetailView.swift
//  Tund-MVVM-Refactor
//
//  Created by Dawei Hao on 2025/9/5.
//

import SwiftUI

struct UserDetailView: View {
    
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                info
                
                Divider()
                contact
                
                Divider()
                
                company
                
                Divider()
                
                address
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding()
            .navigationTitle("User Detail")
        }
    }
}

private extension UserDetailView {
    
    var info: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Info")
                .bold()
            Text(user.name)
            Text(user.username)
        }
    }
    
    var contact: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Contact")
                .bold()
            Text(user.website)
            Text(user.phone)
            Text(user.email)
        }
    }
    
    var company: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Company")
                .bold()
            Text(user.company.name)
        }
    }
    
    var address: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Address")
                .bold()
            Text(user.address.street)
            Text(user.address.suite)
            Text(user.address.city)
            Text(user.address.zipcode)
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: .dummy)
            .previewLayout(.sizeThatFits)
    }
}

/// 假資料
extension User {
    static var dummy: User {
        User(
            id: 1,
            name: "Leanne Graham",
            username: "Bret",
            email:"",
            address: Address(
                street: "Kulas Light",
                suite: "Apt. 556",
                city: "Gwenborough",
                zipcode: "92998-3874",
                geo: Geo(
                    lat: "-37.3159",
                    lng: "81.1496"
                )
            ),
            phone: "1-770-736-8031 x56442",
            website: "hildegard.org",
            company: .init(
                name: "Romaguera-Crona",
                catchPhrase: "Multi-layered client-server neural-net",
                bs: "",
            )
        )
    }
}
