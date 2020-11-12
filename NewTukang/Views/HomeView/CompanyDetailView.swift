//
//  CompanyDetailView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 18/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct CompanyDetailView: View {
    var companyId:String = "1"
    var title:String = "Unkown Company"
    var companies: FetchRequest<CoreCompany>
    var stylists: FetchRequest<CoreStylist>
    @State private var isFavorite = false
    
    init(companyId:String, title:String) {
        companies = FetchRequest<CoreCompany>(
            entity: CoreCompany.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreCompany.id, ascending: true)],
            predicate: NSPredicate(format: "id == %@", companyId))
        
        stylists = FetchRequest<CoreStylist>(
            entity: CoreStylist.entity(),
            sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: true)],
            predicate: NSPredicate(format: "companyId == %@", companyId))
        
        self.title = title
    }
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                LazyVStack(spacing: 12){
                    HStack {
                        UrlImageView(urlString: companies.wrappedValue.first?.img)
                            .clipShape(Circle())
                            .frame(width: 70, height: 70)
                            .overlay(Circle().stroke(Color("Accent")))
                            .clipped()
                            .padding()
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text((companies.wrappedValue.first?.name)!)
                                .font(.title)
                                .bold()
                        }
                    }.padding(.horizontal)
                    Text((companies.wrappedValue.first?.desc)!)
                        .padding(.horizontal)
                    if(companies.wrappedValue.first?.imgs != nil){
                        VStack {
                            ScrollView(.horizontal){
                                LazyHStack{
                                    ForEach((companies.wrappedValue.first?.imgs)! , id:\.self){ img in
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
                    
                    HStack{
                        Text("Stylist")
                            .font(.title)
                            .bold()
                            .padding()
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHStack(spacing: 20){
                            ForEach(stylists.wrappedValue, id: \.self){ stylist in
                                HorizontalStylistCard( image:"\(stylist.img!)" ,name:"\(stylist.name!)",location:"\(stylist.location!)" , stylistId: "\(stylist.id)")
                            }
                        }.padding()
                    }
                }
            }
        }
        .navigationBarTitle("\(title)", displayMode: .inline)
    }
}

struct CompanyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyDetailView(companyId: "1", title: "Unknown Company")
    }
}

