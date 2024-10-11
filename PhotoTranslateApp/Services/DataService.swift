//
//  DataService.swift
//  PhotoTranslateApp
//
//  Created by Kobe Shen on 2024-10-07.
//

import Foundation

struct DataService {
    
    private let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    
    func getTranslation(for text: String, targetLanguage: String = "ko") async -> String {
        guard apiKey != nil else {
            return "API Key Not Available"
        }
        let url = URL(string: "https://translation.googleapis.com/language/translate/v2?target=\(targetLanguage)&key=\(apiKey!)&q=\(text)")
        if let url = url {
            let request = URLRequest(url: url)
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                if let translatedText = parseTranslationResponse(data: data) {
                    return translatedText
                } else {
                    return "Translation parsing failed"
                }
            } catch {
                print(error)
            }
        }
        return ""
    }
    
    private func parseTranslationResponse(data: Data) -> String? {
        do {
            // Parse the JSON data into a dictionary
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let data = json["data"] as? [String: Any],
               let translations = data["translations"] as? [[String: Any]],
               let translatedText = translations.first?["translatedText"] as? String {
                return translatedText
            } else {
                print("Error: Unexpected JSON structure")
                return nil
            }
        } catch {
            print("Error parsing JSON: \(error)")
            return nil
        }
    }
}
