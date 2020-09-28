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
    var stylistId:String
    var title:String
    var serviceTypeId:String
    let urlPath = Bundle.main.url(forResource: "Beauty", withExtension: "png")!
    
    init(stylistId:String, postId:String, title:String, serviceTypeId:String) {
        posts = FetchRequest<CorePost>(
            entity: CorePost.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.postId, ascending: true)],
            predicate: NSPredicate(format: "postId == %@", postId))
        self.serviceTypeId = serviceTypeId
        self.stylistId = stylistId
        self.title = title
        
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
                            //HorizontalImageScrollView()
                            AboutStylist(stylistId: stylistId)
                            MoreByStylistView(stylistId: stylistId)
                            SimilarView(serviceTypeId: serviceTypeId)
                        }
                    }
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

struct HorizontalImageScrollView: View {
    var body: some View {
        VStack(alignment:.leading) {
            Text("Previous work on this style")
                .font(.title)
                .foregroundColor(Color("Accent"))
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: true){
                HStack {
                    Image("persona1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .cornerRadius(20)
                    
                    Image("barber1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .cornerRadius(20)
                    
                    Image("barber2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .cornerRadius(20)
                    Image("nails")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .cornerRadius(20)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
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
    
    var body: some View{
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

struct MoreByStylistView: View {
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
                    Text("More by Stylist")
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

