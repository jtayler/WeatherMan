//
//  CityListLarge.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/12/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI

struct CityListLarge : View {
    
    @EnvironmentObject var cityStore: CityStore
    
    @State private var isPresentingSearch: Bool = false
    @State private var isEditing: Bool = false
    @State private var isPresented: Bool = false
    
    var modalPresentation: some View {
      NavigationView {
        Text("Hello World")
          .font(.caption)
          .navigationBarTitle(Text("Modal Contents"))
          .navigationBarItems(trailing: Button(action: { self.isPresented = false } ) { Text("Done") })
      }
    }

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                Group {
                    ForEach(0..<self.cityStore.cities.chunked(into: 2).count) { index in
                        HStack {
                            ForEach(self.cityStore.cities.chunked(into: 2)[index]) { city in
                                CityRowLarge(city: city, isEditing: self.isEditing, isWide: self.cityStore.largeView)
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(color: Color.black, radius: 20)
                            }
                        }
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }

            }
            .listStyle(PlainListStyle())
            .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
            .navigationBarItems(leading: Button(action: {
                self.$isEditing.wrappedValue.toggle()
            }) {
                Text(isEditing ? "Done" : "Edit")
            }, trailing: addButton)
                .navigationBarTitle(Text("Cities"))
                .sheet(isPresented: $isPresentingSearch, onDismiss: {
                    self.isPresentingSearch = false
                    self.isEditing = false
                }) {
                    self.newCityView
            }
        }
    }
    
    private var addButton: some View {
        Button(action: {
            self.isPresentingSearch.toggle()
            self.isEditing = false
        }) {
            Image(systemName: "plus.circle.fill")
                .font(.title)
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            cityStore.cities.remove(at: index)
        }
    }

    private func move(from source: IndexSet, to destination: Int) {
        var removeCities: [City] = []
        
        for index in source {
            removeCities.append(cityStore.cities[index])
            cityStore.cities.remove(at: index)
        }
        
        cityStore.cities.insert(contentsOf: removeCities, at: destination)
    }
    
    private var newCityView: some View {
        NewCity(isPresentingSearch: $isPresentingSearch).environmentObject(cityStore)
    }
    
}

//#if DEBUG
//struct CityListViewLarge_Previews : PreviewProvider {
//    static var previews: some View {
//        CityListLarge()
//    }
//}
//#endif
