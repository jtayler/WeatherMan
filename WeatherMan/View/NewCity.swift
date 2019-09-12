//
//  NewCity.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI

struct NewCity : View {
    
    @State var search = ""
    @State private var isValidating = false
    
    @ObservedObject private var completer = CityCompletion()
    
    @Binding var isPresentingSearch: Bool
    @EnvironmentObject var cityStore: CityStore
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Search City", text: $search, onEditingChanged: { changed in
                        print("onEditing: \(changed)")
                        self.searchNearby()
                    })
                    .onAppear { self.searchNearby() }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onReceive(search.publisher.last(), perform: { _search in self.searchNearby() })
                }
                
                Section {
                    ForEach(completer.predictions) { prediction in
                        Button(action: {
                            self.addCity(from: prediction)
                        }) {
                            Text(prediction.description)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .disabled(isValidating)
            .navigationBarTitle("Add City")
            .navigationBarItems(trailing: doneButton)
        
        }
        
    }
    
    private func searchNearby() {
            DispatchQueue.main.async {
                print("\n search.publisher() \(self.search)")
                self.completer.search(self.search)
            }
    }
    
    private var doneButton: some View {
        Button(action: {
            self.isPresentingSearch = false
        }) {
            Text("Done")
        }
    }
    
    private func addCity(from prediction: CityCompletion.Prediction) {
        isValidating = true
        print("adding city \(prediction)")

        CityValidationManager.validateCity(withID: prediction.id) { (city) in
            if let city = city {
                print("found city \(city)")
                DispatchQueue.main.async {
                    self.isPresentingSearch = false
                    self.cityStore.cities.append(city)
                }
            }
            
            DispatchQueue.main.async {
                self.isValidating = false
            }
        }
    }
    
}

//#if DEBUG
//struct NewCity_Previews : PreviewProvider {
//    static var previews: some View {
//        NewCity(isPresentingSearch: self.$isPresentingSearch)
//    }
//}
//#endif
