//
//  StylistDetailView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 17/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI
import URLImage

struct StylistDetailView: View {
    var posts: FetchRequest<CorePost>
    var stylistId:String
    var title:String
    
    init(stylistId:String, title:String) {
        posts = FetchRequest<CorePost>(
            entity: CorePost.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.postId, ascending: true)],
            predicate: NSPredicate(format: "stylistId == %@", stylistId))
        self.stylistId = stylistId
        self.title = title
    }
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            if #available(iOS 14.0, *) {
                ScrollView{
                    LazyVStack {
                        AboutStylist(stylistId: stylistId)
                        LazyVStack{
                            ForEach(posts.wrappedValue, id: \.self){ post in
                                NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)")){
                                    PostCards(stylistId:"\(post.stylistId)", imageName: "\(post.img!)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)")
                                        .padding()
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    
                }
            } else {
                // Fallback on earlier versions
                ScrollView{
                    VStack {
                        AboutStylist(stylistId: stylistId)
                        VStack{
                            ForEach(posts.wrappedValue, id: \.self){ post in
                                NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)")){
                                    PostCards(stylistId:"\(post.stylistId)", imageName: "\(post.img!)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)")
                                        .padding()
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
            }
        }.navigationBarTitle("\(title)", displayMode: .inline)
    }
}

struct StylistDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StylistDetailView(stylistId: "1", title: "Unknown Stylist")
    }
}

