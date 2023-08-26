//
//  NewCandidateView.swift
//  Presidential Elections
//
//  Created by James Toh on 26/8/23.
//

import SwiftUI

struct NewCandidateView: View {
    
    @Binding var sourceArray: [Candidate]
    
    var body: some View {
        Form{
            Section("name"){
                
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
