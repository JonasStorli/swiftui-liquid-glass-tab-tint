//
//  ContentView.swift
//  TabLiquidGlassTint
//
//  Created by Jonas Storli on 22/09/2026.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            Tab("Stripes", systemImage: "rectangle.grid.1x3.fill") {
                GlassTestPage(title: "Stripes", pattern: .stripes)
            }
            Tab("Checkerboard", systemImage: "rectangle.grid.3x3.fill") {
                GlassTestPage(title: "Checkerboard", pattern: .checkerboard)
            }
            Tab("Text", systemImage: "text.alignleft") {
                GlassTestPage(title: "Text", pattern: .text)
            }
            Tab("", systemImage: "star", role: .search) {
                GlassTestPage(title: "Rainbow", pattern: .rainbow)
            }
        }
        .tint(Color("accent"))
        .tabBarMinimizeBehavior(.onScrollDown)
        .background {
            SearchTabColor()
        }
    }
}

// MARK: - Test backgrounds

enum GlassPattern {
    case stripes, checkerboard, text, rainbow
}

struct GlassTestPage: View {
    let title: String
    let pattern: GlassPattern

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                Text(title)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 70)
                    .padding(.bottom, 12)
                    .background(.black)

                ForEach(0..<80, id: \.self) { i in
                    row(i)
                }
            }
        }
        .background(.black)
        .ignoresSafeArea()
    }

    @ViewBuilder
    private func row(_ i: Int) -> some View {
        switch pattern {
        case .stripes:
            Rectangle()
                .fill(i.isMultiple(of: 2) ? Color.red : Color.yellow)
                .frame(height: 24)

        case .checkerboard:
            HStack(spacing: 0) {
                ForEach(0..<8, id: \.self) { j in
                    Rectangle()
                        .fill((i + j).isMultiple(of: 2) ? Color.black : Color.white)
                }
            }
            .frame(height: 48)

        case .text:
            Text("The quick brown fox jumps over the lazy dog \(i)")
                .font(.title3.bold())
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(hue: Double(i % 12) / 12, saturation: 0.8, brightness: 0.75))

        case .rainbow:
            Rectangle()
                .fill(Color(hue: Double(i % 20) / 20, saturation: 1, brightness: 1))
                .frame(height: 36)
        }
    }
}

#Preview {
    ContentView()
}
