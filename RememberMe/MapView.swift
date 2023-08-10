//
//  MapView.swift
//  RememberMe
//
//  Created by Hubert Wojtowicz on 14/08/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    // starting point of map
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3, longitude: -122), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    // full list
    @Binding var friends: [Friend]
    
    //Struct of images to not convert it in runtime
    var photoList: [Image] = []
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $mapRegion, annotationItems: friends){ location in
                MapAnnotation(coordinate: location.coordinate) {
                    // making circle with image of friend and going into description after tap on it
                    NavigationLink {
                        Description(friend: location, all: $friends)
                            .navigationTitle(location.name)
                    } label: {
                        // geting id of each friend to choose image from struct
                        if let indx = friends.firstIndex(where: {$0.id == location.id}){
                            photoList[indx]
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 66, height: 66)
                        }
                    }
                    
                }
            }
        }
    }
    
    init(friends: Binding<[Friend]>) {
        // passing full list of friends
        self._friends = friends

        // create list of image to make it preloaded
        for _friend in _friends {
            if let uIImage = UIImage(data: _friend.photo.wrappedValue!) {
                let img: Image = Image(uiImage: uIImage)
                photoList.append(img)
            }
        }
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
