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
                    ForEach(0..<questionNumber, id: \.self ) {_ in
                        Text("Test: \(stepperInput)")
                    }
                }
                
                Spacer()
                
                

            }
            .padding()
            .navigationTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
