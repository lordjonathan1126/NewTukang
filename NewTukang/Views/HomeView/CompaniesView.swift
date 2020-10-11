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
                LazyVStack(spacing: 5){
                    ForEach(_companies.wrappedValue, id: \.self){ company in
                        CompanyCard(imageName: "\(company.img!)", companyId: "\(company.id)", companyName: "\(company.name!)" , desc: "\(company.desc!)")
                        Divider()
                    }.id(UUID())
                }.padding(.bottom)
            }
        }.navigationBarTitle("Companies", displayMode: .inline)
    }
}
