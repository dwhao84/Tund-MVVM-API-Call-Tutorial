//
//  ViewModel.swift
//  Tund-MVVM-Refactor
//
//  Created by Dawei Hao on 2025/9/4.
//

import Foundation

final class UsersViewModel: ObservableObject {
    
    @Published private(set) var users: [User] = []
    @Published private(set) var isLoading: Bool = false
    
        func fetchUsers() async throws {
            isLoading = true
            defer { isLoading = false }
            
            let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let users = try JSONDecoder().decode([User].self, from: data)
            self.users = users
        }
}
