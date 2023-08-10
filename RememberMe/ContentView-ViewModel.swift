//
//  ContentView-ViewModel.swift
//  RememberMe
//
//  Created by Hubert Wojtowicz on 11/08/2023.
//

import Foundation
import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        // Struct of structs to storage whole data
        @Published var friends = [Friend]()

        // method to save JSON into device memory
        func save() {
            do {
                let data = try JSONEncoder().encode(friends)
                try data.write(to: FileManager.documentsDirectory.appendingPathComponent("SavedPlaces"))
            } catch {
                print("Unable to save.")
            }
        }
        
        // intializer that fetch data from device memory
        required init() {
            do {
                let data = try Data(contentsOf: FileManager.documentsDirectory.appendingPathComponent("SavedPlaces"))
                friends = try JSONDecoder().decode([Friend].self, from: data)
            } catch {
                friends = []
            }
        }
        
        // method to convert back jpeg into SwiftUI Image
         func convert(_ friend: Friend) -> Image{
             if let person = friend.photo {
                 let uiImage = UIImage(data: person)!
                 
                 return Image(uiImage: uiImage)
             }
             //while problem occure app will use one of system image
             return Image(systemName: "person.fill.turn.right")
         }
    }
}

