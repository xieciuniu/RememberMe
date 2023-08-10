//
//  ContentView.swift
//  RememberMe
//
//  Created by Hubert Wojtowicz on 10/08/2023.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    // View model
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                // button to delete whole data
                Button("Click me, to destroy whole world"){
                    while viewModel.friends.isEmpty != true {
                        viewModel.friends.remove(at: 0)
                    }
                    
                    viewModel.save()
                }
                
                // list people you added
                ForEach(viewModel.friends.sorted()) { friend in
                    NavigationLink {
                        
                        // passing clicked friend and whole struct to modify it
                        Description(friend: friend, all: $viewModel.friends)
                        // title made by friend name
                            .navigationTitle(friend.name)
                    } label: {
                        HStack {
                            // small image of friend
                            viewModel.convert(friend)
                                .resizable()
                                .clipShape(Capsule())
                                .scaledToFit()
                                .frame(width: 40, height: 40)

                            Text(friend.name)


                        }
                    }
                }
                
                // Show friends on map
                NavigationLink {
                    MapView(friends: $viewModel.friends)
                        .navigationTitle("Map of Friends")
                        .ignoresSafeArea()
                } label: {
                    Text("Show map")
                }
            }
            
            
            .navigationTitle("RememberMe")
            // toolbar button to go into other view
            .toolbar {
                NavigationLink{
                    AddFriend(test: $viewModel.friends)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
