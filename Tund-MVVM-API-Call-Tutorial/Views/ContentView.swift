//
//  ContentView.swift
//  Tund-MVVM-Refactor
//
//  Created by Dawei Hao on 2025/9/4.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = UsersViewModel()
    @State private var hasError = false
    @State private var error: UsersViewModel.UserError?
    
    var body: some View {
        ZStack {
            if viewModel.isLoading { ProgressView() }
            
            else {
                NavigationStack {
                    List {
                        ForEach(viewModel.users, id: \.id) { user in
                            UserInfoView(name:  user.name)
                                .listRowSeparator(.hidden)
                                .background(NavigationLink("", destination: UserDetailView(user: user)))
                                .opacity(0)
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Users")
                }
            }
        }
        .task {
            await execute()
        }
        .alert(isPresented: $hasError,
               error: error) {
            Button {
                Task {
                    await execute()
                }
            } label: {
                Text("Retry")
            }
        }
    }
}

#Preview {
    ContentView()
}

private extension ContentView {
    func execute () async {
        do {
            try await viewModel.fetchUsers()
            
        } catch {
            if let userError = error as? UsersViewModel.UserError {
                self.error = userError
                self.hasError = true
            }
        }
    }
}
