//
//  BreatheView.swift
//  Pranayama and meditation
//
//  Created by Anton Rasen on 13.04.2024.
//

import SwiftUI

struct BreatheView: View {
    // MARK: View Properties
    @State var currentType: BreatheType = sampleTypes[0]
    @Namespace var animation
    // MARK: View Properties
    @State var showBreatheView: Bool = false
    @State var startAnimation: Bool = false
    // MARK: This Timer Properties
    @State var timerCount: CGFloat = 0
    @State var breatheAction: String = ("Вдох")
    @State var count: Int = 0
    var body: some View {
        ZStack{
            Background()
            
            Content()
            
            Text(breatheAction)
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(maxHeight: .infinity,alignment: .top)
                .padding(.top,50)
                .opacity(showBreatheView ? 1 : 0)
                
                .animation(.easeInOut(duration: 1), value: showBreatheView)
                .animation(.easeInOut(duration: 1), value: breatheAction)
        }
        // MARK: Timer
        .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
            if showBreatheView{
                // MARK: Extra Time For 0.1 Delay
                if timerCount > 3.2{
                    timerCount = 0
                    breatheAction = (breatheAction == ( "Вдох") ? ("Выдох") : ("Вдох"))
                    withAnimation(.easeInOut(duration: 3).delay(0.1)){
                        startAnimation.toggle()
                    }
                    // MARK: Haptic Feedback
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                }else{
                    timerCount += 0.01
                }
                
                count = 3 - Int(timerCount)
            }else{
                // MARK: Resetting
                timerCount = 0
            }
        }
    }
    
    // MARK: Main Content
    @ViewBuilder
    func Content()->some View{
        VStack{

            
            GeometryReader{proxy in
                let size = proxy.size
                
                VStack{
                    BreatheView(size: size)
                    
                    // MARK: View Properties
                    Text("Пауза")
                        .font(.title3)
                        .foregroundColor(.white)
                        .opacity(showBreatheView ? 0 : 1)

                    
                    Button(action: startBreathing) {
                        Text(showBreatheView ? "Стоп" : "Старт")
                            .fontWeight(.semibold)
                            .foregroundColor(showBreatheView ? .white.opacity(0.75) : .black)
                            .padding(.vertical,15)
                            .frame(maxWidth: .infinity)
                            .background {
                                if showBreatheView{
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .stroke(.white.opacity(0.5))
                                }else{
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .fill(currentType.color.gradient)
                                }
                            }
                    }
                    .padding()
                }
                .frame(width: size.width, height: size.height, alignment: .bottom)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    // MARK: Breathe Animated Circles
    @ViewBuilder
    func BreatheView(size: CGSize)->some View{
        // MARK: We're Going to Use 8 Circles
        // It's Your Wish
        // 360/8 = 45deg For Each Circle
        ZStack{
            ForEach(1...8,id: \.self){index in
                Circle()
                    .fill(currentType.color.gradient.opacity(0.5))
                    .frame(width: 150, height: 150)
                // 150 /2 -> 75
                    .offset(x: startAnimation ? 75 : 0)
                    .rotationEffect(.init(degrees: Double(index) * 45 ))
                    .rotationEffect(.init(degrees: startAnimation ? -45 : 0))
                
                
            }
        }
        .scaleEffect(startAnimation ? 1 : 0.7)
        .overlay(content: {
            Text("\(count == 0 ? 1 : count)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .animation(.easeInOut, value: count)
                .opacity(showBreatheView ? 1 : 0)
        })
        .frame(height: (size.width + 190))
    }
    
    // MARK: Background Image With Gradient Overlays
    @ViewBuilder
    func Background()->some View{
        GeometryReader{proxy in
            let size = proxy.size
            Image("BG")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(x: -40 ,y: 0)
                .frame(width: size.width, height: size.height)
                .clipped()
            // MARK: Blurrubg White Breathing
                .blur(radius: startAnimation ? 4 : 0, opaque: true)
                .overlay {
                    ZStack{
                        Rectangle()
                            .fill(.linearGradient(colors: [
                                currentType.color.opacity(0.9),
                                .clear,
                                .clear
                            ], startPoint: .top, endPoint: .bottom))
                            .frame(height: size.height / 1.5)
                            .frame(maxHeight: .infinity,alignment: .top)
                        Rectangle()
                            .fill(.linearGradient(colors: [
                                .clear,
                                .black,
                                .black,
                                .black,
                                .black
                            ], startPoint: .top, endPoint: .bottom))
                            .frame(height: size.height / 1.5)
                            .frame(maxHeight: .infinity,alignment: .bottom)
                            .opacity(0.6)
                    }
                }
        }
        .ignoresSafeArea()
    }
    
    // MARK: Breathing Action
    func startBreathing(){
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
            showBreatheView.toggle()
        }
        
        if showBreatheView{
            // MARK: Breathe View Animation
            // Since We Have Max 3 secs Of Breathe
            withAnimation(.easeInOut(duration: 3).delay(0.05)){
                startAnimation = true
            }
        }else{
            withAnimation(.easeInOut(duration: 1.5)){
                startAnimation = true
            }
        }
    }
}
#Preview {
    BreatheView()
}
