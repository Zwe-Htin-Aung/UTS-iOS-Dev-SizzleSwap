//
//  d.swift
//  SizzleSwap
//
//  Created by Samuel Polgar on 17/5/2022.
//

import SwiftUI

struct ContentView: View {
     
    @State var users: [User] = []
     
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(destination: DetailsView(userItem: user)) {
                       HStack {
                         Text(user.name)
                           .font(.headline)
                       }.padding(7)
                    }
               }
            .navigationBarTitle("Fetch JSON data")
            .onAppear {
                apiCall().getUsers { (users) in
                self.users = users
                }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


struct DetailsView: View {
    let userItem: User
     
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text(userItem.name)
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                 
                Text("Username: \(userItem.username)")
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                 
                Text("Email: \(userItem.email)")
                    .font(.title2)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle(Text(userItem.name), displayMode: .automatic)
    }
}
 

import Foundation

struct User: Codable, Identifiable {
    let id: String = UUID().uuidString
 
    let username: String
    let name: String
    let email: String
     
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
    }
}

import Foundation
 
class apiCall {
    func getUsers(completion:@escaping ([User]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let users = try! JSONDecoder().decode([User].self, from: data!)
            //print(users)
             
            DispatchQueue.main.async {
                completion(users)
            }
        }
        .resume()
    }
}
