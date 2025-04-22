//
//  ContentView.swift
//  lifecounter
//
//  Created by Jung H Hwang on 4/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var life1 = 20
    @State private var life2 = 20

    var body: some View {
        GeometryReader { geo in
            let isPortrait = geo.size.height > geo.size.width

            ZStack {
                // Portrait: top & bottom, flipping the top for Player 1
                if isPortrait {
                    VStack(spacing: 0) {
                        PlayerPanel(name: "Player 1", life: $life1)
                            .rotationEffect(.degrees(180))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)

                        Divider()

                        PlayerPanel(name: "Player 2", life: $life2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                // Landscape: side by side, no flipping
                else {
                    HStack(spacing: 0) {
                        PlayerPanel(name: "Player 1", life: $life1)
                        PlayerPanel(name: "Player 2", life: $life2)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .edgesIgnoringSafeArea(.all)
            // Loser banner always at the bottom
            .overlay(alignment: .bottom) {
                if life1 <= 0 {
                    LoserBanner(text: "Player 1 LOSES!")
                } else if life2 <= 0 {
                    LoserBanner(text: "Player 2 LOSES!")
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()            // portrait
            ContentView()            // landscape
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
