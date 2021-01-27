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
                LazyVStack{
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
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.postId, ascending: false)]
    ) var posts: FetchedResults<CorePost>
    var body: some View{
        let filtered1 = _posts.wrappedValue.filter(){
            $0.serviceTypeId == 1
        }
        let filtered2 = _posts.wrappedValue.filter(){
            $0.serviceTypeId == 2
        }
        let filtered3 = _posts.wrappedValue.filter(){
            $0.serviceTypeId == 3
        }
        let filtered4 = _posts.wrappedValue.filter(){
            $0.serviceTypeId == 4
        }
        VStack(alignment:.leading){
            Text("Our Services")
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 17){
                    if(filtered1.count != 0){
                        NavigationLink(destination: CategoryView( serviceTypeId:"1", title: "Hair")){
                            CategoryButton(title: "Hair", imageName: "Hair")
                        }.buttonStyle(PlainButtonStyle())
                    }
                    if(filtered2.count != 0){
                        NavigationLink(destination: CategoryView( serviceTypeId:"2", title: "Nail")){
                            CategoryButton(title: "Nail", imageName: "Nail")
                        }.buttonStyle(PlainButtonStyle())
                    }
                    if(filtered3.count != 0){
                        NavigationLink(destination: CategoryView( serviceTypeId:"3", title: "Spa")){
                            CategoryButton(title: "Lash", imageName: "Lash")
                        }.buttonStyle(PlainButtonStyle())
                    }
                    if(filtered4.count != 0){
                        NavigationLink(destination: CategoryView( serviceTypeId:"4", title: "Beauty")){
                            CategoryButton(title: "Beauty", imageName: "Spa")
                        }.buttonStyle(PlainButtonStyle())
                    }
                }.padding()
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
        }
    }
}

struct MostPurchased: View {
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.stat_p, ascending: false)]
    ) var posts: FetchedResults<CorePost>
    var title:String = "Most Purchased"
    let date = Date().timeIntervalSince1970
    
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
                        if(post.endDate > date ){
                            NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                                HorizontalPostCards(stylistId: "\(post.stylistId)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", imageUrl: "\(post.img!)", discount: post.discount)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
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
    var title:String = "Nearby"
    
    var latitude: Double  { return( locationManager.location?.latitude ?? 0) }
    var longitude: Double { return(locationManager.location?.longitude ?? 0) }
    
    var body: some View{
        if (locationManager.statusString == "authorizedWhenInUse"){
            if(_posts.wrappedValue.first?.distance ?? 10000001 < 10000000){
                VStack(alignment:.leading){
                    LocationTitle(stylistId: Int(_posts.wrappedValue.first!.stylistId))
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHStack(spacing: 10){
                            ForEach (posts, id: \.self){ post in
                                VStack{
                                    HStack{
                                        Image(systemName: "location")
                                        Text("\(post.distance/1000, specifier: "%.1f") km away")
                                    }.foregroundColor(.secondary)
                                    NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                                        HorizontalWidePostCards(stylistId: "\(post.stylistId)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", imageUrl: "\(post.img!)", discount: post.discount, distance: post.distance)
                                    }.buttonStyle(PlainButtonStyle())
                                }
                            }
                        }.frame(height: 420, alignment: .center)
                        .padding()
                    }
                }
                .padding(.top)
            }
        }
    }
}

struct LocationTitle: View {
    @FetchRequest var stylists: FetchedResults<CoreStylist>
    init(stylistId: Int){
        self._stylists = FetchRequest<CoreStylist>(
            entity: CoreStylist.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: true)],
            predicate: NSPredicate(format: "id == %@", "\(stylistId)"))
    }
    var body: some View{
        HStack{
            Image(systemName: "location.fill")
            Text("\((_stylists.wrappedValue.first?.location) ?? "Nearby")")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            //            NavigationLink(destination: LocationViewSeeAll()){
            //                Text("See All")
            //            }
        }
    }
}

struct MostPopular: View {
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.stat_v, ascending: false)]
    ) var posts: FetchedResults<CorePost>
    var title:String = "Most Popular"
    let date = Date().timeIntervalSince1970
    
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
                        if(post.endDate > date ){
                            NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                                HorizontalPostCards(stylistId: "\(post.stylistId)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", imageUrl: "\(post.img!)", discount: post.discount)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
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
    let date = Date().timeIntervalSince1970
    
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
                        if(post.endDate > date ){
                            NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                                HorizontalPostCards(stylistId: "\(post.stylistId)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", imageUrl: "\(post.img!)", discount: post.discount)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
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
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let dateCalculator = DateCalculator()
    var title:String = "Top Sales"
    let date = Date().timeIntervalSince1970
    
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
                        if(post.endDate > date ){
                            VStack{
                                HStack{
                                    Image(systemName: "timer")
                                    Text("\(dateCalculator.offsetFrom(date: NSDate(timeIntervalSince1970: post.endDate) as Date))")
                                }.foregroundColor(.secondary)
                                NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                                    HorizontalPostCards(stylistId: "\(post.stylistId)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", imageUrl: "\(post.img!)", discount: post.discount)
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }.frame(height: 355, alignment: .center)
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
    let date = Date().timeIntervalSince1970
    
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
                        if(post.endDate > date ){
                            NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                                HorizontalPostCards(stylistId: "\(post.stylistId)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", imageUrl: "\(post.img!)", discount: post.discount)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }.frame(height: 345, alignment: .center)
                .padding()
            }
        }
        .padding(.top)
    }
}


struct StylistCompanyListView: View{
    var body: some View{
        VStack(spacing:14){
            NavigationLink(destination: FavouriteView()){
                HStack{
                    Text("Favorites")
                        .font(.headline)
                        .foregroundColor(Color("Accent"))
                        .padding(.vertical)
                        .padding(.leading)
                    Image(systemName: "heart")
                        .foregroundColor(Color("Accent"))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.headline)
                        .foregroundColor(Color("Accent"))
                        .padding()
                }.background(Color("Background"))
                .cornerRadius(12)
                .shadow(color: Color("LightShadow"), radius: 5, x: -5, y: -5)
                .shadow(color: Color("DarkShadow"), radius: 5, x: 5, y: 5)
                .blendMode(.overlay)
            }
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
                .shadow(color: Color("LightShadow"), radius: 5, x: -7, y: -7)
                .shadow(color: Color("DarkShadow"), radius: 5, x: 5, y: 5)
                .blendMode(.overlay)
            }
        }.padding()
    }
}

