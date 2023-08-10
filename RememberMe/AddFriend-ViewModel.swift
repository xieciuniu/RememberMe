//
//  AddFriend-ViewModel.swift
//  RememberMe
//
//  Created by Hubert Wojtowicz on 12/08/2023.
//

import Foundation
import SwiftUI

extension AddFriend {
    @MainActor class ViewModel: ObservableObject {
        
        // to store name
        @Published var name = ""
        
        // to store optional image
        @Published var image: Image?
        
        // to show picker of image, true at beggining so picker show at start
        @Published  var showPicker = true
        
        // UI inputImage
        @Published var inputImage: UIImage?
        
        
        // method to show choosen image
        func loadImage() {
            // work only if inputImage isn't nil
            guard let inputImage = inputImage else { return }
            
            //change from UIImage into SwiftUI image
            image = Image(uiImage: inputImage)
        }
        
        // method to save new person and add it
        func newPerson() -> Friend {
            // convert UIImage into jpegData to save it
            let jpegData =  inputImage?.jpegData(compressionQuality: 0.8)
            // creating struct with information about person
            let onePerson = Friend(name: name, photo: jpegData)
        
            return onePerson
        }
    }
}
