//
//  DetailView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 11/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI
import URLImage

struct DetailView: View {
    var posts: FetchRequest<CorePost>
    var stylistId:String
    var title:String
    let urlPath = Bundle.main.url(forResource: "Beauty", withExtension: "png")!
    
    init(stylistId:String, postId:String, title:String) {
        posts = FetchRequest<CorePost>(
            entity: CorePost.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.postId, ascending: true)],
            predicate: NSPredicate(format: "postId == %@", postId))
        
        self.stylistId = stylistId
        self.title = title
    }
    var body: some View {
        ForEach(posts.wrappedValue, id: \.self){ post in
            VStack {
                ScrollView{
                    VStack(alignment: .leading, spacing: 12){
                        
                        URLImage(URL(string: post.img!) ?? urlPath, placeholder: {_ in
                            Image("Beauty")
                                .resizable()
                                .frame(width: 100.0, height: 100.0)
                        }){proxy in
                            proxy.image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        Text("What you will get")
                            .font(.title)
                            .foregroundColor(Color("Accent"))
                            .padding(.horizontal)
                        Text("\(post.desc!)")
                            .font(.body)
                            .lineLimit(nil)
                            .padding(.horizontal)
                        RecommendedFor()
                        HorizontalImageScrollView()
                        AboutStylist(stylistId: stylistId)
                    }
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(title)")
                        Text("\(post.normalPrice, specifier: "%.2f")")
                            .font(.title)
                            .foregroundColor(Color("Accent"))
                    }
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Text("Book")
                            .foregroundColor(.white)
                            .padding()
                    }.background(Color("Accent"))
                        .cornerRadius(10)
                        .padding(.vertical)
                }.padding(.horizontal)
                .background(BlurView(style: .systemMaterial))
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
       
        .navigationBarTitle("\(title)", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(stylistId: "1", postId: "1", title: "default")
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
            HStack{
                VStack(alignment: .leading){
                    Text("\(stylist.name!)")
                        .font(.title)
                        .bold()
                    Text("\(stylist.desc ?? "No description available.")")
                    .lineLimit(nil)
                }.padding(.trailing)
                Spacer()
                
                URLImage(URL(string: stylist.img!) ?? urlPath , placeholder: {_ in
                    Image("Beauty")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 70, height: 70)
                        .overlay(Circle().stroke(Color("Accent")))
                        .padding()
                }){proxy in
                    proxy.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 70, height: 70)
                        .overlay(Circle().stroke(Color("Accent")))
                        .padding()
                }
                    
            }.padding(.horizontal)
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



struct RecommendedFor: View {
    var body: some View {
        VStack(alignment:.leading) {
            Text("Recommended for")
                .padding(.horizontal)
                .font(.title)
                .foregroundColor(Color("Accent"))
            Text("∙ Male")
                .padding(.horizontal)
            Text("∙ Short Hair")
                .padding(.horizontal)
            Text("∙ Easy maintenance and style up")
                .padding(.horizontal)
            Text("∙ Retouch in 3-4 weeks")
                .padding(.horizontal)
            Text("∙ Suitable for all face types")
                .padding(.horizontal)
        }
        
    }
}
