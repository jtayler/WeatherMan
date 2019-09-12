//
//  CityList.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI
import CoreLocation

struct CityList : View {
    
    @EnvironmentObject var cityStore: CityStore
    
    @State var locationAuthorizationStatus: CLAuthorizationStatus
    
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
            List {
                ForEach(cityStore.cities) { city in
                    CityRow(city: city, isEditing: self.isEditing, isWide: self.cityStore.largeView)
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
            }
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
        .onAppear {
            // We wanted to navigate to always show a city
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

