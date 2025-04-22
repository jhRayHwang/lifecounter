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

    var body: some View {
        VStack(spacing: 16) {
            Text(name)
                .font(.title2)
                .bold()

            Text("\(life)")
                .font(.system(size: 72, weight: .semibold, design: .rounded))
                .minimumScaleFactor(0.5)

            // +1 / –1
            HStack(spacing: 16) {
                LifeButton(label: "+",  action: { life += 1 })
                LifeButton(label: "–",  action: { life -= 1 })
            }

            // +5 / –5
            HStack(spacing: 16) {
                LifeButton(label: "+5", action: { life += 5 })
                LifeButton(label: "–5", action: { life -= 5 })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
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
