//
//  TopView.swift
//  MVVM Combine
//
//  Created by bilal on 30/12/2021.
//

import SwiftUI
import MapKit

struct TopView: View {
    
    @Binding var region : MKCoordinateRegion
    var width : CGFloat
    @Binding var isTrue : Bool
    
    var body: some View {
        HStack{
            Spacer()
            Map(coordinateRegion: $region)
                .frame(width: sizeIt(), height: sizeIt())
                .clipShape(Circle())
        }

    }
    func sizeIt() -> CGFloat {
        isTrue ? width * 0.8 : width * 0.3
    }
}


//
//struct TopView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopView(region: <#Binding<MKCoordinateRegion>#>)
//    }
//}
