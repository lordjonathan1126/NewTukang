//
//  StylistDetailView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 17/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

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
                ScrollView{
                    LazyVStack {
                        AboutStylist2(stylistId: stylistId)
                        LazyVStack{
                            HStack {
                                Text("Posts")
                                    .font(.title)
                                    .bold()
                                    .padding(.leading)
                                Spacer()
                            }
                            ForEach(posts.wrappedValue, id: \.self){ post in
                                NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                                    PostCards(stylistId:"\(post.stylistId)", imageName: "\(post.img!)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", discount: post.discount)
                                        .padding()
                                }.buttonStyle(PlainButtonStyle())
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

struct AboutStylist2: View{
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
            LazyVStack {
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
                if(stylist.imgs != nil){
                    ScrollView(.horizontal){
                            LazyHStack(){
                                ForEach(stylist.imgs!, id:\.self){ img in
                                    UrlImageView(urlString: img)
                                        .fixedSize()
                                        .frame(width: 230, height: 230)
                                        .cornerRadius(10.0)
                                        .padding(.vertical)
                                        .padding(.leading, 10)
                                }
                            }
                        }
                }
            }
        }
    }
}
