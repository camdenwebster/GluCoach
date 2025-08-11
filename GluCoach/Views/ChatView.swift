//
//  ChatView.swift
//  GluCoach
//
//  Created by Camden Webster on 8/8/25.
//

import FoundationModels

import SwiftUI

struct ChatView: View {
    @State var vm = LLMViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    ForEach(vm.session.transcript) { entry in
                        Group {
                            switch entry {
                            case .prompt(let prompt):
                                MessageView(segments: prompt.segments, isUser: true)
                                    .transition(.offset(y: 500))
                                    .padding(.trailing, 10)
                            case .response(let response):
                                MessageView(segments: response.segments, isUser: false)
                                    .padding(.leading, 10)
                            default:
                                EmptyView()
                            }
                        }
                    }
                }
                .animation(.easeInOut, value: vm.session.transcript)
                
                if vm.isAwaitingResponse {
                    if let last = vm.session.transcript.last {
                        if case .prompt = last {
                            Text("Thinking...").bold()
                                .opacity(vm.isThinking ? 0.5 : 1)
                                .padding(.leading)
                                .offset(y: 15)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onAppear {
                                    withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)) {
                                        vm.isThinking.toggle()
                                    }
                                }
                        }
                    }
                }
            }
            .defaultScrollAnchor(.bottom, for: .sizeChanges)
            .safeAreaPadding(.bottom, 100)
            
            HStack {
                TextField("Ask me anything...", text: $vm.inputText, axis: .vertical)
                    .textFieldStyle(.plain)
                    .disabled(vm.session.isResponding)
                    .frame(height: 55)
                Button {
                    vm.sendMessage()
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(vm.session.isResponding ? Color.gray.opacity(0.6) : .primary)
                }
                .disabled(vm.inputText.isEmpty || vm.session.isResponding)
            }
            .padding(.horizontal)
            .glassEffect(.regular.interactive())
            .padding()
            .frame(maxHeight: .infinity, alignment: .bottom)
        }

    }
    
}

@available(macOS 26.0, *)
#Preview {
    ChatView()
}
