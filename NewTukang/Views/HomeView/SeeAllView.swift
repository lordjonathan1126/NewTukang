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
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                LazyVStack{
                    ForEach(_posts.wrappedValue, id: \.self){ post in
                        NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                            PostCards(stylistId:"\(post.stylistId)", imageName: "\(post.img!)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", discount: post.discount)
                                .padding()
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                
            }
        }
        .navigationBarTitle("Most Purchased", displayMode: .inline)
    }
}

struct MostPopularSeeAll: View {
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.stat_v, ascending: false)]
    ) var posts: FetchedResults<CorePost>
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                LazyVStack{
                    ForEach(_posts.wrappedValue, id: \.self){ post in
                        NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                            PostCards(stylistId:"\(post.stylistId)", imageName: "\(post.img!)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", discount: post.discount)
                                .padding()
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .navigationBarTitle("Most Popular", displayMode: .inline)
    }
}

struct NewPostSeeAll:View{
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.createDate, ascending: true)]
    ) var posts: FetchedResults<CorePost>
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                LazyVStack{
                    ForEach(_posts.wrappedValue, id: \.self){ post in
                        NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                            PostCards(stylistId:"\(post.stylistId)", imageName: "\(post.img!)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", discount: post.discount)
                                .padding()
                        }.buttonStyle(PlainButtonStyle())
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
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                LazyVStack{
                    ForEach(_posts.wrappedValue, id: \.self){ post in
                        NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                            PostCards(stylistId:"\(post.stylistId)", imageName: "\(post.img!)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", discount: post.discount)
                                .padding()
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .navigationBarTitle("Ending Soon", displayMode: .inline)
        
    }
}
