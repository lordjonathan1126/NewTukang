//
//  CardsView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 10/11/20.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct HorizontalPostCards: View{
    var title:String = "Sample title"
    var price: Double = 10.00
    var stylist:String = "Tammy How"
    var desc:String = "Description"
    var duration:String = "120"
    var imageUrl:String
    var discount: Double = 0.0
    let urlPath = Bundle.main.url(forResource: "Beauty", withExtension: "png")!
    
    @FetchRequest var stylists: FetchedResults<CoreStylist>
    
    init(stylistId:String, title:String, price:Double, desc:String, duration:String, imageUrl:String, discount:Double){
        self._stylists = FetchRequest<CoreStylist>(
            entity: CoreStylist.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: true)],
            predicate: NSPredicate(format: "id == %@", stylistId))
        self.title = title
        self.price = price
        self.desc = desc
        self.duration = duration
        self.discount = discount
        self.imageUrl = imageUrl
    }
    
    var body: some View{
        VStack{
            ZStack{
                UrlImageView(urlString: imageUrl)
                    .frame(width: 200, height: 200, alignment: .top)
                    .fixedSize()
                VStack {
                    HStack{
                        if (discount != 0){
                            Text("-\((1 - ((price - discount) / (price))) * 100, specifier: "%.0f")%")
                                .padding(.leading,7)
                                .padding(.top, 7)
                                .padding(.bottom, 3)
                                .padding(.trailing, 3)
                                .foregroundColor(.white)
                                .background(Color("Accent"))
                                .opacity(0.85)
                                .cornerRadius(5.0)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .font(.headline)
                        .lineLimit(2)
                        .frame(height: 45, alignment: .top)
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal)
                        .padding(.vertical)
                    Spacer()
                }
            }
            VStack(alignment:.leading){
                HStack{
                    ForEach(_stylists.wrappedValue, id: \.self){ stylist in
                        Text("\(stylist.name ?? "Unknown Stylist")")
                            .bold()
                    }
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("\((price -  discount), specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(Color("Accent"))
                    if (discount != 0){
                        Text("\(price, specifier: "%.2f")")
                            .strikethrough(true)
                    }
                }.padding(.bottom)
            }.padding(.horizontal)
        }
        .padding()
        .frame(width: 200, height: 340)
        .background(Color("Background"))
        .cornerRadius(12)
        .shadow(color: Color("DarkShadow"), radius: 3, x: 5, y: 5)
        .blendMode(.overlay)
    }
}

struct HorizontalWidePostCards: View{
    var title:String = "Sample title"
    var price: Double = 10.00
    var stylist:String = "Tammy How"
    var desc:String = "Description"
    var duration:String = "120"
    var imageUrl:String
    var discount: Double = 0.0
    var distance: Double = 0.0
    let urlPath = Bundle.main.url(forResource: "Beauty", withExtension: "png")!
    
    @FetchRequest var stylists: FetchedResults<CoreStylist>
    
    init(stylistId:String, title:String, price:Double, desc:String, duration:String, imageUrl:String, discount:Double, distance: Double){
        self._stylists = FetchRequest<CoreStylist>(
            entity: CoreStylist.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: true)],
            predicate: NSPredicate(format: "id == %@", stylistId))
        self.title = title
        self.price = price
        self.desc = desc
        self.duration = duration
        self.discount = discount
        self.imageUrl = imageUrl
    }
    
    var body: some View{
        VStack{
            ZStack{
                UrlImageView(urlString: imageUrl)
                    .frame(width: 300, height: 300, alignment: .top)
                    .fixedSize()
                VStack {
                    HStack{
                        if (discount != 0){
                            Text("-\((1 - ((price - discount) / (price))) * 100, specifier: "%.0f")%")
                                .padding(.leading,7)
                                .padding(.top, 7)
                                .padding(.bottom, 3)
                                .padding(.trailing, 3)
                                .foregroundColor(.white)
                                .background(Color("Accent"))
                                .opacity(0.85)
                                .cornerRadius(5.0)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .font(.headline)
                        .lineLimit(2)
                        .frame(height: 45, alignment: .top)
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal)
                        .padding(.top)
                    Spacer()
                }
            }
            VStack(alignment:.leading){
                HStack{
                    ForEach(_stylists.wrappedValue, id: \.self){ stylist in
                        Text("\(stylist.name ?? "Unknown Stylist")")
                            .bold()
                    }
                    Spacer()
                    Text("\((price -  discount), specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(Color("Accent"))
                    if (discount != 0){
                        Text("\(price, specifier: "%.2f")")
                            .strikethrough(true)
                    }
                }
            }.padding(.horizontal)
            .padding(.bottom)
        }
        //.padding()
        .frame(width: 300, height: 410)
        .background(Color("Background"))
        .cornerRadius(12)
        .shadow(color: Color("DarkShadow"), radius: 3, x: 5, y: 5)
        .blendMode(.overlay)
    }
}

struct PostCards: View{
    var imageName:String = ""
    var title:String = "Sample title"
    var price: Double = 10.00
    var desc:String = "Description"
    var duration:String = "120"
    var discount:Double = 0.0
    
    @FetchRequest var stylists: FetchedResults<CoreStylist>
    
    init(stylistId:String, imageName:String, title:String, price:Double, desc:String, duration:String, discount:Double){
        self._stylists = FetchRequest<CoreStylist>(
            entity: CoreStylist.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: false)],
            predicate: NSPredicate(format: "id == %@", stylistId))
        self.imageName = imageName
        self.title = title
        self.price = price
        self.desc = desc
        self.discount = discount
        self.duration = duration
    }
    
    var body: some View {
        VStack{
            HStack {
                ZStack{
                    UrlImageView(urlString: "\(imageName)")
                        .cornerRadius(12.0)
                    VStack {
                        HStack{
                            if (discount != 0){
                                Text("-\((1 - ((price - discount) / (price))) * 100, specifier: "%.0f")%")
                                    .padding(.leading,7)
                                    .padding(.top, 7)
                                    .padding(.bottom, 3)
                                    .padding(.trailing, 3)
                                    .foregroundColor(.white)
                                    .background(Color("Accent"))
                                    .opacity(0.85)
                                    .cornerRadius(5.0)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                }
                VStack(alignment: .leading, spacing: 15) {
                    Text(title)
                        .font(.headline)
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    ForEach(_stylists.wrappedValue, id: \.self){ stylist in
                        Text("\(stylist.name ?? "Unknown Stylist")")
                        HStack{
                            Spacer()
                            Text("\((price - discount), specifier: "%.2f")")
                                .font(.headline)
                                .foregroundColor(Color("Accent"))
                            if (discount != 0){
                                Text("\(price, specifier: "%.2f")")
                                    .strikethrough(true)
                            }
                        }
                    }
                }.padding(.horizontal)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.horizontal)
        .background(Color("Background"))
        .padding(.horizontal)
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
                    .frame(width: 130, height: 130)
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
            .padding(.top)
            .padding(.horizontal)
        }.buttonStyle(PlainButtonStyle())
    }
}


struct CompanyCard: View{
    var imageName:String = ""
    var companyId:String = "1"
    var companyName:String = "Tammy How"
    var desc:String = "KL"
    let urlPath = Bundle.main.url(forResource: "Beauty", withExtension: "png")!
    
    var body: some View{
        NavigationLink(destination: CompanyDetailView(companyId: companyId, title:companyName)){
            HStack{
                UrlImageView(urlString: imageName)
                    .clipShape(Circle())
                    .frame(width: 130, height: 130)
                    .overlay(Circle().stroke(Color("Accent")))
                    .padding()
                Spacer()
                VStack(alignment: .trailing){
                    HStack {
                        Spacer()
                        Text("\(companyName)")
                            .font(.headline)
                    }
                }.padding()
            }
            .background(Color("Background"))
            .cornerRadius(12)
            .padding(.top)
            .padding(.horizontal)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct HorizontalStylistCard: View{
    var image:String = ""
    var name:String = "Unknown"
    var location:String = "Unknown"
    var stylistId:String = "1"
    
    init(image:String, name:String, location:String, stylistId:String) {
        self.image = image
        self.name = name
        self.location = location
        self.stylistId = stylistId
    }
    
    var body: some View{
        NavigationLink(destination: StylistDetailView(stylistId: stylistId, title: name)){
            VStack{
                UrlImageView(urlString: image)
                    .frame(width: 200, height: 200, alignment: .top)
                    .fixedSize()
                Spacer()
                VStack{
                    HStack{
                        Text("\(name)")
                            .font(.headline)
                            .bold()
                        Spacer()
                    }
                    HStack{
                        Text("\(location)")
                            .font(.headline)
                            .foregroundColor(Color("Accent"))
                        Spacer()
                    }
                }.padding()
            }
            .padding()
            .frame(width: 200, height: 270)
            .background(Color("Background"))
            .cornerRadius(12)
            .shadow(color: Color("DarkShadow"), radius: 3, x: 5, y: 5)
            .blendMode(.overlay)
        }.buttonStyle(PlainButtonStyle())
    }
}
