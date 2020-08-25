//
//  AppTabBar.swift
//  NewTukang
//
//  Created by Jonathan Ng on 21/08/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct AppTabBar: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem{
                    VStack {
                        Image(systemName: "rectangle.3.offgrid")
                        Text("Home")
                    }.padding()
            }.tag(0)
            BookingView()
                .tabItem{
                    VStack{
                        Image(systemName: "calendar")
                        Text("Booking")
                    }.padding()
            }.tag(1)
            
            
            ProfileView()
                .tabItem{
                    VStack{
                        Image(systemName: "person.circle")
                        Text("Profile")
                    }.padding()
            }.tag(2)
        }.accentColor(.purple)
    }
}

struct AppTabBar_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBar()
    }
}
