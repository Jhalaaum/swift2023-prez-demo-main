//
//  NewCandidateView.swift
//  Presidential Elections
//
//  Created by James Toh on 26/8/23.
//

import SwiftUI

struct NewCandidateView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var sourceArray: [Candidate]
    @State private var name = ""
    @State private var age = 0
    @State private var catNumber = 0
    @State private var hairAmount = 0.0
        
    
    var body: some View {
        Form{
            Section("Details"){
                TextField("Name", text: $name)
                Picker("Age", selection: $age){
                    ForEach(21..<100) { number in
                        Text("\(number)")
                            .tag(number)
                    }
                }
                Picker("Number of cats", selection: $catNumber){
                    ForEach(0..<7) { number in
                        Text("\(number)")
                            .tag(number)
                    }
                }
            }
            
            Section("Attributes"){
                Slider( value: $hairAmount, in: 0...1)
            }
            
            Section("Actions"){
                Button("Save"){
                    sourceArray.append(Candidate(name: name, age: Double(age), numberOfCats: Double(catNumber), amountOfHair: hairAmount))
                    dismiss()
                }
                .foregroundColor(.blue)
                
                Button("Cancel", role: .destructive){
                    dismiss()
                }
                .foregroundColor(.red)
            }
        }
        .navigationTitle("New Candidate")
    }
}

struct NewCandidateView_Previews: PreviewProvider {
    static var previews: some View {
        NewCandidateView(sourceArray: .constant([]))
    }
}
