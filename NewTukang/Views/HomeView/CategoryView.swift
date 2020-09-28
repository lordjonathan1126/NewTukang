//
//  CategoryView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 11/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct CategoryView: View {
    var posts: FetchRequest<CorePost>
    var title:String
    var serviceTypeId:String
    
    init(serviceTypeId:String, title:String) {
        posts = FetchRequest<CorePost>(
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
            ScrollView{
                if #available(iOS 14.0, *) {
                    LazyVStack{
                        ForEach(posts.wrappedValue, id: \.self){ post in
                            NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                                PostCards(stylistId:"\(post.stylistId)", imageName: "\(post.img!)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", discount: post.discount)
                                    .padding()
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }else{
                    VStack{
                        ForEach(posts.wrappedValue, id: \.self){ post in
                            NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                                PostCards(stylistId:"\(post.stylistId)", imageName: "\(post.img!)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", discount: post.discount)
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
    var discount:Double = 0.0
    let urlPath = Bundle.main.url(forResource: "Beauty", withExtension: "png")!
    
    var stylists: FetchRequest<CoreStylist>
    init(stylistId:String, imageName:String, title:String, price:Double, desc:String, duration:String, discount:Double){
        stylists = FetchRequest<CoreStylist>(
            entity: CoreStylist.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: true)],
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
            UrlImageView(urlString: "\(imageName)")
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
                    Text("\(duration) min")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.trailing)
                }
            }
            VStack(alignment:.leading){
                Text("\(desc)")
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.body)
                    .foregroundColor(.secondary)
                ForEach(stylists.wrappedValue, id: \.self){ stylist in
                    Text("\(stylist.name ?? "Unknown Stylist")")
                        .bold()
                }
                
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
            }.padding(.horizontal)
            .padding(.bottom)
        }
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.horizontal)
        .background(Color("Background"))
        .cornerRadius(12)
        .shadow(color: Color("LightShadow"), radius: 7, x: -8, y: -8)
        .shadow(color: Color("DarkShadow"), radius: 5, x: 7, y: 7)
        .blendMode(.overlay)
        .padding(.horizontal)
    }
}
