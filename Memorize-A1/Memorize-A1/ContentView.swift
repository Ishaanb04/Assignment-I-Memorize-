//
//  ContentView.swift
//  Memorize-A1
//
//  Created by Ishaan Bhasin on 12/6/23.
//

import SwiftUI

struct ContentView: View {
    let halloweenEmojis: [String] = ["🎃", "🎃", "👻", "👻", "💀", "💀", "🕷️", "🕷️", "🕸️", "🕸️", "🧙‍♀️", "🧙‍♀️", "🧛‍♂️", "🧛‍♂️"]
    let sportsEmojis: [String] = ["⚽️", "⚽️", "⚾️", "⚾️", "🎾", "🎾", "🏀", "🏀", "🏈", "🏈"]
    let transportEmojis: [String] = ["🏎", "🏎", "🚌", "🚌", "🚎", "🚎", "🚕", "🚕", "🚗", "🚗", "🚙", "🚙"]

    @State var cardCount: Int = 2
    @State var currentTheme: [String] = ["🎃", "🎃", "👻", "👻", "💀", "💀", "🕷️", "🕷️", "🕸️", "🕸️", "🧙‍♀️", "🧙‍♀️", "🧛‍♂️", "🧛‍♂️"]
    var body: some View {
        VStack {
            title
            ScrollView {
                cards
            }
            .scrollIndicators(.hidden)

            Spacer()
            cardCountAdjuster
        }
        .padding()
    }

    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled((cardCount * 2) + (offset * 2) < 1 || (cardCount * 2) + (offset * 2) > currentTheme.count)
    }

    func themeAdjuster(to theme: [String], symbol: String, title: String) -> some View {
        Button {
            if (cardCount * 2) > theme.count {
                cardCount = (theme.count / 2)
            }
            currentTheme = theme.shuffled()
        } label: {
            VStack {
                Image(systemName: symbol)
                Text(title)
                    .font(.caption)
            }
        }
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))]) {
            ForEach(0 ..< cardCount * 2, id: \.self) { index in
                CardView(content: currentTheme[index])
                    .aspectRatio(2 / 3, contentMode: .fit)
            }
        }
        .foregroundStyle(Color.orange)
        .padding()
    }

    var cardCountAdjuster: some View {
        HStack(alignment: .bottom) {
            Spacer() // A spacer before the first element

            cardRemover
            Spacer() // Spacers between each element

            halloweenTheme
            Spacer() // Spacers between each element

            sportsTheme
            Spacer() // Spacers between each element

            transportTheme
            Spacer() // Spacers between each element

            cardAdder
            Spacer()
        }
        .imageScale(.large)
        .font(.largeTitle)
    }

    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }

    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
            .disabled(cardCount >= currentTheme.count)
    }

    var halloweenTheme: some View {
        themeAdjuster(to: halloweenEmojis, symbol: "pawprint.circle", title: "Halloween")
    }

    var sportsTheme: some View {
        themeAdjuster(to: sportsEmojis, symbol: "figure.run", title: "Sports")
    }

    var transportTheme: some View {
        themeAdjuster(to: transportEmojis, symbol: "car.circle.fill", title: "Transport")
    }

    var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = false
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(Color.white)
                base.stroke(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)

            base
                .fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
