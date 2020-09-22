//
//  CompaniesView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 18/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI
import URLImage

struct CompaniesView: View {
    @FetchRequest(
        entity: CoreCompany.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CoreCompany.id, ascending: true)]
    ) var companies: FetchedResults<CoreCompany>
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                if #available(iOS 14.0, *) {
                    LazyVStack(spacing: 14){
                        ForEach(_companies.wrappedValue, id: \.self){ company in
                            CompanyCard(imageName: "\(company.img!)", companyId: "\(company.id)", companyName: "\(company.name!)" , desc: "\(company.desc!)")
                        }
                    }
                }else{
                    VStack(spacing: 14){
                        ForEach(_companies.wrappedValue, id: \.self){ company in
                            CompanyCard(imageName: "\(company.img!)", companyId: "\(company.id)", companyName: "\(company.name!)" , desc: "\(company.desc!)")
                        }
                    }
                }
            }
        }.navigationBarTitle("Companies", displayMode: .inline)
    }
}

struct CompaniesView_Previews: PreviewProvider {
    static var previews: some View {
        CompaniesView()
    }
}

struct CompanyCard: View{
    var imageName:String = ""
    var companyId:String = "1"
    var companyName:String = "Tammy How"
    var desc:String = "KL"
    let urlPath = Bundle.main.url(forResource: "Beauty", withExtension: "png")!
    
    var body: some View{
        NavigationLink(destination: CompanyDetailView(companyId: companyId, title:companyName)){
            HStack{
                URLImage((URL(string: imageName) ?? urlPath) , placeholder: {_ in
                    Image("Beauty")
                        .resizable()
                        .frame(width: 100.0, height: 100.0)
                }){proxy in
                    proxy.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                        .overlay(Circle().stroke(Color("Accent")))
                        .padding()
                }
                
                Spacer()
                VStack(alignment: .leading){
                    Text("\(companyName)")
                        .font(.headline)
                }.padding()
            }
            .background(Color("Background"))
            .cornerRadius(12)
            .shadow(color: Color("LightShadow"), radius: 5, x: -5, y: -5)
            .shadow(color: Color("DarkShadow"), radius: 5, x: 8, y: 8)
            .blendMode(.overlay)
            .padding(.top)
            .padding(.horizontal)
        }.buttonStyle(PlainButtonStyle())
        
    }
}
