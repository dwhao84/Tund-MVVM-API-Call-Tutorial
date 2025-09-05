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
    @Published private(set) var error: UserError?
    
    // MARK: - Fetch users from API
    @MainActor
    func fetchUsers() async throws {
        isLoading = false
        error = nil
        
        let usersUrlString = "https://jsonplaceholder.typicode.com/users"
        if let url = URL(string: usersUrlString) {
            isLoading = true
            defer { isLoading = false }
            
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 299
                else {
                    self.error = UserError.invalidStatusCode
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let users = try decoder.decode([User].self, from: data)
                    self.users = users
                } catch {
                    self.error = UserError.failedToDecode
                }
                
            } catch {
                self.error = UserError.failedToDecode
            }
        } else {
            self.error = UserError.invalidURL
        }
    }
}

// MARK: - UserError
extension UsersViewModel {
    enum UserError: LocalizedError {
        case failedToDecode
        case invalidURL
        case invalidStatusCode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode the response."
            case .invalidURL:
                return "The URL provided was invalid."
            case .invalidStatusCode:
                return "The server returned an invalid status code."
            }
        }
    }
}
