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
            ZStack{
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack{
                        OurServiceView()
                        LocationView(title: "Nearby")
                        MostPopular(title: "Most Popular")
                        MostPurchased(title: "Top Sales")
                        TopTrending(title: "Top Trending")
                        NewPost(title: "New Posts")
                        EndingSoon(title: "Ending Soon")
                        StylistCompanyListView()
                        Spacer()
                    }
                }
                .padding(.bottom)
            }
    }
}

struct OurServiceView: View{
    var body: some View{
        VStack(alignment:.leading){
            Text("Our Services")
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 17){
                    NavigationLink(destination: CategoryView( serviceTypeId:"1", title: "Hair")){
                        CategoryButton(title: "Hair", imageName: "Hair")
                    }.buttonStyle(PlainButtonStyle())
                    NavigationLink(destination: CategoryView( serviceTypeId:"2", title: "Nail")){
                        CategoryButton(title: "Nail", imageName: "Nail")
                    }.buttonStyle(PlainButtonStyle())
                    NavigationLink(destination: CategoryView( serviceTypeId:"4", title: "Beauty")){
                        CategoryButton(title: "Beauty", imageName: "Spa")
                    }.buttonStyle(PlainButtonStyle())
                    NavigationLink(destination: CategoryView( serviceTypeId:"3", title: "Spa")){
                        CategoryButton(title: "Lash", imageName: "Lash")
                    }.buttonStyle(PlainButtonStyle())
                }.padding()
            }
        }.frame(minWidth: 0, maxWidth: .infinity)
        
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
        }.sheet(isPresented: self.$show_search){
            SearchView()
        }
    }
}

struct MostPurchased: View {
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.stat_p, ascending: false)]
    ) var posts: FetchedResults<CorePost>
    var title:String = "Most Purchased"
    
    var body: some View{
        VStack(alignment:.leading){
            VStack(alignment: .leading){
                HStack{
                    Text("\(title)")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    NavigationLink(destination: MostPurchasedSeeAll()){
                        Text("See All")
                    }
                }
            }.padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(spacing: 12){
                    ForEach (posts, id: \.self){ post in
                        NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                            HorizontalPostCards(stylistId: "\(post.stylistId)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", imageUrl: "\(post.img!)", discount: post.discount)
                        }.buttonStyle(PlainButtonStyle())
                    }.id(UUID())
                }.frame(height: 345, alignment: .center)
                .padding()
            }
        }
        .padding(.top)
    }
}


struct LocationView: View {
    @ObservedObject var locationManager = LocationManager()
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.distance, ascending: true)]
    ) var posts: FetchedResults<CorePost>
    var title:String = "Most Purchased"
    
    var body: some View{
        if (locationManager.statusString == "authorizedWhenInUse"){
            VStack(alignment:.leading){
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "location.fill")
                        Text("\(title)")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        NavigationLink(destination: LocationViewSeeAll()){
                            Text("See All")
                        }
                    }
                }.padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 12){
                        ForEach (posts, id: \.self){ post in
                            NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                                HorizontalPostCards(stylistId: "\(post.stylistId)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", imageUrl: "\(post.img!)", discount: post.discount)
                            }.buttonStyle(PlainButtonStyle())
                        }.id(UUID())
                    }.frame(height: 345, alignment: .center)
                    .padding()
                }
            }
            .padding(.top)
        }
        
    }
}

struct MostPopular: View {
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.stat_v, ascending: false)]
    ) var posts: FetchedResults<CorePost>
    var title:String = "Most Popular"
    
    var body: some View{
        VStack(alignment:.leading){
            VStack(alignment: .leading) {
                HStack{
                    Text("\(title)")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    NavigationLink(destination: MostPopularSeeAll()){
                        Text("See All")
                    }
                }
            }.padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(spacing: 12){
                    ForEach (posts, id: \.self){ post in
                        NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                            HorizontalPostCards(stylistId: "\(post.stylistId)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", imageUrl: "\(post.img!)", discount: post.discount)
                        }.buttonStyle(PlainButtonStyle())
                    }.id(UUID())
                }.frame(height: 345, alignment: .center)
                .padding()
            }
        }
        .padding(.top)
    }
}

struct TopTrending: View {
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.trending, ascending: false)]
    
    ) var posts: FetchedResults<CorePost>
    var title:String = "Top Trending"
    
    var body: some View{
        VStack(alignment:.leading){
            VStack(alignment: .leading) {
                HStack{
                    Text("\(title)")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    NavigationLink(destination: TopTrendingSeeAll()){
                        Text("See All")
                    }
                }
            }.padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(spacing: 12){
                    ForEach (posts, id: \.self){ post in
                        NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                            HorizontalPostCards(stylistId: "\(post.stylistId)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", imageUrl: "\(post.img!)", discount: post.discount)
                        }.buttonStyle(PlainButtonStyle())
                    }.id(UUID())
                }.frame(height: 345, alignment: .center)
                .padding()
            }
        }
        .padding(.top)
    }
}

struct EndingSoon: View {
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.endDate, ascending: true)]
    ) var posts: FetchedResults<CorePost>
    var title:String = "Top Sales"
    
    var body: some View{
        VStack(alignment:.leading){
            VStack(alignment: .leading) {
                HStack{
                    Text("\(title)")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    NavigationLink(destination: EndingSoonSeeAll()){
                        Text("See All")
                    }
                }
            }.padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(spacing: 12){
                    ForEach (posts, id: \.self){ post in
                        NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                            HorizontalPostCards(stylistId: "\(post.stylistId)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", imageUrl: "\(post.img!)", discount: post.discount)
                        }.buttonStyle(PlainButtonStyle())
                    }.id(UUID())
                }.frame(height: 345, alignment: .center)
                .padding()
            }
        }
        .padding(.top)
    }
}

struct NewPost: View {
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.createDate, ascending: false)]
    ) var posts: FetchedResults<CorePost>
    var title:String = "Top Sales"
    
    var body: some View{
        VStack(alignment:.leading){
            VStack(alignment: .leading) {
                HStack{
                    Text("\(title)")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    NavigationLink(destination: NewPostSeeAll()){
                        Text("See All")
                    }
                }
            }.padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(spacing: 12){
                    ForEach (posts, id: \.self){ post in
                        NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                            HorizontalPostCards(stylistId: "\(post.stylistId)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", imageUrl: "\(post.img!)", discount: post.discount)
                        }.buttonStyle(PlainButtonStyle())
                    }.id(UUID())
                }.frame(height: 345, alignment: .center)
                .padding()
            }
        }
        .padding(.top)
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
                .shadow(color: Color("LightShadow"), radius: 5, x: -7, y: -7)
                .shadow(color: Color("DarkShadow"), radius: 5, x: 5, y: 5)
                .blendMode(.overlay)
            }
        }.padding(.vertical)
    }
}

struct UserLocationView: View{
    @ObservedObject var locationManager = LocationManager()

       var latitude: String  { return("\(locationManager.location?.latitude ?? 0)") }
       var longitude: String { return("\(locationManager.location?.longitude ?? 0)") }
    var body: some View{
        LazyVStack{
            Text("Latitude: \(latitude)")
            Text("Longtitude: \(longitude)")
        }
    }
}
