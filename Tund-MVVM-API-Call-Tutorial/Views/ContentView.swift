//
//  ContentView.swift
//  Tund-MVVM-Refactor
//
//  Created by Dawei Hao on 2025/9/4.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = UsersViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isLoading { ProgressView() }
            
            else {
                NavigationStack {
                    List {
                        ForEach(viewModel.users, id: \.id) { user in
                            UserInfoView(name:  user.name)
                                .background(NavigationLink("", destination: UserDetailView(user: user)))
                                .opacity(0)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .navigationTitle("Users")
                }
            }
        }
        .task {
            do { try await viewModel.fetchUsers() }
            catch { print("Error fetching users: \(error)") }
        }
    }
}

#Preview {
    ContentView()
}
