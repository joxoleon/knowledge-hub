//
//  AttributedText.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 22.10.24..
//

import SwiftUI
import UIKit

// UIViewRepresentable for NSAttributedString to SwiftUI bridging
struct AttributedText: UIViewRepresentable {
    var attributedString: NSAttributedString

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = attributedString
    }
}

