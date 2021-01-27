//
//  CategoryView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 11/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct CategoryView: View {
    @FetchRequest var posts: FetchedResults<CorePost>
    var title:String
    var serviceTypeId:String
    let date = Date().timeIntervalSince1970
    @State var name = ""
    
    init(serviceTypeId:String, title:String) {
        self._posts = FetchRequest<CorePost>(
            entity: CorePost.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.postId, ascending: true)],
            predicate: NSPredicate(format: "serviceTypeId == %@", serviceTypeId))
        self.title = title
        self.serviceTypeId = serviceTypeId
    }
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack{
                SearchBar(text: self.$name)
                ScrollView{
                    LazyVStack{
                        ForEach(_posts.wrappedValue.filter(
                                    {name.isEmpty ? true : $0.serviceName!.localizedCaseInsensitiveContains(self.name)}), id: \.self){ post in
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
        }
        .navigationBarTitle("\(title)", displayMode: .inline)
    }
}


