//
//  OpenAIModel.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 26/05/24.
//

import Foundation

struct OpenAIResponse: Codable {
    struct Choice: Codable {
        let message: Message
    }
    struct Message: Codable {
        let role, content: String
    }

    let choices: [Choice]
}

class OpenAIModel {
    static let shared = OpenAIModel()
    // put your own apiKey in here. For further information, heads to OpenAI website.
    private let apiKey = ""
    private let session = URLSession.shared

    func summarize(text: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            print("Invalid URL")
            completion("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let systemMessage: [String: Any] = [
            "role": "system",
            "content": [
                [
                    "type": "text",
                    "text": "You will be provided with meeting notes, and your task is to summarize the meeting as follows:\n\n-Overall summary of discussion\n-Action items (what needs to be done and who is doing it)\n-If applicable, a list of topics that need to be discussed more fully in the next meeting. use indonesia language"
                ]
            ]
        ]
        let userMessage: [String: Any] = [
            "role": "user",
            "content": [
                [
                    "type": "text",
                    "text": text
                ]
            ]
        ]
        let json: [String: Any] = [
            "model": "gpt-4-turbo",
            "messages": [systemMessage, userMessage],
            "temperature": 0.7,
            "max_tokens": 500,
            "top_p": 1,
            "frequency_penalty": 0,
            "presence_penalty": 0
        ]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network request failed: \(error)")
                DispatchQueue.main.async {
                    completion("Network request failed: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion("No data received")
                }
                return
            }
            
            
            // Attempt to decode the data
            do {
                let response = try JSONDecoder().decode(OpenAIResponse.self, from: data)
                print("Decoding successful, processing response...")
                
                // You need to ensure that the path to access the message content is correct.
                // This example assumes your JSON paths and types need to be correct according to the received JSON structure.
                if let messageContent = response.choices.first?.message.content {
                    print("First message content: \(messageContent)")
                    DispatchQueue.main.async {
                        completion(messageContent)
                    }
                } else {
                    print("No message content found")
                    DispatchQueue.main.async {
                        completion("No message content available")
                    }
                }
            } catch {
                print("Failed to decode response: \(error)")
                DispatchQueue.main.async {
                    completion("Failed to decode response: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
