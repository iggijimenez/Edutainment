//
//  ContentView.swift
//  Edutainment
//
//  Created by jimenez on 2/19/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var stepperInput = 2
    @State private var questionNumber = 5
    
    @State private var numbers = [1,2,3,4,5,6,7,8,9,10,11,12].shuffled()
    
    var questionNumbers = [5, 10, 20]
    
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                Text("You are multipling by: \(stepperInput)")
                Stepper("Multipling", value: $stepperInput, in: 2...12)
                
                Spacer()
                
                Text("How many questions would you like to do?")
                
                Picker("Tip Percenatage", selection: $questionNumber) {
                    ForEach(questionNumbers, id: \.self) {
                        Text($0, format: .number)
                    }
                }
                .pickerStyle(.segmented)
                
                Spacer()
                
                NavigationLink("Next") {
                    ForEach(0..<questionNumber, id: \.self ) { num in
                        Text("Test: \(stepperInput) x \(numbers[num])")
                    }
                }
                
                Spacer()
                
                

            }
            .padding()
            .navigationTitle("Home")
        }
    }
    
    func solveMultiplactiion() { // stepperinput * numbers[num]
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
