//
//  StylistView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 18/09/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI

struct StylistView: View {
    @FetchRequest(
        entity: CoreStylist.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.name, ascending: true)]
    ) var stylists: FetchedResults<CoreStylist>
    @State var name = ""
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
                ScrollView{
                        LazyVStack(spacing: 5){
                            SearchBar(text: self.$name)
                            ForEach(_stylists.wrappedValue.filter(
                                        {name.isEmpty ? true : $0.name!.localizedCaseInsensitiveContains(self.name)}), id: \.self){ stylist in
                                StylistCard( imageName:"\(stylist.img!)", stylistId:"\(stylist.id)",stylistName: "\(stylist.name!)", location: "\(stylist.location!)")
                                Divider()
                            }
                        }.padding(.bottom)
                }
        }.navigationBarTitle("Stylists", displayMode: .inline)
    }
}

