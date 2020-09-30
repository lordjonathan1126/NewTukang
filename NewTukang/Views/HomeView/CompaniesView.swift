//
//  CompaniesView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 18/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct CompaniesView: View {
    @FetchRequest(
        entity: CoreCompany.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CoreCompany.id, ascending: false)]
    ) var companies: FetchedResults<CoreCompany>
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                    LazyVStack(spacing: 15){
                        ForEach(_companies.wrappedValue, id: \.self){ company in
                            CompanyCard(imageName: "\(company.img!)", companyId: "\(company.id)", companyName: "\(company.name!)" , desc: "\(company.desc!)")
                        }
                    }.padding(.bottom)
                
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
                UrlImageView(urlString: imageName)
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .overlay(Circle().stroke(Color("Accent")))
                    .padding()
                Spacer()
                VStack(alignment: .trailing){
                    HStack {
                        Spacer()
                        Text("\(companyName)")
                            .font(.headline)
                    }
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
