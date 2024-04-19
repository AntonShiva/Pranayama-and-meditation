//
//  ProgressBarButtonView.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 16.04.2024.
//

import SwiftUI

struct ProgressBarButtonView: View {
  
      let value: String
   
            
      var body: some View {
               
                    ZStack {
                        Circle()
                            .stroke(style: .init(lineWidth: 3.5, lineCap: .round, lineJoin: .round))
                            .frame(width: 60, height: 60)
                            
                      
                        
                        Text(value)
                            .foregroundColor(.white)
                            .font(.system(size: 35))
                    }
                    .foregroundColor(.white)
                    
            }
}

