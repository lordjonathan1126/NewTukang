//
//  StylistView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 18/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct StylistView: View {
    @FetchRequest(
        entity: CoreStylist.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: false)]
    ) var stylists: FetchedResults<CoreStylist>
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                    LazyVStack(spacing: 5){
                        ForEach(_stylists.wrappedValue, id: \.self){ stylist in
                            StylistCard( imageName:"\(stylist.img!)", stylistId:"\(stylist.id)",stylistName: "\(stylist.name!)", location: "\(stylist.location!)")
                            Divider()
                        }.id(UUID())
                    }.padding(.bottom)
            }
        }.navigationBarTitle("Stylists", displayMode: .inline)
    }
}
struct StylistCard: View{
    var imageName:String = ""
    var stylistId:String = "1"
    var stylistName:String = "Tammy How"
    var location:String = "KL"
    
    var body: some View{
        NavigationLink(destination: StylistDetailView(stylistId: stylistId, title: "\(stylistName)")){
            HStack{
                UrlImageView(urlString: "\(imageName)")
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .overlay(Circle().stroke(Color("Accent")))
                    .padding()
                Spacer()
                VStack(alignment: .trailing){
                    HStack {
                        Spacer()
                        Text("\(stylistName)")
                            .font(.title)
                    }
                    HStack {
                        Spacer()
                        Text("\(location)")
                            .foregroundColor(Color("Accent"))
                    }
                }.padding()
            }
            .background(Color("Background"))
            .cornerRadius(12)
            //.shadow(color: Color("LightShadow"), radius: 5, x: -8, y: -8)
            //.shadow(color: Color("DarkShadow"), radius: 5, x: 8, y: 8)
            //.blendMode(.overlay)
            .padding(.top)
            .padding(.horizontal)
        }.buttonStyle(PlainButtonStyle())
    }
}
