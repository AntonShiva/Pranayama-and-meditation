//
//  YogaNidra.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 06.06.2024.
//

import SwiftUI

struct YogaNidra: View {
    var body: some View {
        VStack(alignment: .center) {
             Image(decorative: "2")
                 .resizable()
                 .aspectRatio(contentMode: .fit)
             
                 .clipShape(.rect(cornerRadius: 20))
                 .padding(.top, 10.0)
                 
            Spacer()
            
            VStack {
                Text("Йога нидра")
                    .foregroundStyle(.cyan)
                .font(.system(size: 35))
                .padding(.top, 30)
            }
            
            Spacer()
             
         }
        .padding(.horizontal, 40.0)
    }
}

#Preview {
    YogaNidra()
}
