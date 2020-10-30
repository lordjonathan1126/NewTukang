//
//  DetailView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 11/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI
import MapKit

struct DetailView: View {
    @FetchRequest var posts: FetchedResults<CorePost>
    @FetchRequest var stylists: FetchedResults<CoreStylist>
    var stylistId:String
    var title:String
    var serviceTypeId:String
    var postId:String
    let urlPath = Bundle.main.url(forResource: "Beauty", withExtension: "png")!
    
    @State private var showingSheet = false
    
    init(stylistId:String, postId:String, title:String, serviceTypeId:String) {
        self._posts = FetchRequest<CorePost>(
            entity: CorePost.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.postId, ascending: true)],
            predicate: NSPredicate(format: "postId == %@", postId))
        self._stylists = FetchRequest<CoreStylist>(
            entity: CoreStylist.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: true)],
            predicate: NSPredicate(format: "id == %@", stylistId))
        self.serviceTypeId = serviceTypeId
        self.stylistId = stylistId
        self.title = title
        self.postId = postId
    }
    
    var body: some View {
            ZStack{
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    ScrollView{
                        LazyVStack(alignment: .leading, spacing: 12){
                            UrlImageView(urlString: _posts.wrappedValue.first?.img)
                            HStack{
                                Text("What you will get")
                                    .font(.title)
                                    .foregroundColor(Color("Accent"))
                                    .padding(.horizontal)
                                Spacer()
                                Text("\(_posts.wrappedValue.first!.serviceDuration) mins")
                                    .foregroundColor(.secondary)
                                    .padding(.trailing)
                            }
                            Text("\((_posts.wrappedValue.first?.desc!)!)")
                                .font(.body)
                                .lineLimit(nil)
                                .padding(.horizontal)
                            Text("")
                            if(_posts.wrappedValue.first?.imgs != nil){
                                VStack{
                                    ScrollView(.horizontal){
                                        LazyHStack{
                                            ForEach((_posts.wrappedValue.first?.imgs)!, id:\.self){ img in
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
                            VStack{
                                HStack{
                                    Text("Stylist")
                                        .font(.title)
                                        .bold()
                                        .padding(.leading)
                                    Spacer()
                                }
                                AboutStylist(stylistId: stylistId)
                            }
                            PostsByStylistView(stylistId: stylistId, postId: "\(postId)")
                            VStack {
                                HStack {
                                    Text("Company")
                                        .font(.title)
                                        .bold()
                                        .padding(.leading)
                                    Spacer()
                                }
                                AboutCompany(companyId:  Int(_stylists.wrappedValue.first!.companyId))
                                MeetTheTeam(companyId:  Int(_stylists.wrappedValue.first!.companyId))
                                
                            }
                            SimilarView(serviceTypeId: serviceTypeId, catId: String(_posts.wrappedValue.first!.serviceCatId), postId: "\(postId)")
                        }
                    }
                    Spacer()
                    HStack{
                        VStack(alignment: .leading) {
                            Text("\(title)")
                            HStack{
                                Text("\((_posts.wrappedValue.first!.normalPrice -  _posts.wrappedValue.first!.discount), specifier: "%.2f")")
                                    .font(.title)
                                    .foregroundColor(Color("Accent"))
                                if (_posts.wrappedValue.first?.discount != 0){
                                    Text("\(_posts.wrappedValue.first!.normalPrice, specifier: "%.2f")")
                                        .strikethrough(true)
                                }
                            }
                        }
                        Spacer()
                        BookButton(stylistId: stylistId)
                    }.padding(.horizontal)
                    .background(Color("LightShadow"))
                }.edgesIgnoringSafeArea(.bottom)
            }
        
        .navigationBarTitle("\(title)", displayMode: .inline)
    }
}

struct AboutStylist: View{
    @FetchRequest var stylists: FetchedResults<CoreStylist>
    var stylistId:String = "1"
    let urlPath = Bundle.main.url(forResource: "Beauty", withExtension: "png")!
    
    init(stylistId:String){
        self._stylists = FetchRequest<CoreStylist>(
            entity: CoreStylist.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: true)],
            predicate: NSPredicate(format: "id == %@", stylistId))
        self.stylistId = stylistId
    }
    
    var body: some View{
            VStack{
                NavigationLink(destination: StylistDetailView(stylistId: stylistId, title: (_stylists.wrappedValue.first?.name)!)){
                    HStack{
                        UrlImageView(urlString: _stylists.wrappedValue.first?.img)
                            .clipShape(Circle())
                            .frame(width: 70, height: 70)
                            .overlay(Circle().stroke(Color("Accent")))
                            .clipped()
                            .padding()
                        Spacer()
                        VStack(alignment: .trailing){
                            Text("\((_stylists.wrappedValue.first?.name)!)")
                                .font(.title)
                                .bold()
                            Text("\((_stylists.wrappedValue.first?.location)!)")
                                .foregroundColor(Color("Accent"))
                        }.padding()
                    }
                }.buttonStyle(PlainButtonStyle())
                Text("\(_stylists.wrappedValue.first?.desc ?? "No description available.")")
                    .lineLimit(nil)
                    .padding(.horizontal)
                DetailViewMap(latitude: Double(_stylists.wrappedValue.first!.lat), longtitude: Double(_stylists.wrappedValue.first!.lon))
            }
    }
}

struct DetailViewMap: View {
    @State private var region : MKCoordinateRegion
    @State private var showingActionSheet = false
    var latitude:Double = 0.0
    var longtitude: Double = 0.0
    var coordinate: CLLocationCoordinate2D
    let place = [
        VeganFoodPlace(name: "Kozy Eats", latitude: 56.951924, longitude: 24.125584)
    ]
    
    init(latitude:Double, longtitude: Double) {
        self.latitude = latitude
        self.longtitude = longtitude
        _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longtitude), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)))
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
    }
    var body: some View{
        Map(coordinateRegion: $region, annotationItems: place){ place in
            MapMarker(coordinate: coordinate, tint: Color("Accent"))
        }
        .frame (height: 170, alignment: .center)
        .onTapGesture {
            self.showingActionSheet = true
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Navigate"), buttons: [
                .default(Text("Apple Maps")) {
                    let link = "http://maps.apple.com/?daddr="
                    let lat = "\(latitude)"
                    let lon = "\(longtitude)"
                    let destination = lat + "," + lon
                    let formattedString = link + destination
                    let url: NSURL = URL(string: formattedString)! as NSURL
                    UIApplication.shared.open(url as URL)
                },
                .default(Text("Google Maps")) {
                    let link = "https://www.google.com/maps/search/?api=1&query="
                    let lat = "\(latitude)"
                    let lon = "\(longtitude)"
                    let destination = lat + "," + lon
                    let formattedString = link + destination
                    let url: NSURL = URL(string: formattedString)! as NSURL
                    UIApplication.shared.open(url as URL)
                },
                .default(Text("Waze")) {
                    let link = "https://waze.com/ul?ll="
                    let lat = "\(latitude)"
                    let lon = "\(longtitude)"
                    let destination = lat + "," + lon
                    let formattedString = link + destination
                    let url: NSURL = URL(string: formattedString)! as NSURL
                    UIApplication.shared.open(url as URL)
                },
                .cancel()
            ])
        }
    }
}

struct VeganFoodPlace: Identifiable {
    var id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct PostsByStylistView: View {
    @FetchRequest var posts: FetchedResults<CorePost>
    var stylistId: String
    var postId: String
    
    init(stylistId:String, postId:String) {
        self._posts = FetchRequest<CorePost>(
            entity: CorePost.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.postId, ascending: true)],
            predicate: NSPredicate(format: "stylistId == %@", stylistId))
        self.stylistId = stylistId
        self.postId = postId
    }
    
    var body: some View{
        if (_posts.wrappedValue.count > 1){
            VStack(alignment:.leading){
                VStack(alignment: .leading) {
                    Text("Posts by Stylist")
                        .font(.title)
                        .fontWeight(.bold)
                }.padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 12){
                        ForEach (_posts.wrappedValue, id: \.self){ post in
                            if("\(post.postId)" != postId){
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
}

struct AboutCompany :View {
   @FetchRequest var companies: FetchedResults<CoreCompany>
    var companyId:Int = 1
    let urlPath = Bundle.main.url(forResource: "Beauty", withExtension: "png")!
    
    init(companyId:Int){
        self._companies = FetchRequest<CoreCompany>(
            entity: CoreCompany.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreCompany.id, ascending: false)],
            predicate: NSPredicate(format: "id == %@", "\(companyId)"))
        self.companyId = companyId
    }
    var body: some View{
        LazyVStack {
            NavigationLink(destination: CompanyDetailView(companyId: "\(companyId)", title: (_companies.wrappedValue.first?.name)!)){
                    VStack {
                        HStack{
                            UrlImageView(urlString: _companies.wrappedValue.first?.img!)
                                .clipShape(Circle())
                                .frame(width: 75, height: 75)
                                .overlay(Circle().stroke(Color("Accent")))
                                .clipped()
                                .padding()
                            Spacer()
                            VStack(alignment: .trailing){
                                Text("\((_companies.wrappedValue.first?.name)!)")
                                    .font(.headline)
                                    .bold()
                                    .lineLimit(2)
                            }.padding(.trailing)
                        }
                        Text("\(_companies.wrappedValue.first?.desc ?? "No description available.")")
                            .lineLimit(nil)
                            .padding(.horizontal)
                    }.padding()
                }.buttonStyle(PlainButtonStyle())
            
        }
    }
}

struct MeetTheTeam:View {
    var companyId:Int = 1
    @FetchRequest var stylists: FetchedResults<CoreStylist>
    
    init(companyId:Int){
        self._stylists = FetchRequest<CoreStylist>(
            entity: CoreStylist.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: true)],
            predicate: NSPredicate(format: "companyId == %@", "\(companyId)"))
        self.companyId = companyId
    }
    var body: some View{
        if(_stylists.wrappedValue.count > 1){
            VStack{
                HStack{
                    Text("Meet The Team")
                        .font(.title)
                        .bold()
                        .padding(.leading)
                    Spacer()
                }
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing:14){
                        ForEach(_stylists.wrappedValue, id: \.self){ stylist in
                            HorizontalStylistCard(image: "\(stylist.img!)", name:"\(stylist.name!)", location: "\(stylist.location!)", stylistId: "\(stylist.id)")
                        }
                    }.padding()
                }
            }
        }
    }
}

struct SimilarView: View {
    @FetchRequest var posts: FetchedResults<CorePost>
    var serviceTypeId: String
    var catId:String
    var postId:String
    
    init(serviceTypeId:String, catId:String, postId:String) {
        self._posts = FetchRequest<CorePost>(
            entity: CorePost.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.postId, ascending: true)],
            predicate: NSPredicate(format: "serviceCatId == %@", catId))
        self.serviceTypeId = serviceTypeId
        self.catId = catId
        self.postId = postId
    }
    
    var body: some View {
        if(_posts.wrappedValue.count > 1){
            VStack(alignment:.leading){
                VStack(alignment: .leading) {
                    Text("Similar Posts")
                        .font(.title)
                        .fontWeight(.bold)
                }.padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 12){
                        ForEach (_posts.wrappedValue, id: \.self){ post in
                            if("\(post.postId)" != postId){
                                NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(serviceTypeId)")){
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
}

struct BookButton: View {
    var stylistId:String = ""
    @FetchRequest var stylists: FetchedResults<CoreStylist>
    @State private var showingActionSheet = false
    
    init(stylistId:String){
        self._stylists = FetchRequest<CoreStylist>(
            entity: CoreStylist.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: true)],
            predicate: NSPredicate(format: "id == %@", stylistId))
        self.stylistId = stylistId
    }
    var body: some View {
            Button(action: {
                self.showingActionSheet = true
            }) {
                Text("Contact")
                    .foregroundColor(.white)
                    .padding()
            }.background(Color("Accent"))
            .cornerRadius(10)
            .padding(.vertical)
            .shadow(color: Color("DarkShadow"), radius: 3, x: 3, y: 3)
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Contact stylist to book"), buttons: [
                    .default(Text("Call")) {
                        let tel = "tel://"
                        let phoneString = "\(String(describing: _stylists.wrappedValue.first?.mobile!))"
                        let formattedString = tel + phoneString
                        let url: NSURL = URL(string: formattedString)! as NSURL
                        UIApplication.shared.open(url as URL)
                    },
                    .default(Text("SMS")) {
                        let tel = "sms://"
                        let phoneString = "\(String(describing: _stylists.wrappedValue.first?.mobile!))"
                        let formattedString = tel + phoneString
                        let url: NSURL = URL(string: formattedString)! as NSURL
                        UIApplication.shared.open(url as URL)
                    },
                    .default(Text("Whatsapp")) {
                        let tel = "https://wa.me/"
                        let phoneString = "\(String(describing: _stylists.wrappedValue.first?.mobile!))"
                        let formattedString = tel + phoneString
                        let url: NSURL = URL(string: formattedString)! as NSURL
                        UIApplication.shared.open(url as URL)
                    },
                    .cancel()
                ])
            }
        
    }
}

