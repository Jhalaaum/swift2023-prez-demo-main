//
//  MainCandidatesView.swift
//  Presidential Elections
//
//  Created by James Toh on 26/8/23.
//

import SwiftUI

struct MainCandidatesView: View {
    
    
    @StateObject private var candidateManager = CandidateManager()
    @State private var isPresented = false
    
    var body: some View {
        NavigationStack {
            List($candidateManager.candidates, id: \.id, editActions: .all) { $candidate in
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
                ToolbarItem {
                    Button{
                        isPresented = true
                    }label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
            }
            .sheet(isPresented: $isPresented) {
                NewCandidateView(sourceArray: $candidateManager.candidates)
            }
        }    }
}

struct MainCandidatesView_Previews: PreviewProvider {
    static var previews: some View {
        MainCandidatesView()
    }
}
