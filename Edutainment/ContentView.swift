//
//  ContentView.swift
//  Edutainment
//
//  Created by jimenez on 2/19/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var stepperInput = 0
    @State private var tipPercentage = 5
    
    var tipPercentages = [5, 10, 20]
    
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                Text("You are multipling by: \(stepperInput)")
                Stepper("Multipling", value: $stepperInput, in: 2...12)
                
                Text("How many questions would you like to do?")
                
                Picker("Tip Percenatage", selection: $tipPercentage) {
                    ForEach(tipPercentages, id: \.self) {
                        Text($0, format: .number)
                    }
                }
                .pickerStyle(.segmented)
                
                Spacer()
                
                NavigationLink("Next") {
                    Text("Test")
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
