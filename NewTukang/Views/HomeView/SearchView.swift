//
//  SearchView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 24/08/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{
            ZStack{
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    ScrollView{
                        ServiceTypeView()
                        PriceRangeView()
                        KeySearchView()
                        Spacer()
                        
                    }
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Text("Search")
                            .bold()
                            .foregroundColor(.white)
                    }.frame(width: 280, height: 40)
                    .background(Color("Accent"))
                    .cornerRadius(10)
                    .shadow(color: Color("DarkShadow"), radius: 3, x: 5, y: 5)
                    .padding()
                }
            }
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark.circle")
                    .foregroundColor(Color("Accent"))
            })
            .navigationBarTitle("Search", displayMode: .inline)
        }.navigationViewStyle(StackNavigationViewStyle())
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
    @Environment(\.colorScheme) var colorScheme
    var buttonText:String = "Button"
    var body: some View{
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
            Text(buttonText)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
                .bold()
                .padding(10)
        }.background(RoundedRectangle(cornerRadius: 3)
                        .fill(Color("Background"))
                        .shadow(color: Color("LightShadow"), radius: 2, x: -2, y: -2)
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
    @Environment(\.colorScheme) var colorScheme
    var buttonText:String = "Button"
    var body: some View{
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
            Text(buttonText)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
                .bold()
                .padding(10)
        }
        .background(Color("Background")
                        .shadow(color: Color("LightShadow"), radius: 3, x: -3, y: -3)
                        .shadow(color: Color("DarkShadow"), radius: 3, x: 5, y: 5)
        )
    }
}

struct KeySearchView: View {
    var searchFieldText:String = ""
    
    var body: some View{
        VStack(){
            VStack(alignment: .leading) {
                HStack {
                    Text("Key Search")
                        .font(.headline)
                        .bold()
                    Spacer()
                }
            }
            TextField("Search", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
                .frame(height: 40)
                .background(Color("Background"))
                .cornerRadius(8)
                .shadow(color: Color("LightShadow"), radius: 3, x: -3, y: -3)
                .shadow(color: Color("DarkShadow"), radius: 3, x: 5, y: 5)
        }.padding()
    }
}

struct AreaSearchView: View {
    @State private var selectedArea = 0
    var area = ["+60 Malaysia 🇲🇾","+65 Singapore 🇸🇬","+62 Indonesia 🇮🇩","+66 Thailand 🇹🇭","+84 Vietnam 🇻🇳","+852 Hong Kong 🇭🇰","+886 Taiwan 🇹🇼","+82 Korea 🇰🇷","+81 Japan 🇯🇵","+86 China 🇨🇳"]
    var body: some View {
        VStack {
            Text("Area Search")
            Picker(selection: $selectedArea, label: Text("")) {
                ForEach(0 ..< area.count) {
                    Text(self.area[$0])
                }
            }.pickerStyle(WheelPickerStyle())
        }
    }
}
