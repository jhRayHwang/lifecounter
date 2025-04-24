//
//  HistoryView.swift
//  lifecounter
//
//  Created by Jung H Hwang on 4/23/25.
//

import SwiftUI

struct HistoryView: View {
    let history: [String]

    var body: some View {
        List(history.indices, id: \.self) { idx in
            Text(history[idx])
        }
        .navigationTitle("History")
    }
}
