//
//  ContentView.swift
//  MVVM Combine
//
//  Created by bilal on 30/12/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var location = UserLocViewModel()
    @ObservedObject var weatherList = WeatherListViewModel()
    @State var isTrue: Bool = false
    @State var inputTextField = ""
    
    var body: some View {
        if location.userLocation == nil {
            Text("Chargement...")
                .padding()
        } else {
            GeometryReader { geo in
                NavigationView {
                    List {
                            TopView(region: .constant(location.setRegion(user: location.userLocation!)), width: geo.size.width, isTrue: $isTrue)
                                .onTapGesture {
                                self.isTrue.toggle()
                                }
                        HStack {
                            TextField("Ajouter une ville", text:$inputTextField)
                            Button {
                                location.convertAdress(adress: inputTextField)
                            } label: {
                                Image(systemName: "paperplane.fill")
                            }
                        }
                        Section(header: Text("Previsions"), content: {
                            ForEach(weatherList.weatherList) { weather in
                                Text(weather.desc)
                            }
                        })
                    }
                    .animation(.linear, value: isTrue)
                    .navigationTitle(location.userLocation?.city ?? "erreur")
                    .navigationBarItems(trailing: Button(action: {
                        location.toggleLocation()
                    }, label: {
                        Image(systemName: location.showLocation ? "location.fill" : "location.slash.fill")
                    }))
                }
                .onAppear() {
                    if let user = location.userLocation {
                        weatherList.requestforecast(userLocation: user)
                    }
                }
                .onChange(of: location.userLocation?.city) { _ in
                    if let user = location.userLocation {
                        weatherList.requestforecast(userLocation: user)
                    }

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
