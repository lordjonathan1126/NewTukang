//
//  HomeVIew.swift
//  NewTukang
//
//  Created by Jonathan Ng on 21/08/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                TitleBar()
                ScrollView{
                    VStack{
                        SearchBar()
                        OurServiceView()
                        TrendingView()
                        SpecialistView()
                        Spacer()
                    }
                }
            }
        }.navigationBarHidden(true)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct TitleBar: View {
    var body: some View {
        HStack {
            Text("Tukang")
                .font(.largeTitle)
                .bold()
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "bell")
                    .foregroundColor(.purple)
                    .padding()
                    .background(
                        Circle()
                            .fill(Color("Background"))
                            .shadow(color: Color("LightShadow"), radius: 10, x: -8, y: -8)
                            .shadow(color: Color("DarkShadow"), radius: 10, x: 10, y: 10)
                )
            }
        }.padding(.horizontal)
            .padding(.top)
    }
}

struct OurServiceView: View{
    var body: some View{
        VStack(alignment:.leading){
            Text("Our Services")
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 15){
                    CategoryButton(title: "Hair", imageName: "hair")
                    CategoryButton(title: "Beauty", imageName: "beauty")
                    CategoryButton(title: "Nail", imageName: "nail")
                    CategoryButton(title: "Spa", imageName: "spa")
                    CategoryButton(title: "Lash", imageName: "lash")
                }.padding()
            }
        }.frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct CategoryButton: View {
    var title: String = "Category Title"
    var imageName: String = "beauty"
    var body: some View{
        VStack{
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding(.horizontal)
                .padding(.top)
                .foregroundColor(.white)
                .frame(width:80, height: 80, alignment:.center)
            Text(title)
                .font(.headline)
                .bold()
                .padding(.horizontal)
                .padding(.bottom)
             .foregroundColor(.white)
        }
        .frame(width: 90, height: 100)
        .background(Color("Background"))
        //.background(LinearGradient(gradient: Gradient(colors: [Color.pink,Color.purple]), startPoint: .top, endPoint: .bottomTrailing))
        .cornerRadius(10)
        .shadow(color: Color("LightShadow"), radius: 8, x: -5, y: -5)
        .shadow(color: Color("DarkShadow"), radius: 8, x: 5, y: 5)
        .blendMode(.overlay)
        
    }
}

struct SearchBar: View{
    @Environment(\.colorScheme) var colorScheme
    @State private var show_search: Bool = false
    
    var body: some View{
        Button(action: {
            self.show_search = true
        }) {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(height:35)
                    .foregroundColor(Color("Background"))
                    .padding()
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.purple)
                    Text("Search")
                    .bold()
                        .foregroundColor(.purple)
                }
            }
            .shadow(color: Color("LightShadow"), radius: 10, x: -5, y: -5)
            .shadow(color: Color("DarkShadow"), radius: 10, x: 5, y: 5)
            .blendMode(.overlay)
        }.sheet(isPresented: self.$show_search){
            SearchView()
        }
        
        
    }
}

struct TrendingView: View {
    var body: some View{
        VStack(alignment:.leading){
            VStack(alignment: .leading) {
                Text("Top Trending")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Top recommended services.")
                .font(.body)
                .foregroundColor(.gray)
            }.padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 20){
                    TrendingCards(imageName: "stock-1", title: "Galaxy Nail Design (3 colors 2 coat)", price: "138", stylist: "Tammy How")
                    TrendingCards(imageName: "stock-2", title: "Male Undercut Light Trimming", price: "128", stylist: "Jason Soong")
                    TrendingCards(imageName: "stock-3", title: "Hair Colouring", price: "108", stylist: "Jonathan Ng")
                    TrendingCards(imageName: "stock-4", title: "Sample Service 123", price: "138", stylist: "Tony Tran")
                }.padding()
            }
        }.frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top)
    }
}

struct TrendingCards: View{
    var imageName:String = "stock-1"
    var title:String = "Sample title"
    var price: String = "RM10"
    var stylist:String = "Tammy How"
    var body: some View{
        
        
        VStack{
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 260, height: 150, alignment: .center)
                .cornerRadius(10)
            
            Text(title)
                .lineLimit(nil)
                .padding(.horizontal)
                .padding(.top)
            Spacer()
            HStack {
                VStack(alignment:.leading){
                    Text("By:\(stylist)")
                        .foregroundColor(.gray)
                    Text("RM \(price)")
                        .foregroundColor(.purple)
                }.padding(.leading)
                Spacer()
            }.padding(.bottom)
            
        }.padding()
            .frame(width: 260, height: 240)
            .background(Color("Background"))
            .cornerRadius(12)
            .shadow(color: Color("LightShadow"), radius: 10, x: -8, y: -8)
            .shadow(color: Color("DarkShadow"), radius: 10, x: 8, y: 8)
            .blendMode(.overlay)
    }
}


struct SpecialistView: View {
    var body: some View{
        VStack(alignment:.leading){
            VStack (alignment:.leading){
                Text("Top Specialist")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Top specialist in your area.")
                .font(.body)
                .foregroundColor(.gray)
            }.padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 20){
                    TrendingCards(imageName: "stock-1", title: "Galaxy Nail Design (3 colors 2 coat)", price: "138", stylist: "Tammy How")
                    TrendingCards(imageName: "stock-2", title: "Male Undercut Light Trimming", price: "128", stylist: "Jason Soong")
                    TrendingCards(imageName: "stock-3", title: "Hair Colouring", price: "108", stylist: "Jonathan Ng")
                    TrendingCards(imageName: "stock-4", title: "Sample Service 123", price: "138", stylist: "Tony Tran")
                }.padding()
            }
        }.frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top)
    }
}
