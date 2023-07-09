//
//  ContentView.swift
//  ContactGame
//
//  Created by Beliy.Bear on 07.07.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var word = "Загрузка...".localized
    
    var body: some View {
        NavigationView {
            VStack {
                Text(word)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                Button(action: loadRandomWord) {
                    Text("Обновить слово".localized)
                        .foregroundStyle( colorScheme == .dark ? Color.black : Color.white)
                }
                .frame(width: 200, height: 50)
                .background( colorScheme == .dark ? Color.white : Color.black )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                .fontWeight(.bold)
            }.navigationBarTitle("Контакт".localized, displayMode: .inline)
        }
        .onAppear(perform: loadRandomWord)
    }
    
    func loadRandomWord() {
        var fileName = "singular"
        if let languageCode = Bundle.main.preferredLocalizations.first, languageCode == "en" {
            fileName = "singular_en"
        }

        if let filePath = Bundle.main.path(forResource: fileName, ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filePath, encoding: .utf8)
                let words = contents.components(separatedBy: "\n")
                if let randomWord = words.randomElement() {
                    word = randomWord
                }
            } catch {
                print("Ошибка чтения файла: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
