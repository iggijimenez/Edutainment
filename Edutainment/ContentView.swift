//
//  ContentView.swift
//  Edutainment
//
//  Created by jimenez on 2/19/24.
//

import SwiftUI

struct Question { // Struct for the questions
    let text: String
    let answer: Int
}

struct ContentView: View {
    @State private var isGameActive = false
    @State private var selectedTable = 2
    @State private var selectedQuestionCount = 5
    @State private var questions: [Question] = []
    @State private var currentQuestionIndex = 0
    @State private var userScore = 0
    @State private var userAnswer = ""

    var body: some View {
        NavigationView {
            VStack {
                if isGameActive {
                    GameView(question: questions[currentQuestionIndex], userAnswer: $userAnswer, userScore: $userScore, onSubmit: checkAnswer)
                } else {
                    SettingsView(startGame: startGame, selectedTable: $selectedTable, selectedQuestionCount: $selectedQuestionCount)
                }
            }
            .navigationTitle("Multiplication Practice")
        }
    }

    func startGame() { // calls the questions and sets game to active
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

    func checkAnswer() { // currently only checks the indexs
        let userEnterAnswer = Int(userAnswer) ?? 0
        
        if userEnterAnswer == questions[currentQuestionIndex].answer {
            print("Correct")
            userScore +=  1
        } else {
            if userScore > 0 {
                userScore -=  1
            }
            print("Wrong")
        }
        
        
        if currentQuestionIndex < selectedQuestionCount - 1 {
            currentQuestionIndex += 1
            userAnswer = ""
        } else { // if the index is out of bounds this is called
            endGame()
        }
    }

    func endGame() {
        isGameActive = false
    }
}

struct SettingsView: View {
    var startGame: () -> Void // This is a closure
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
    @Binding var userScore: Int
    var onSubmit: () -> Void

    var body: some View {
        VStack {
            Text(question.text)
                .font(.title)
                .padding()
            
            Text("\(userScore) Points")
            
            Text("\(question.answer)")
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

