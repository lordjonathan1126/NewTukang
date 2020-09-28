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
                if #available(iOS 14.0, *) {
                    LazyVStack(spacing: 14){
                           
                        ForEach(companies.wrappedValue, id: \.self){ company in
                            HStack {
                                UrlImageView(urlString: "\(company.img!)")
                                    .clipShape(Circle())
                                    .frame(width: 70, height: 70)
                                    .overlay(Circle().stroke(Color("Accent")))
                                    .clipped()
                                    .padding()
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("\(company.name!)")
                                        .font(.title)
                                        .bold()
                                }
                            }.padding(.horizontal)
                            Text("\(company.desc!)")
                                .padding(.horizontal)
                        }
                        
                        HStack {
                            Text("Stylist")
                                .font(.title)
                                .bold()
                                .padding()
                            Spacer()
                        }
                        ForEach(stylists.wrappedValue, id: \.self){ stylist in
                            StylistCard( imageName:"\(stylist.img!)" ,stylistId:"\(stylist.id)",stylistName: "\(stylist.name!)", location: "\(stylist.location!)")
                        }
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

