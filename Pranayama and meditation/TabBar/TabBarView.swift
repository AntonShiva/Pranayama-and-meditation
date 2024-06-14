//
//  TabBarView.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 29.03.2024.
//

import SwiftUI

struct TabBarView: View {
    let bgColor: Color = .init(white: 0.9)
    @Binding var selectedTab: Tab
    @Binding var direction: CGFloat
    var body: some View {
        ZStack {
            TabsLayoutView(selectedTab: $selectedTab, direction: $direction)
                .frame(height: 65, alignment: .center)
                .clipped()
        }
        .frame(height: 65, alignment: .center)
        .padding(.horizontal, 25)
    }
}

fileprivate struct TabsLayoutView: View {
    @Binding var selectedTab: Tab
    @Binding var direction: CGFloat
    @Namespace var namespace
    
    var body: some View {
        HStack {
            Spacer()
            
            ForEach(Tab.allCases, id: \.self) { tab in
                TabButton(tab: tab, selectedTab: $selectedTab, direction: $direction, namespace: namespace)
                    .frame(width: 55, height: 40, alignment: .center)
                
                Spacer()
            }
        }
    }
    
    private struct TabButton: View {
        let tab: Tab
        @Binding var selectedTab: Tab
        @Binding var direction: CGFloat
        var namespace: Namespace.ID
        
        var body: some View {
            Button {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)) {
                    direction = tab.rawValue < selectedTab.rawValue ? 1 : -1
                    selectedTab = tab
                }
            } label: {
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .fill(Color.white)
                            .overlay {
                                LinearGradient(colors: [.white.opacity(0.0001), tab.color.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                            }
                            .shadow(color: .white, radius: 4, x: -2, y: -2)
                            .shadow(color: tab.color.opacity(0.7), radius: 4, x: 4, y: 4)
                            .matchedGeometryEffect(id: "Selected Tab", in: namespace)
                    }
                    
                    Image(systemName: tab.icon)
                        .font(.system(size: 28, weight: .semibold, design: .rounded))
                        .foregroundColor(isSelected ? tab.color : .gray)
                        .scaleEffect(isSelected ? 1 : 0.9)
                        .animation(isSelected ? .spring(response: 0.5, dampingFraction: 0.3, blendDuration: 1) : .spring(), value: selectedTab)
                }
            }
        }
        
        private var isSelected: Bool {
            selectedTab == tab
        }
    }
}
//struct TabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarView()
//    }
//}
