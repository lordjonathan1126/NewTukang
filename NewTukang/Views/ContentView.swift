//
//  ContentView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 21/08/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    Color("Background")
                        .edgesIgnoringSafeArea(.all)
                    RefreshScrollView(width: geometry.size.width , height: geometry.size.height)
                        .edgesIgnoringSafeArea(.bottom)
                        .navigationBarTitle("TUKANG", displayMode: .automatic)
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
