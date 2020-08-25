//
//  SearchView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 24/08/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack{
                ServiceTypeView()
                PriceRangeView()
                KeySearchView()
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Search")
                        .bold()
                        .foregroundColor(.white)
                }.frame(width: 280, height: 40)
                    .background(Color.purple)
                    .cornerRadius(10)
                    .shadow(color: Color("DarkShadow"), radius: 3, x: 5, y: 5)
                    .padding()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct ServiceTypeView: View{
    var body: some View{
        VStack(alignment: .leading){
            Text("Type of Service")
                .font(.headline)
                .bold()
                .padding(.leading)
                .padding(.top)
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 12){
                    ServiceTypeButton(buttonText: "Hair")
                    ServiceTypeButton(buttonText: "Beauty")
                    ServiceTypeButton(buttonText: "Nail")
                    ServiceTypeButton(buttonText: "Spa")
                    ServiceTypeButton(buttonText: "Lash")
                }.padding()
            }
        }
    }
}

struct ServiceTypeButton: View {
    var buttonText:String = "Button"
    var body: some View{
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
            Text(buttonText)
                .foregroundColor(.white)
                .bold()
                .padding(10)
        }.background(RoundedRectangle(cornerRadius: 3)
            .fill(LinearGradient(gradient: Gradient(colors: [Color.pink,Color.purple]), startPoint: .top, endPoint: .bottomTrailing))
            .shadow(color: Color("DarkShadow"), radius: 3, x: 5, y: 5)
        )
        
    }
}

struct PriceRangeView: View{
    var body: some View{
        VStack(alignment: .leading){
            Text("Price Range")
                .font(.headline)
                .bold().padding(.leading)
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 12){
                    PriceRangeButton(buttonText: "<50")
                    PriceRangeButton(buttonText: "<100")
                    PriceRangeButton(buttonText: "<200")
                    PriceRangeButton(buttonText: "<300")
                    PriceRangeButton(buttonText: "<500")
                }.padding()
            }
        }
    }
}

struct PriceRangeButton: View {
    var buttonText:String = "Button"
    var body: some View{
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
            Text(buttonText)
                .foregroundColor(.white)
                .bold()
                .padding(10)
        }.background(RoundedRectangle(cornerRadius: 3)
            .fill(LinearGradient(gradient: Gradient(colors: [Color.pink,Color.purple]), startPoint: .top, endPoint: .bottomTrailing))
            .shadow(color: Color("DarkShadow"), radius: 3, x: 5, y: 5)
        )
    }
}

struct KeySearchView: View {
    var searchFieldText:String = ""
    
    @Environment(\.colorScheme) var colorScheme
    var backgroundColor: Color {
        if colorScheme == .dark {
            return Color(.systemGray5)
        } else {
            return Color(.systemGray6)
        }
    }
    
    var body: some View{
        VStack(){
            VStack(alignment: .leading) {
                Text("Key Search")
                    .font(.headline)
                    .bold()
            }
            TextField("Search", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
                .frame(height: 40)
                .background(backgroundColor)
                .cornerRadius(8)
                .shadow(color: Color("DarkShadow"), radius: 3, x: 5, y: 5)
                
        }.padding()
    }
}
