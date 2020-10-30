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
        sortDescriptors: [ NSSortDescriptor(keyPath: \CoreCompany.name, ascending: true)]
    ) var companies: FetchedResults<CoreCompany>
    @State var name = ""
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                SearchBar(text: self.$name)
                ScrollView{
                    LazyVStack(spacing: 5){
                        ForEach(_companies.wrappedValue.filter(
                                    {name.isEmpty ? true : $0.name!.localizedCaseInsensitiveContains(self.name)}), id: \.self){ company in
                            CompanyCard(imageName: "\(company.img!)", companyId: "\(company.id)", companyName: "\(company.name!)" , desc: "\(company.desc!)")
                            Divider()
                        }.id(UUID())
                    }.padding(.bottom)
                }
            }
        }.navigationBarTitle("Companies", displayMode: .inline)
    }
}
