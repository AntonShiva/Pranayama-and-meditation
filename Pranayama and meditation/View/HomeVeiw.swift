//
//  HomeVeiw.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 08.06.2024.
//

import SwiftUI

struct HomeVeiw: View {
    @State var selectedTab: Tab = .svoiRejim
    var body: some View {
        ZStack{
            TabView(selection: $selectedTab) {
                SvoiRitm()
                    .padding(.bottom, 50)
                  
                    .tag(Tab.svoiRejim)
                VimHofView()
                    .padding(.bottom, 50)
                
                    .tag(Tab.vimHof)
                YogaNidra()
                    .padding(.bottom, 50)
                  
                
                    .tag(Tab.yogaNidra)
                History()
                    .padding(.bottom, 50)
                   .tag(Tab.history)
            }
            
            TabBarView(selectedTab: $selectedTab)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    HomeVeiw()
}
