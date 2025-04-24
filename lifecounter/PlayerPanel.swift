//
//  PlayerPanel.swift
//  lifecounter
//
//  Created by Jung H Hwang on 4/21/25.
//

import SwiftUI

struct PlayerPanel: View {
    let name: String
    @Binding var life: Int
    let chunk: Int                      // ← new
    var onChange: (Int) -> Void
    var onDelete:   ()  -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 8) {
                Text(name)
                    .font(.headline)

                Text("\(life)")
                    .font(.system(size: 48, weight: .semibold))
                    .minimumScaleFactor(0.5)

                // ±1 buttons
                HStack(spacing: 12) {
                    LifeButton(label: "+") {
                        life += 1; onChange(1)
                    }
                    LifeButton(label: "–") {
                        life -= 1; onChange(-1)
                    }
                }

                // ±chunk buttons, using the passed-in chunk
                HStack(spacing: 12) {
                    LifeButton(label: "+\(chunk)") {
                        life += chunk; onChange(chunk)
                    }
                    LifeButton(label: "–\(chunk)") {
                        life -= chunk; onChange(-chunk)
                    }
                }
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(8)

            // delete button in corner
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
                    .font(.title2)
            }
            .padding(6)
        }
    }
}


struct LifeButton: View {
    let label: String
    let action: () -> Void

    var body: some View {
        Button(label, action: action)
            .font(.title)
            .frame(minWidth: 60, minHeight: 60)
            .background(Color.accentColor.opacity(0.1))
            .cornerRadius(8)
    }
}
