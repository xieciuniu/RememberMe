//
//  Description.swift
//  RememberMe
//
//  Created by Hubert Wojtowicz on 12/08/2023.
//

import SwiftUI

struct Description: View {
    
    // whole struct instead of all small stuff
    @State var friend: Friend
    
    @Binding var all: [Friend]
    
    // Description
    @State public var description: String

    // hobby
    @State public var hobby : String

    // birthdayGift
    @State public var birthdayGift : String
    
    
    var body: some View {
        NavigationView {
            VStack{
                
                imagine(friend)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
                
                
                Form {
                    Section("Description") {
                        TextEditor(text: $description)
                    }
                    
                    Section("Hobby") {
                        TextEditor(text: $hobby)
                    }
                    
                    Section("Birthday Gift") {
                        TextEditor(text: $birthdayGift)
                    }
                    
                        
                    }
                Button("Save"){
                    save()
                }
            }
        }
        .background(.red)
    }
    
    // method to save description, hobby, birthdayGift
    func save() {
        
        if let idx = all.firstIndex(where: {$0.id == friend.id}) {
            all[idx].birthdayGift = birthdayGift
            all[idx].description = description
            all[idx].hobby = hobby
        }

        do {
            let data = try JSONEncoder().encode(all)
            try data.write(to: FileManager.documentsDirectory.appendingPathComponent("SavedPlaces"))
        } catch {
            print("Unable to save")
        }
    }
    
    // method to convert jpeg into image
    func imagine(_ friend: Friend) -> Image {
        if let jpeg = friend.photo {
            if let uiImage = UIImage(data: jpeg) {
                return Image(uiImage: uiImage)
            }
        }
        
        return Image(systemName: "person.crop.circle.badge.exclamationmark")
    }
    
    init(friend: Friend, all: Binding<[Friend]>) {
        _friend = State(initialValue: friend)

        self._all = all
        
        _birthdayGift = State(initialValue: friend.birthdayGift )
        _description = State(initialValue: friend.description )
        _hobby = State(initialValue: friend.hobby )
    }
}

//struct Description_Previews: PreviewProvider {
//    static var previews: some View {
//        Description(friend: Friend(name: "NoName"), all: Binding<[Friend]>)
//    }
//}
