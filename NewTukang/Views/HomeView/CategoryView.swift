//
//  CategoryView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 11/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI
import URLImage

struct CategoryView: View {
    var posts: FetchRequest<CorePost>
    var title:String
    
    init(serviceTypeId:String, title:String) {
        posts = FetchRequest<CorePost>(
            entity: CorePost.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.postId, ascending: true)],
            predicate: NSPredicate(format: "serviceTypeId == %@", serviceTypeId))
        self.title = title
    }
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                if #available(iOS 14.0, *) {
                    VStack{
                        ForEach(posts.wrappedValue, id: \.self){ post in
                            NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)")){
                                PostCards(stylistId:"\(post.stylistId)", imageName: "\(post.img!)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)")
                                    .padding()
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }else{
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
        .navigationBarTitle("\(title)", displayMode: .inline)
    }
}



struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(serviceTypeId: "1", title: "Unknown Title")
    }
}

struct PostCards: View{
    var imageName:String = "stock-1"
    var title:String = "Sample title"
    var price: Double = 10.00
    var desc:String = "Description"
    var duration:String = "120"
    
    var stylists: FetchRequest<CoreStylist>
    init(stylistId:String, imageName:String, title:String, price:Double, desc:String, duration:String){
        stylists = FetchRequest<CoreStylist>(
            entity: CoreStylist.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: true)],
            predicate: NSPredicate(format: "id == %@", stylistId))
        self.imageName = imageName
        self.title = title
        self.price = price
        self.desc = desc
        self.duration = duration
    }
    var body: some View {
        VStack{
            URLImage(URL(string: imageName)!, placeholder: {_ in
                Image("Beauty")
                    .resizable()
                    .frame(width: 100.0, height: 100.0)
            }){proxy in
                proxy.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(10)
            }
            
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .font(.headline)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal)
                        .padding(.vertical)
                    Spacer()
                }
            }
            VStack(alignment:.leading){
                Text("\(desc)")
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.body)
                    .foregroundColor(.secondary)
                Text("\(duration) min")
                    .font(.body)
                    .foregroundColor(.secondary)
                HStack{
                    ForEach(stylists.wrappedValue, id: \.self){ stylist in
                        Text("By:\(stylist.name ?? "Unknown Stylist")")
                        .font(.body)
                        .foregroundColor(.secondary)
                    }
                    Spacer()
                    Text("\(price, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(Color("Accent"))
                }
            }.padding(.horizontal)
            .padding(.bottom)
        }
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.horizontal)
        .background(Color("Background"))
        .cornerRadius(12)
        .shadow(color: Color("LightShadow"), radius: 10, x: -8, y: -8)
        .shadow(color: Color("DarkShadow"), radius: 10, x: 8, y: 8)
        .blendMode(.overlay)
        .padding(.horizontal)
    }
}
