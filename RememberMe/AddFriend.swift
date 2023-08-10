//
//  AddFriend.swift
//  RememberMe
//
//  Created by Hubert Wojtowicz on 10/08/2023.
//

import SwiftUI

struct AddFriend: View {
    // dismiss
    @Environment(\.dismiss) var dismiss
    
    // getting whole list of friend to save it
    @Binding var test: [Friend]
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Place to preview choosen photo
                ZStack {
                    Rectangle()
                        .fill(.gray)
                        .frame(width: 300 ,height: 350)
                    
                    viewModel.image?
                        .resizable()
                        .scaledToFit()
                    
                }
                .padding([.bottom, .horizontal])
                
                // Button to change picture
                Button {
                    viewModel.showPicker = true
                } label: {
                    Text("Change photo")
                }
                
                // textfield to put name of person
                TextField("Name", text: $viewModel.name)
                    .padding()
                
                Spacer()
                
                Button{
                    // save new perons into whole struct
                    save()
                    
                    dismiss()
                } label: {
                    Text("Add")
                }
                Spacer()
            }
            .sheet(isPresented: $viewModel.showPicker) {
                ImagePicker(image: $viewModel.inputImage)
                    .onChange(of: viewModel.inputImage) { _ in viewModel.loadImage() }
            }
        }
    }
    
    func save() {
        
        // adding new person to whole list
        test.append(viewModel.newPerson())
        
        do {
            let data = try JSONEncoder().encode(test)
            try data.write(to: FileManager.documentsDirectory.appendingPathComponent("SavedPlaces"))
        } catch {
            print("Unable to save.")
        }
    }


    
    init(test: Binding<[Friend]>) {
        self._test = test
    }
}
