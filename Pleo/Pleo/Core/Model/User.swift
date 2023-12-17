//
//  User.swift
//  Pleo
//
//  Created by Vinter Marco on 17.12.2023.
//

import Foundation

struct User : Identifiable, Codable {
    let id : String
    let fullName : String
    let emai : String
    
    var initials : String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}


extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Vinter Marco", emai: "vintermarco98@gmail.com")
}
