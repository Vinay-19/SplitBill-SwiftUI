//
//  ContentView.swift
//  SplitBill
//
//  Created by Vinay Kumar Thapa on 2023-01-06.
//

import SwiftUI

struct ContentView: View {
    
    @State private var splitAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0
    @FocusState private var showKeyboard: Bool
    @State private var totalAmountWithTip: Double = 0.0
    @State private var amountPerPerson: Double = 0.0
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
//    var totalAmountWithTip: Double{
//
//        let tipPercent = Double(tipPercentage)
//        let tipValue = splitAmount * (tipPercent / 100)
//        let grandTotal = splitAmount + tipValue
//        return grandTotal
//
//
//    }
//    var amountPerPerson: Double {
//
//        let peopleCount = Double(numberOfPeople + 2)
//        let tipPercent = Double(tipPercentage)
//        let tipValue = splitAmount / 100 * tipPercent
//        let grandTotal = splitAmount + tipValue
//        let amountPerPerson = grandTotal  / peopleCount
//        return amountPerPerson
//
//    }
    var body: some View {
        NavigationView{
            ZStack{
                
                LinearGradient(gradient: .init(colors: [.white,.cyan]), startPoint: .bottom, endPoint: .top).ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("Enter the amount to split:")
                    TextField("Amount", value: $splitAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($showKeyboard)
                    
                    Text("Select the number of people:")
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<21){
                            Text("\($0) people")
                        }
                    }
                        
                    
                    Text("How much tip you want to leave?")
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                    
                    
                    Button("Calculate Amount") {
                        let peopleCount = Double(numberOfPeople + 2)
                        let tipPercent = Double(tipPercentage)
                        let tipValue = splitAmount * (tipPercent / 100)
                        let grandTotal = splitAmount + tipValue
                        totalAmountWithTip = grandTotal
                        amountPerPerson = grandTotal  / peopleCount
                    }.buttonStyle(.bordered)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Text("Total amount including tip: \(totalAmountWithTip.formatted())")
                    Text("Amount per person: \(amountPerPerson.formatted())")
                    
                    Spacer()
                    
                }
                
                
                .navigationTitle("Split Bill")
                .toolbar(){
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        Button("Done"){
                            showKeyboard = false
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
