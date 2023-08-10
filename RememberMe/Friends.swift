//
//  Friends.swift
//  RememberMe
//
//  Created by Hubert Wojtowicz on 11/08/2023.
//

import Foundation

enum CodingKeys: CodingKey {
    case profile
}

struct Friend: Comparable, Codable, Identifiable {
    var id = UUID()
    var name: String
    var photo: Data?
    var description: String = ""
    var birthdayGift: String = ""
    var hobby: String = ""
    
    static func < (lhs: Friend, rhs: Friend) -> Bool {
        lhs.name < rhs.name
    }
}
