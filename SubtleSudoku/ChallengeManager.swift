//
//  ChallengeManager.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 11/05/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import Foundation


class ChallengeManager {
    
    private let sampleChallengeId = "EASY 0001"
    private let sampleProbStr = "..3.2.6..9..3.5..1..18.64....81.29..7.......8..67.82....26.95..8..2.3..9..5.1.3.."
    private let sampleSoluStr = "483921657967345821251876493548132976729564138136798245372689514814253769695417382"

    
    var challenges: [SudoChallenge]
    
    static let sharedInstance = ChallengeManager()
    
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance.managedObjectContext
    }()

    private init () {
        challenges = [SudoChallenge]()
    }
    
    func loadChallenges() {
        challenges = fetchAllChallenges()
    }
    
    private func fetchAllChallenges() -> [SudoChallenge] {
        let fetchRequest = NSFetchRequest(entityName: "SudoChallenge")
        do {
            return try sharedContext.executeFetchRequest(fetchRequest) as! [SudoChallenge]
        } catch let error as NSError {
            print("Error in fetchAllChallenges - \(error)")
            return [SudoChallenge]()
        }
    }
    
    func createSampleData() {
        assert(challenges.count == 0, "Shouldn't be inserting sample data - core data not empty")
        let sc = SudoChallenge(puzzleId: sampleChallengeId, problemString: sampleProbStr, solutionString: sampleSoluStr, context: sharedContext)
        challenges.append(sc)
        CoreDataStackManager.sharedInstance.saveContext()
    }
    
    func hasChallengeWithId (id: String) -> Bool {
        for challenge in challenges {
            if challenge.puzzleId == id {
                return true
            }
        }
        return false
    }
}