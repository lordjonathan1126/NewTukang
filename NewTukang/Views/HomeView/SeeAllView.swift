//
//  SeeAllView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 30/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct MostPurchasedSeeAll: View {
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.stat_p, ascending: false)]
    ) var posts: FetchedResults<CorePost>
    let date = Date().timeIntervalSince1970
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                LazyVStack{
                    ForEach(_posts.wrappedValue, id: \.self){ post in
                        if(post.endDate > date){
                        NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                            PostCards(stylistId:"\(post.stylistId)", imageName: "\(post.img!)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", discount: post.discount)
                                .padding()
                        }.buttonStyle(PlainButtonStyle())
                        Divider()
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Top Sales", displayMode: .inline)
    }
}

struct MostPopularSeeAll: View {
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.stat_v, ascending: false)]
    ) var posts: FetchedResults<CorePost>
    let date = Date().timeIntervalSince1970
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                LazyVStack{
                    ForEach(_posts.wrappedValue, id: \.self){ post in
                        if(post.endDate > date){
                        NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                            PostCards(stylistId:"\(post.stylistId)", imageName: "\(post.img!)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", discount: post.discount)
                                .padding()
                        }.buttonStyle(PlainButtonStyle())
                        Divider()
                    }
                    }
                }
            }
        }
        .navigationBarTitle("Most Popular", displayMode: .inline)
    }
}

struct TopTrendingSeeAll: View {
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.trending, ascending: false)]
    ) var posts: FetchedResults<CorePost>
    let date = Date().timeIntervalSince1970
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                LazyVStack{
                    ForEach(_posts.wrappedValue, id: \.self){ post in
                        if(post.endDate > date){
                        NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                            PostCards(stylistId:"\(post.stylistId)", imageName: "\(post.img!)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", discount: post.discount)
                                .padding()
                        }.buttonStyle(PlainButtonStyle())
                        Divider()
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Top Trending", displayMode: .inline)
    }
}

struct NewPostSeeAll:View{
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.createDate, ascending: false)]
    ) var posts: FetchedResults<CorePost>
    let date = Date().timeIntervalSince1970
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                LazyVStack{
                    ForEach(_posts.wrappedValue, id: \.self){ post in
                        if(post.endDate > date){
                        NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                            PostCards(stylistId:"\(post.stylistId)", imageName: "\(post.img!)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", discount: post.discount)
                                .padding()
                        }.buttonStyle(PlainButtonStyle())
                        Divider()
                    }
                    }
                }
            }
        }
        .navigationBarTitle("New Post", displayMode: .inline)
    }
}

struct EndingSoonSeeAll:View{
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.endDate, ascending: true)]
    ) var posts: FetchedResults<CorePost>
    let date = Date().timeIntervalSince1970
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                LazyVStack{
                    ForEach(_posts.wrappedValue, id: \.self){ post in
                         if(post.endDate > date){
                        NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                            PostCards(stylistId:"\(post.stylistId)", imageName: "\(post.img!)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", discount: post.discount)
                                .padding()
                        }.buttonStyle(PlainButtonStyle())
                        Divider()
                        }
                        
                    }
                }
            }
        }
        .navigationBarTitle("Ending Soon", displayMode: .inline)
    }
}

struct LocationViewSeeAll: View{
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.distance, ascending: true)]
    ) var posts: FetchedResults<CorePost>
    let date = Date().timeIntervalSince1970
    
    var body: some View{
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                LazyVStack{
                    ForEach(_posts.wrappedValue, id: \.self){ post in
                        if(post.endDate > date){
                        VStack{
                            HStack{
                                Image(systemName: "location")
                                Text("\(post.distance/1000, specifier: "%.1f") km away")
                            }.foregroundColor(.secondary)
                            .padding(.top)
                            NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                                PostCards(stylistId:"\(post.stylistId)", imageName: "\(post.img!)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", discount: post.discount)
                                    .padding()
                            }.buttonStyle(PlainButtonStyle())
                            Divider()
                        }
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text("Nearby") , displayMode: .inline)
    }
}
