//
//  ContentView.swift
//  lifecounter
//
//  Created by Jung H Hwang on 4/21/25.
//
import SwiftUI

struct Player: Identifiable {
    let id   = UUID()
    let name: String
    var life: Int = 20
}

struct ContentView: View {
    @State private var players: [Player] = (1...4).map { Player(name: "Player \($0)") }
    @State private var history: [String] = []
    @State private var chunk: Int = 5

    // Game is “started” once any life ≠ 20
    private var gameStarted: Bool { players.contains { $0.life != 20 } }
    // Game is over once any life ≤ 0
    private var gameOver:   Bool { players.contains { $0.life <= 0 } }

    // Two equally flexible columns
    private let twoColumns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {

                // ── Top controls ──
                HStack {
                    Button("Add Player") {
                        let next = players.count + 1
                        players.append(Player(name: "Player \(next)"))
                    }
                    .disabled((gameStarted && !gameOver) || players.count >= 8)

                    Spacer()

                    NavigationLink("History") {
                        HistoryView(history: history)
                    }
                }
                .padding(.horizontal)

                // ── Global chunk control ──
                HStack {
                    Text("Chunk:")
                    TextField("Δ", value: $chunk, format: .number)
                        .keyboardType(.numberPad)
                        .frame(width: 60)
                        .textFieldStyle(.roundedBorder)
                    Spacer()
                }
                .padding(.horizontal)

                // ── Always two columns, horizontally ──
                ScrollView {
                    LazyVGrid(columns: twoColumns, spacing: 16) {
                        ForEach(players.indices, id: \.self) { idx in
                            panel(at: idx)
                                .frame(maxWidth: .infinity)
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                    .padding(.horizontal)
                }

                // ── Loser banner ──
                if gameOver, let loser = players.first(where: { $0.life <= 0 }) {
                    LoserBanner(text: "\(loser.name) LOSES!")
                }

                Spacer()
            }
            .navigationTitle("Life Counter v2")
        }
    }

    @ViewBuilder
    private func panel(at idx: Int) -> some View {
        PlayerPanel(
            name: players[idx].name,
            life: $players[idx].life,
            chunk: chunk,
            onChange: { delta in
                let verb = delta > 0 ? "gained" : "lost"
                history.append("\(players[idx].name) \(verb) \(abs(delta)) life.")
            },
            onDelete: {
                let removed = players.remove(at: idx)
                history.append("\(removed.name) was removed.")
            }
        )
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
