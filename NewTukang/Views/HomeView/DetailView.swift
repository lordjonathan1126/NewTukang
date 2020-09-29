//
//  DetailView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 11/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var posts: FetchRequest<CorePost>
    var stylists: FetchRequest<CoreStylist>
    var stylistId:String
    var title:String
    var serviceTypeId:String
    var postId:String
    let urlPath = Bundle.main.url(forResource: "Beauty", withExtension: "png")!
    
    init(stylistId:String, postId:String, title:String, serviceTypeId:String) {
        posts = FetchRequest<CorePost>(
            entity: CorePost.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.postId, ascending: true)],
            predicate: NSPredicate(format: "postId == %@", postId))
        stylists = FetchRequest<CoreStylist>(
            entity: CoreStylist.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: true)],
            predicate: NSPredicate(format: "id == %@", stylistId))
        self.serviceTypeId = serviceTypeId
        self.stylistId = stylistId
        self.title = title
        self.postId = postId
    }
    var body: some View {
        ForEach(posts.wrappedValue, id: \.self){ post in
            ZStack{
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ScrollView{
                        LazyVStack(alignment: .leading, spacing: 12){
                            UrlImageView(urlString: "\(post.img!)")
                            HStack {
                                Text("What you will get")
                                    .font(.title)
                                    .foregroundColor(Color("Accent"))
                                    .padding(.horizontal)
                                Spacer()
                                Text("\(post.serviceDuration) mins")
                                    .foregroundColor(.secondary)
                                    .padding(.trailing)
                            }
                            Text("\(post.desc!)")
                                .font(.body)
                                .lineLimit(nil)
                                .padding(.horizontal)
                            VStack {
                                HStack {
                                    Text("Stylist")
                                        .font(.title)
                                        .bold()
                                        .padding(.leading)
                                    Spacer()
                                }
                                AboutStylist(stylistId: stylistId)
                            }
                            PostsByStylistView(stylistId: stylistId)
                            VStack {
                                HStack {
                                    Text("Company")
                                        .font(.title)
                                        .bold()
                                        .padding(.leading)
                                    Spacer()
                                }
                                ForEach(stylists.wrappedValue, id: \.self){stylist in
                                    AboutCompany(companyId: "\(stylist.companyId)")
                                    
                                }
                            }
                            ForEach(stylists.wrappedValue, id: \.self){stylist in
                            MeetTheTeam(companyId: "\(stylist.companyId)")
                            }
                            SimilarView(serviceTypeId: serviceTypeId)
                        }
                    }
                    Spacer()
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(title)")
                            HStack {
                                Text("\((post.normalPrice -  post.discount), specifier: "%.2f")")
                                    .font(.title)
                                    .foregroundColor(Color("Accent"))
                                if (post.discount != 0){
                                    Text("\(post.normalPrice, specifier: "%.2f")")
                                        .strikethrough(true)
                                }
                            }
                        }
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            Text("Book")
                                .foregroundColor(.white)
                                .padding()
                        }.background(Color("Accent"))
                        .cornerRadius(10)
                        .padding(.vertical)
                        .shadow(color: Color("DarkShadow"), radius: 3, x: 3, y: 3)
                    }.padding(.horizontal)
                    .background(Color("LightShadow"))
                }.edgesIgnoringSafeArea(.bottom)
            }
        }
        .navigationBarTitle("\(title)", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(stylistId: "1", postId: "1", title: "default", serviceTypeId: "1")
    }
}

struct AboutStylist: View{
    var stylists: FetchRequest<CoreStylist>
    var stylistId:String = "1"
    let urlPath = Bundle.main.url(forResource: "Beauty", withExtension: "png")!
    
    init(stylistId:String){
        stylists = FetchRequest<CoreStylist>(
            entity: CoreStylist.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: true)],
            predicate: NSPredicate(format: "id == %@", stylistId))
        self.stylistId = stylistId
    }
    
    var body: some View{
        ForEach(stylists.wrappedValue, id: \.self){stylist in
            NavigationLink(destination: StylistDetailView(stylistId: stylistId, title: stylist.name!)){
                VStack {
                    HStack{
                        UrlImageView(urlString: "\(stylist.img!)")
                            .clipShape(Circle())
                            .frame(width: 70, height: 70)
                            .overlay(Circle().stroke(Color("Accent")))
                            .clipped()
                            .padding()
                        Spacer()
                        VStack(alignment: .trailing){
                            Text("\(stylist.name!)")
                                .font(.title)
                                .bold()
                            Text("\(stylist.location!)")
                                .foregroundColor(Color("Accent"))
                        }.padding()
                    }
                    Text("\(stylist.desc ?? "No description available.")")
                        .lineLimit(nil)
                        .padding(.horizontal)
                }
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

struct PostsByStylistView: View {
    var posts: FetchRequest<CorePost>
    var stylistId: String
    
    init(stylistId:String) {
        posts = FetchRequest<CorePost>(
            entity: CorePost.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.postId, ascending: true)],
            predicate: NSPredicate(format: "stylistId == %@", stylistId))
        self.stylistId = stylistId
    }
    
    var body: some View{
        if #available(iOS 14.0, *) {
            VStack(alignment:.leading){
                VStack(alignment: .leading) {
                    Text("Posts by Stylist")
                        .font(.title)
                        .fontWeight(.bold)
                }.padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 20){
                        ForEach (posts.wrappedValue, id: \.self){ post in
                            NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                                TrendingCards(stylistId: "\(post.stylistId)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", imageUrl: "\(post.img!)", discount: post.discount)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }.frame(height: 345, alignment: .center)
                    .padding()
                }
            }
            .padding(.top)
        }
    }
}

struct AboutCompany :View {
    var companies: FetchRequest<CoreCompany>
    var companyId:String = "1"
    let urlPath = Bundle.main.url(forResource: "Beauty", withExtension: "png")!
    
    init(companyId:String){
        companies = FetchRequest<CoreCompany>(
            entity: CoreCompany.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreCompany.id, ascending: false)],
            predicate: NSPredicate(format: "id == %@", companyId))
        self.companyId = companyId
    }
    var body: some View{
        LazyVStack {
            ForEach(companies.wrappedValue, id: \.self){ company in
                NavigationLink(destination: CompanyDetailView(companyId: companyId, title: company.name!)){
                    VStack {
                        HStack{
                            UrlImageView(urlString: "\(company.img!)")
                                .clipShape(Circle())
                                .frame(width: 70, height: 70)
                                .overlay(Circle().stroke(Color("Accent")))
                                .clipped()
                                .padding()
                            Spacer()
                            VStack(alignment: .trailing){
                                Text("\(company.name!)")
                                    .font(.headline)
                                    .bold()
                                    .lineLimit(2)
                            }.padding(.trailing)
                        }
                        Text("\(company.desc ?? "No description available.")")
                            .lineLimit(nil)
                            .padding(.horizontal)
                    }.padding()
                }.buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct MeetTheTeam:View {
    var companyId:String = "1"
    var stylists: FetchRequest<CoreStylist>
    
    init(companyId:String){
        stylists = FetchRequest<CoreStylist>(
            entity: CoreStylist.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: true)],
            predicate: NSPredicate(format: "companyId == %@", companyId))
        self.companyId = companyId
    }
    var body: some View{
        VStack {
            HStack {
                Text("Meet The Team")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                    .padding(.leading)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(spacing:20){
                ForEach(stylists.wrappedValue, id: \.self){ stylist in
                    HorizontalStylistCard(image: "\(stylist.img!)", name:"\(stylist.name!)", location: "\(stylist.location!)", stylistId: "\(stylist.id)")
                }
            }.padding()
            }
        }
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
                    HStack {
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

struct SimilarView: View {
    var posts: FetchRequest<CorePost>
    var serviceTypeId: String
    
    init(serviceTypeId:String) {
        posts = FetchRequest<CorePost>(
            entity: CorePost.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.postId, ascending: true)],
            predicate: NSPredicate(format: "serviceTypeId == %@", serviceTypeId))
        self.serviceTypeId = serviceTypeId
    }
    
    var body: some View {
        if #available(iOS 14.0, *) {
            VStack(alignment:.leading){
                VStack(alignment: .leading) {
                    Text("Similar Posts")
                        .font(.title)
                        .fontWeight(.bold)
                }.padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 20){
                        ForEach (posts.wrappedValue, id: \.self){ post in
                                NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(serviceTypeId)")){
                                    TrendingCards(stylistId: "\(post.stylistId)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", imageUrl: "\(post.img!)", discount: post.discount)
                                }.buttonStyle(PlainButtonStyle())
                        }
                    }.frame(height: 345, alignment: .center)
                    .padding()
                }
            }
            .padding(.top)
        }
    }
}



