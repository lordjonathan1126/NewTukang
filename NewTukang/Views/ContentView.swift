//
//  ContentView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 21/08/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var show_search: Bool = false
    
    var body: some View {
        //GeometryReader for getting display width and height size
        GeometryReader{ geometry in
            NavigationView{
                // ZStack to change background color
                ZStack{
                    Color("Background")
                        .edgesIgnoringSafeArea(.all)
                    //Calling pulldown to refresh view
                    RefreshScrollView(width: geometry.size.width , height: geometry.size.height)
                        .edgesIgnoringSafeArea(.bottom)
                        .navigationBarTitle("TUKANG", displayMode: .automatic)
                        .navigationBarItems(trailing:
                                                Button(action: { self.show_search = true}) {
                                                    Image(systemName: "magnifyingglass")
                                                        .foregroundColor(Color("Accent"))
                                                        .font(.title)
                                                }.sheet(isPresented: self.$show_search){
                                                    SearchView()
                                                        .environment(\.managedObjectContext, self.moc)
                                                }
                        )
                }
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
