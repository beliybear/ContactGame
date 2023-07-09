//
//  ContentView.swift
//  ContactGame
//
//  Created by Beliy.Bear on 07.07.2023.
//

import SwiftUI

struct MainView: View {
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
                        .frame(maxWidth: 350)
                }
                .frame(minWidth: 200, maxWidth: 400, maxHeight: 50)
                .background( colorScheme == .dark ? Color.white : Color.black )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                .fontWeight(.bold)
            }
            .navigationBarTitle("Контакт".localized, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: InfoView()) {
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
            }
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
    MainView()
}
