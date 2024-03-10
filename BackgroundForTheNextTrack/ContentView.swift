//
//  ContentView.swift
//  BackgroundForTheNextTrack
//
//  Created by Романенко Иван on 09.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var performAnimation = false
    
    var body: some View {
        Button {
            if !performAnimation {
                withAnimation(
                    .interpolatingSpring(
                        stiffness: 170,
                        damping: 15
                    )
                ) {
                    performAnimation = true
                } completion: {
                    performAnimation = false
                }
            }
        } label: {
            GeometryReader { proxy in
                let width = proxy.size.width / 2
                let systemName = "play.fill"
                
                HStack(spacing: 0) {
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: performAnimation ? width : .zero)
                        .opacity(performAnimation ? 1 : .zero)
                    
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width)
                    
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: performAnimation ? 0.5 : width)
                        .opacity(performAnimation ? .zero : 1)
                }
                .frame(maxHeight: .infinity)
            }
        }
        .frame(maxWidth: 62)
        .buttonStyle(ScaleButtonStyle())
    }
}

#Preview {
    ContentView()
}

struct ScaleButtonStyle: ButtonStyle {
    @State private var performAnimation = false
    private let animationDuration = 0.2
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundStyle(.blue)
            .background(
                Circle()
                    .fill(Color.gray.opacity(performAnimation ? 0.3 : .zero))
                    .padding(.all, -12)
                    .animation(.easeOut(duration: animationDuration), value: performAnimation)
            )
            .scaleEffect(performAnimation ? 0.86 : 1)
            .animation(.easeOut(duration: animationDuration), value: performAnimation)
            .onChange(of: configuration.isPressed) { _, newValue in
                guard newValue else { return }
                
                withAnimation(
                    .easeOut(duration: animationDuration)
                ) {
                    performAnimation = true
                } completion: {
                    performAnimation = false
                }
            }
    }
}
