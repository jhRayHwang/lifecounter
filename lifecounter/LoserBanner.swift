//
//  LoserBanner.swift
//  lifecounter
//
//  Created by Jung H Hwang on 4/21/25.
//

import SwiftUI

struct LoserBanner: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.title)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red)
    }
}
