//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sebastian Villahermosa on 03/04/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreCounter = 0
    @State private var alertMessage = ""
    @State private var endgameCounter = 0
    var body: some View {
        
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            .ignoresSafeArea()
            VStack {
                
                Spacer()
                Text("Guess the Flag!")
                       .font(.largeTitle.bold())
                       .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                           
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            // flag was tapped
                        } label: {
                            VStack {
                                FlagImage(image: countries[number])
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Score: \(scoreCounter)")
                
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(alertMessage)
        }
        
    }
    

    func flagTapped(_ number: Int) {
        
        if number == correctAnswer {
            scoreTitle = "Correct!"
            scoreCounter += 1
            alertMessage = ""
        } else {
            scoreTitle = "Wrong"
            alertMessage = "Thats the wrong flag!"
        }
        endgameCounter += 1
        
        if endgameCounter == 8 {
            scoreTitle = "Endgame!"
            alertMessage = "Your scored \(scoreCounter) correctly guessed flags"
            reset()
        }
        showingScore = true
    }
    
    func reset() {
        scoreCounter = 0
        endgameCounter = 0
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlagImage: View {
    var image: String

    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}
