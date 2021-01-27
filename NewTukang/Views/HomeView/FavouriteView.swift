//
//  FavouriteView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 04/11/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct FavouriteView : View{
    @FetchRequest var posts: FetchedResults<CorePost>
    
    init(){
        self._posts = FetchRequest<CorePost>(
            entity: CorePost.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.serviceName, ascending: true)],
            predicate: NSPredicate(format: "fav == %@", NSNumber(booleanLiteral: true)))
    }
    
    var body : some View{
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            if(_posts.wrappedValue.count == 0){
                VStack{
                    Text("No favorited items yet.")
                        .foregroundColor(.secondary)
                }
            }else{
                ScrollView{
                    LazyVStack{
                        ForEach(_posts.wrappedValue, id: \.self){ post in
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
        .navigationBarTitle("Favorite", displayMode: .inline)
    }
}
