//
//  ContentView.swift
//  Edutainment
//
//  Created by jimenez on 2/19/24.
//

import SwiftUI

struct Question {
    let text: String
    let answer: Int
}

struct ContentView: View {
    @State private var isGameActive = false
    @State private var selectedTable = 2
    @State private var selectedQuestionCount = 5
    @State private var questions: [Question] = []
    @State private var currentQuestionIndex = 0
    @State private var userAnswer = ""

    var body: some View {
        NavigationView {
            VStack {
                if isGameActive {
                    GameView(question: questions[currentQuestionIndex], userAnswer: $userAnswer, onSubmit: checkAnswer)
                } else {
                    SettingsView(startGame: startGame, selectedTable: $selectedTable, selectedQuestionCount: $selectedQuestionCount)
                }
            }
            .navigationTitle("Multiplication Practice")
        }
    }

    func startGame() {
        isGameActive = true
        generateQuestions()
    }

    func generateQuestions() {
        questions = (1...selectedQuestionCount).map { _ in
            let multiplier = Int.random(in: 1...12)
            let questionText = "\(selectedTable) x \(multiplier) = ?"
            return Question(text: questionText, answer: selectedTable * multiplier)
        }
        currentQuestionIndex = 0
        userAnswer = ""
    }

    func checkAnswer() {
        // Handle checking the user's answer
        // You can add logic here to compare user's answer with the correct answer
        // and move to the next question or end the game accordingly.
        if currentQuestionIndex < selectedQuestionCount - 1 {
            currentQuestionIndex += 1
            userAnswer = ""
        } else {
            endGame()
        }
    }

    func endGame() {
        isGameActive = false
    }
}

struct SettingsView: View {
    var startGame: () -> Void
    @Binding var selectedTable: Int
    @Binding var selectedQuestionCount: Int

    var body: some View {
        VStack {
            Stepper("Multiplication Table: \(selectedTable)", value: $selectedTable, in: 2...12)
            Stepper("Number of Questions: \(selectedQuestionCount)", value: $selectedQuestionCount, in: 5...20, step: 5)
            Button("Start Game") {
                startGame()
            }
        }
        .padding()
    }
}

struct GameView: View {
    let question: Question
    @Binding var userAnswer: String
    var onSubmit: () -> Void

    var body: some View {
        VStack {
            Text(question.text)
                .font(.title)
                .padding()

            TextField("Your Answer", text: $userAnswer, onCommit: onSubmit)
                .keyboardType(.numberPad)
                .padding()

            Button("Submit") {
                onSubmit()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

