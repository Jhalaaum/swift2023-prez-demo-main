//
//  CandidateDetailView.swift
//  Presidential Elections
//
//  Created by YJ Soon on 26/8/23.
//

import SwiftUI

struct CandidateDetailView: View {
    
    @Binding var candidate: Candidate
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Enter name", text: $candidate.name)
            }
            
            Section("Age") {
                Slider(value: $candidate.age, in: 21...99)
                Text("\(candidate.age)")
            }
            
            Section("Vote here") {
                Text("\(candidate.votes)")
                Button("Vote for this candidate") {
                    candidate.votes += 1
                }
            }
            
        }
    }
}

struct CandidateDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CandidateDetailView(candidate: .constant(Candidate(name: "Demo", age: 50, numberOfCats: 2, amountOfHair: 0.5)))
    }
}
