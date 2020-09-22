//
//  StylistView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 18/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI
import URLImage

struct StylistView: View {
    @FetchRequest(
        entity: CoreStylist.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: true)]
    ) var stylists: FetchedResults<CoreStylist>
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                if #available(iOS 14.0, *) {
                    LazyVStack(spacing: 14){
                        ForEach(_stylists.wrappedValue, id: \.self){ stylist in
                            StylistCard( imageName:"\(stylist.img!)", stylistId:"\(stylist.id)",stylistName: "\(stylist.name!)", location: "\(stylist.location!)")
                        }
                    }
                }else{
                    VStack(spacing: 14){
                        ForEach(_stylists.wrappedValue, id: \.self){ stylist in
                            StylistCard( imageName:"\(stylist.img!)" , stylistId:"\(stylist.id)", stylistName: "\(stylist.name!)", location: "\(stylist.location!)" )
                        }
                    }
                }
            }
        }.navigationBarTitle("Stylist", displayMode: .inline)
    }
}

struct StylistView_Previews: PreviewProvider {
    static var previews: some View {
        StylistView()
    }
}

struct StylistCard: View{
    var imageName:String = ""
    var stylistId:String = "1"
    var stylistName:String = "Tammy How"
    var location:String = "KL"
    let urlPath = Bundle.main.url(forResource: "Beauty", withExtension: "png")!
    
    var body: some View{
        NavigationLink(destination: StylistDetailView(stylistId: stylistId, title: "\(stylistName)")){
            HStack{
                URLImage((URL(string: imageName) ?? urlPath) , placeholder: {_ in
                    Image("Beauty")
                        .resizable()
                        .frame(width: 100.0, height: 100.0)
                }){proxy in
                    proxy.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                        .overlay(Circle().stroke(Color("Accent")))
                        .padding()
                }
                
                Spacer()
                VStack(alignment: .center){
                    Text("\(stylistName)")
                        .font(.title)
                    Text("\(location)")
                        .foregroundColor(Color("Accent"))
                }.padding()
            }
            .background(Color("Background"))
            .cornerRadius(12)
            .shadow(color: Color("LightShadow"), radius: 5, x: -5, y: -5)
            .shadow(color: Color("DarkShadow"), radius: 5, x: 8, y: 8)
            .blendMode(.overlay)
            .padding(.top)
            .padding(.horizontal)
        }.buttonStyle(PlainButtonStyle())
        
    }
}
