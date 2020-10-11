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
        sortDescriptors: [ NSSortDescriptor(keyPath: \CoreStylist.id, ascending: false)]
    ) var stylists: FetchedResults<CoreStylist>
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                    LazyVStack(spacing: 5){
                        ForEach(_stylists.wrappedValue, id: \.self){ stylist in
                            StylistCard( imageName:"\(stylist.img!)", stylistId:"\(stylist.id)",stylistName: "\(stylist.name!)", location: "\(stylist.location!)")
                            Divider()
                        }.id(UUID())
                    }.padding(.bottom)
            }
        }.navigationBarTitle("Stylists", displayMode: .inline)
    }
}

