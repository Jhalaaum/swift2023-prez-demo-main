//
//  ContentView.swift
//  Presidential Elections
//
//  Created by YJ Soon on 26/8/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var candidateManager = CandidateManager()
    
    var body: some View {
        NavigationStack {
            List($candidateManager.candidates) { $candidate in
                NavigationLink {
                    CandidateDetailView(candidate: $candidate)
                } label: {
                    HStack {
                        Text(candidate.name)
                        Spacer()
                        Text("\(candidate.votes)")
                    }
                }
            }
            .navigationTitle("Candidates 2023")
            .toolbar {
                ToolbarItem {
                    Button {
                        candidateManager.candidates = Candidate.sampleCandidates
                    } label: {
                        Label("Load sample data", systemImage: "clipboard")
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
