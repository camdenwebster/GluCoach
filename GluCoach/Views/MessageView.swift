//
//  MessageView.swift
//  GluCoach
//
//  Created by Camden Webster on 8/10/25.
//

import FoundationModels
import SwiftUI

@available(macOS 26.0, *)
struct MessageView: View {
    let segments: [Transcript.Segment]
    let isUser: Bool
    
    
    
    var body: some View {
        VStack {
            ForEach(segments, id: \.id) { segment in
                switch segment {
                case .text(let text):
                    Text(text.content)
                        .padding(10)
                        .background(isUser ? Color(.secondarySystemFill) : .clear, in: .capsule)
                        .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
        
                case .structure:
                    EmptyView()
                @unknown default:
                    EmptyView()
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
