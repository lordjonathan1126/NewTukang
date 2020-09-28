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
                            NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                                TrendingCards(stylistId: "\(post.stylistId)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", imageUrl: "\(post.img!)", discount: post.discount)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }.frame(height: 345, alignment: .center)
                    .padding()
                }
            }
            .padding(.top)
        }
    }
}


struct TrendingCards: View{
    var title:String = "Sample title"
    var price: Double = 10.00
    var stylist:String = "Tammy How"
    var desc:String = "Description"
    var duration:String = "120"
    var imageUrl:String
    var discount: Double = 0.0
    let urlPath = Bundle.main.url(forResource: "Beauty", withExtension: "png")!
    
    var stylists: FetchRequest<CoreStylist>
    
    init(stylistId:String, title:String, price:Double, desc:String, duration:String, imageUrl:String, discount:Double){
        stylists = FetchRequest<CoreStylist>(
            entity: CoreStylist.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: true)],
            predicate: NSPredicate(format: "id == %@", stylistId))
        self.title = title
        self.price = price
        self.desc = desc
        self.duration = duration
        self.discount = discount
        self.imageUrl = imageUrl
    }
    
    var body: some View{
        VStack{
            UrlImageView(urlString: imageUrl)
                .frame(width: 200, height: 200, alignment: .top)
                .fixedSize()
            
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .font(.headline)
                        .lineLimit(2)
                        .frame(height: 45, alignment: .top)
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal)
                        .padding(.vertical)
                    Spacer()
                }
            }
            VStack(alignment:.leading){
                HStack{
                    ForEach(stylists.wrappedValue, id: \.self){ stylist in
                        Text("\(stylist.name ?? "Unknown Stylist")")
                            .bold()
                    }
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("\((price -  discount), specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(Color("Accent"))
                    if (discount != 0){
                        Text("\(price, specifier: "%.2f")")
                            .strikethrough(true)
                    }
                }.padding(.bottom)
            }.padding(.horizontal)
        }
        .padding()
        .frame(width: 200, height: 340)
        .background(Color("Background"))
        .cornerRadius(12)
        //.shadow(color: Color("LightShadow"), radius: 1, x: -5, y: -5)
        .shadow(color: Color("DarkShadow"), radius: 3, x: 5, y: 5)
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
                .shadow(color: Color("LightShadow"), radius: 5, x: -7, y: -7)
                .shadow(color: Color("DarkShadow"), radius: 5, x: 5, y: 5)
                .blendMode(.overlay)
            }
        }.padding(.bottom)
    }
}
