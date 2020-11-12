//
//  ContentView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 21/08/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var show_search: Bool = false
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var webService = WebService()
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    Color("Background")
                        .edgesIgnoringSafeArea(.all)
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
