//
//  HomeVIew.swift
//  NewTukang
//
//  Created by Jonathan Ng on 21/08/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{
            ZStack{
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    //TitleBar()
                    ScrollView{
                        if #available(iOS 14.0, *) {
                            LazyVStack{
                                //SearchBar()
                                OurServiceView()
                                TrendingView(title: "Top Trending")
                                TrendingView(title: "Most Popular")
                                //SpecialistView()
                                StylistCompanyListView()
                                    .padding(.top)
                                Spacer()
                            }
                        }else{
                            VStack{
                                //SearchBar()
                                OurServiceView()
                                TrendingView(title: "Top Trending")
                                TrendingView(title: "Most Popular")
                                //SpecialistView()
                                StylistCompanyListView()
                                    .padding(.top)
                                Spacer()
                            }
                        }
                        
                    }
                }
            }
            //.navigationBarHidden(true)
            .navigationBarTitle("Tukang")
            //.edgesIgnoringSafeArea([.top])
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct TitleBar: View {
    var body: some View {
        HStack {
            Text("TUKANG")
                .font(.largeTitle)
                .bold()
            Spacer()
            //   Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
            //      Image(systemName: "bell")
            //         .foregroundColor(Color("Accent"))
            //          .padding()
            //          .background(
            //              Circle()
            //                 .fill(Color("Background"))
            //                 .shadow(color: Color("LightShadow"), radius: 10, x: -7, y: -7)
            //               .shadow(color: Color("DarkShadow"), radius: 10, x: 10, y: 10)
            //  )
            //}
        }
        .padding(.horizontal)
        .padding(.top, 50)
    }
}

struct OurServiceView: View{
    var body: some View{
        if #available(iOS 14.0, *) {
            LazyVStack(alignment:.leading){
                Text("Our Services")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 18){
                        NavigationLink(destination: CategoryView( serviceTypeId:"1", title: "Hair")){
                            CategoryButton(title: "Hair", imageName: "Hair")
                        }.buttonStyle(PlainButtonStyle())
                        NavigationLink(destination: CategoryView( serviceTypeId:"2", title: "Nail")){
                            CategoryButton(title: "Nail", imageName: "Nail")
                        }.buttonStyle(PlainButtonStyle())
                        NavigationLink(destination: CategoryView( serviceTypeId:"4", title: "Massage")){
                            CategoryButton(title: "Massage", imageName: "Spa")
                        }.buttonStyle(PlainButtonStyle())
                        NavigationLink(destination: CategoryView( serviceTypeId:"3", title: "Spa")){
                            CategoryButton(title: "Spa", imageName: "Lash")
                        }.buttonStyle(PlainButtonStyle())
                    }.padding()
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
        } else{
            VStack(alignment:.leading){
                Text("Our Services")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 18){
                        NavigationLink(destination: CategoryView( serviceTypeId:"1", title: "Hair")){
                            CategoryButton(title: "Hair", imageName: "Hair")
                        }.buttonStyle(PlainButtonStyle())
                        NavigationLink(destination: CategoryView( serviceTypeId:"2", title: "Nail")){
                            CategoryButton(title: "Nail", imageName: "Nail")
                        }.buttonStyle(PlainButtonStyle())
                        NavigationLink(destination: CategoryView( serviceTypeId:"4", title: "Massage")){
                            CategoryButton(title: "Massage", imageName: "Spa")
                        }.buttonStyle(PlainButtonStyle())
                        NavigationLink(destination: CategoryView( serviceTypeId:"3", title: "Spa")){
                            CategoryButton(title: "Spa", imageName: "Lash")
                        }.buttonStyle(PlainButtonStyle())
                        
                    }.padding()
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
        }
        
    }
}

struct CategoryButton: View {
    var title: String = "Category"
    var imageName: String = "Beauty"
    var body: some View{
        VStack {
            ZStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                VStack (alignment:.trailing){
                    Spacer()
                    HStack(alignment:.bottom) {
                        Spacer()
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.bottom, 5)
                            .padding(.trailing, 5)
                    }
                }
                
            }.frame(width:100, height: 100, alignment:.center)
            .cornerRadius(10)
            .shadow(color: Color("LightShadow"), radius: 5, x: -3, y: -3)
            .shadow(color: Color("DarkShadow"), radius: 5, x: 5, y: 5)
            .blendMode(.overlay)
        }
    }
    
}

struct SearchBar: View{
    @Environment(\.colorScheme) var colorScheme
    @State private var show_search: Bool = false
    
    var body: some View{
        Button(action: {
            self.show_search = true
        }) {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(height:35)
                    .foregroundColor(Color("Background"))
                    .padding()
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("Accent"))
                    Text("Search")
                        .foregroundColor(Color("Accent"))
                }
            }
            .shadow(color: Color("LightShadow"), radius: 10, x: -5, y: -5)
            .shadow(color: Color("DarkShadow"), radius: 10, x: 8, y: 8)
            .blendMode(.overlay)
        }.sheet(isPresented: self.$show_search){
            SearchView()
        }
    }
}

struct TrendingView: View {
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.postId, ascending: true)]
    ) var posts: FetchedResults<CorePost>
    var title:String = "Top Trending"
    
    var body: some View{
        if #available(iOS 14.0, *) {
            VStack(alignment:.leading){
                VStack(alignment: .leading) {
                    Text("\(title)")
                        .font(.title)
                        .fontWeight(.bold)
                }.padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 20){
                        ForEach (posts, id: \.self){ post in
                            NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)")){
                                TrendingCards(stylistId: "\(post.stylistId)", imageName: "stock-1", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", imageUrl: "\(post.img!)")
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }.frame(height: 305, alignment: .center)
                    .padding()
                }
            }
            .padding(.top)
        }else{
            VStack(alignment:.leading){
                VStack(alignment: .leading) {
                    Text("Top Trending")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Top recommended services.")
                        .font(.body)
                        .foregroundColor(.gray)
                }.padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 20){
                        ForEach (posts, id: \.self){ post in
                            NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)")){
                                TrendingCards(stylistId:"\(post.stylistId)", imageName: "stock-1", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", imageUrl: "\(post.img!)")
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }.frame(height: 325, alignment: .center)
                    .padding()
                }
            }
            .padding(.top)
        }
    }
}

struct TrendingCards: View{
    var imageName:String = "stock-1"
    var title:String = "Sample title"
    var price: Double = 10.00
    var stylist:String = "Tammy How"
    var desc:String = "Description"
    var duration:String = "120"
    var imageUrl:String
    let urlPath = Bundle.main.url(forResource: "Beauty", withExtension: "png")!
    
    var stylists: FetchRequest<CoreStylist>
    
    init(stylistId:String, imageName:String, title:String, price:Double, desc:String, duration:String, imageUrl:String){
        stylists = FetchRequest<CoreStylist>(
            entity: CoreStylist.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: true)],
            predicate: NSPredicate(format: "id == %@", stylistId))
        self.imageName = imageName
        self.title = title
        self.price = price
        self.desc = desc
        self.duration = duration
        
        self.imageUrl = imageUrl
    }
    
    var body: some View{
        VStack{
           UrlImageView(urlString: imageUrl)
            .clipped()
            .frame(width: 240)
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
                //Text("\(desc)")
                //   .lineLimit(2)
                //  .fixedSize(horizontal: false, vertical: true)
                //  .font(.body)
                //  .foregroundColor(.secondary)
                Text("\(duration) min")
                    .font(.body)
                    .foregroundColor(.secondary)
                HStack{
                    ForEach(stylists.wrappedValue, id: \.self){ stylist in
                        Text("By: \(stylist.name ?? "Unknown Stylist")")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Text("\(price, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(Color("Accent"))
                }.padding(.bottom)
            }.padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .frame(width: 240, height: 320)
        .background(Color("Background"))
        .cornerRadius(12)
        .shadow(color: Color("LightShadow"), radius: 10, x: -8, y: -8)
        .shadow(color: Color("DarkShadow"), radius: 10, x: 8, y: 8)
        .blendMode(.overlay)
    }
}




struct SpecialistView: View{
    @FetchRequest(
        entity: CoreStylist.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: true)]
    ) var stylists: FetchedResults<CoreStylist>
    
    var body: some View{
        if #available(iOS 14.0, *) {
            LazyVStack(alignment: .leading){
                Text("Top Specialist")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 20){
                        ForEach(stylists, id: \.self){ stylist in
                            NavigationLink(destination: StylistDetailView(stylistId: "\(stylist.id)",title: "\(stylist.name!)")){
                                SpecialistCards(imageName: "stock-2", name: "\(stylist.name!)", location: "\(stylist.location!)", mobile: "\(stylist.mobile!)")
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }.frame(height: 245, alignment: .center)
                    .padding()
                }
            }
            .padding(.top)
        }else{
            VStack(alignment: .leading){
                Text("Top Specialist")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 20){
                        ForEach(stylists, id: \.self){ stylist in
                            NavigationLink(destination: StylistDetailView(stylistId: "\(stylist.id)", title: "\(stylist.name!)")){
                                SpecialistCards(imageName: "stock-2", name: "\(stylist.name!)", location: "\(stylist.location!)", mobile: "\(stylist.mobile!)")
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }.frame(height: 225, alignment: .center)
                    .padding()
                }
            }
            .padding(.top)
        }
    }
}

struct SpecialistCards: View{
    var imageName:String = "stock-2"
    var name:String = "Tammy How"
    var location: String = "KL"
    var mobile:String = "0123456"
    
    var body: some View{
        
        VStack{
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 130, alignment: .top)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    Text(name)
                        .font(.headline)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal)
                        .padding(.vertical)
                    Spacer()
                }
            }
            HStack(alignment: .bottom) {
                VStack(alignment:.leading){
                    Text(location)
                        .foregroundColor(Color("Accent"))
                }.padding(.leading)
                Spacer()
            }.padding(.bottom)
        }
        .padding()
        .frame(width: 170, height: 220)
        .background(Color("Background"))
        .cornerRadius(12)
        .shadow(color: Color("LightShadow"), radius: 10, x: -8, y: -8)
        .shadow(color: Color("DarkShadow"), radius: 10, x: 8, y: 8)
        .blendMode(.overlay)
        
    }
}

struct StylistCompanyListView: View{
    var body: some View{
        VStack(spacing: 14){
            NavigationLink(destination: StylistView()){
                HStack{
                    Text("Stylists")
                        .font(.headline)
                        .foregroundColor(Color("Accent"))
                        .padding()
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.headline)
                        .foregroundColor(Color("Accent"))
                        .padding()
                }.background(Color("Background"))
                .cornerRadius(12)
                .padding(.horizontal)
                .shadow(color: Color("LightShadow"), radius: 5, x: -5, y: -5)
                .shadow(color: Color("DarkShadow"), radius: 5, x: 5, y: 5)
                .blendMode(.overlay)
            }
            
            NavigationLink(destination: CompaniesView()){
                HStack{
                    Text("Companies")
                        .font(.headline)
                        .foregroundColor(Color("Accent"))
                        .padding()
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.headline)
                        .foregroundColor(Color("Accent"))
                        .padding()
                }.background(Color("Background"))
                .cornerRadius(12)
                .padding(.horizontal)
                .shadow(color: Color("LightShadow"), radius: 5, x: -5, y: -5)
                .shadow(color: Color("DarkShadow"), radius: 5, x: 5, y: 5)
                .blendMode(.overlay)
                
            }
        }
    }
}
