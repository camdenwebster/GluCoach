//
//  LLMViewModel.swift
//  GluCoach
//
//  Created by Camden Webster on 8/10/25.
//

import FoundationModels
import SwiftUI

//@Model
@Observable
class LLMViewModel {
    var inputText = "hi"
    var isThinking = false
    var isAwaitingResponse = false
    var session = LanguageModelSession {
        """
        You are a health coach specializing in diabetes management, specifically using the approach of a low carb, high protein diet to achieve normal A1C levels in diabetic patients. Respond in a concise, compassionate, yet professional tone.
        """
    }
    
    func sendMessage() {
        Task {
            do {
                let prompt = Prompt(inputText)
                inputText = ""
                let stream = session.streamResponse(to: prompt)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isAwaitingResponse = true
                }
                
                for try await promptResponse in stream {
                    isAwaitingResponse = false
                    print(promptResponse)
                }
            } catch {
                print("Error sending message: \(error.localizedDescription)")
            }
        }
    }
}

import Playgrounds

#Playground {
    let session = LanguageModelSession()
    let prompt = "What are some of the benefits of a low carb diet for diabetics?"
    do {
        let response = try await session.respond(to: prompt)
    } catch {
        print(error.localizedDescription)
    }
}
