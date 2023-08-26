//
//  CandidatesManager.swift
//  Presidential Elections
//
//  Created by YJ Soon on 26/8/23.
//

import Foundation
import SwiftUI

class CandidateManager: ObservableObject {
    @Published var candidates: [Candidate] = [] {
        didSet {
            save()
        }
    }
        
    init() {
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "candidates.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedCandidates = try? propertyListEncoder.encode(candidates)
        try? encodedCandidates?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
                
        if let retrievedCandidateData = try? Data(contentsOf: archiveURL),
            let candidatesDecoded = try? propertyListDecoder.decode([Candidate].self, from: retrievedCandidateData) {
            candidates = candidatesDecoded
        }
    }
}
