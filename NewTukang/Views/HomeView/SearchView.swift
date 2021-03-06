//
//  SearchView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 24/08/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: CorePost.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CorePost.serviceName, ascending: true)]
    ) var posts: FetchedResults<CorePost>
    @FetchRequest(
        entity: CoreStylist.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.name, ascending: true)]
    ) var stylists: FetchedResults<CoreStylist>
    @FetchRequest(
        entity: CoreCompany.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CoreCompany.name, ascending: true)]
    ) var companies: FetchedResults<CoreCompany>
    
    @State var name = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    SearchBar(text: self.$name)
                    ScrollView{
                        LazyVStack{
                            ForEach(_posts.wrappedValue.filter(
                                        {name.isEmpty ? false : $0.serviceName!.localizedCaseInsensitiveContains(self.name)})
                                    , id: \.self)
                            { post in
                                NavigationLink(destination: DetailView(stylistId: "\(post.stylistId)", postId: "\(post.postId)", title:"\(post.serviceName!)", serviceTypeId: "\(post.serviceTypeId)")){
                                    PostCards(stylistId:"\(post.stylistId)", imageName: "\(post.img!)", title: "\(post.serviceName!)", price: post.normalPrice, desc: "\(post.desc!)", duration:"\(post.serviceDuration)", discount: post.discount)
                                        .padding()
                                }.buttonStyle(PlainButtonStyle())
                                Divider()
                            }.id(UUID())
                            ForEach(_stylists.wrappedValue.filter(
                                        {name.isEmpty ? false : $0.name!.localizedCaseInsensitiveContains(self.name)}), id: \.self){ stylist in
                                StylistCard( imageName:"\(stylist.img!)", stylistId:"\(stylist.id)",stylistName: "\(stylist.name!)", location: "\(stylist.location!)")
                                Divider()
                            }.id(UUID())
                            ForEach(_companies.wrappedValue.filter(
                                        {name.isEmpty ? false : $0.name!.localizedCaseInsensitiveContains(self.name)}), id: \.self){ company in
                                CompanyCard(imageName: "\(company.img!)", companyId: "\(company.id)", companyName: "\(company.name!)" , desc: "\(company.desc!)")
                                Divider()
                            }.id(UUID())
                        }
                    }
                }
            }
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Close")
                    .foregroundColor(Color("Accent"))
            })
            .navigationBarTitle("Search", displayMode: .inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


