//
//  ChallengeManager.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 11/05/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import Foundation


class ChallengeManager {
    
    private let sampleChallengeIdE = "EASY 0001"
    private let sampleProbStrE = "..3.2.6..9..3.5..1..18.64....81.29..7.......8..67.82....26.95..8..2.3..9..5.1.3.."
    private let sampleSoluStrE = "483921657967345821251876493548132976729564138136798245372689514814253769695417382"

    private let sampleChallengeIdH = "HARD 0001"
    private let sampleProbStrH = "4.....8.5.3..........7......2.....6.....8.4......1.......6.3.7.5..2.....1.4......"
    private let sampleSoluStrH = "417369825632158947958724316825437169791586432346912758289643571573291684164875293"
    
//    private let dummyId = "DUMMY"
//    private let dummyProbStr = "351286497492157638786934512275469183938.21764614873259829645371163792845547318926"
//    private let dummySoluStr = "351286497492157638786934512275469183938521764614873259829645371163792845547318926"
    

    
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
        sortChallenges()
        for challenge in challenges {
            challenge.resetState()
        }
    }
    
    func sortChallenges() {
        challenges.sortInPlace({$0.puzzleId < $1.puzzleId})
    }
    
    private func fetchAllChallenges() -> [SudoChallenge] {
        let fetchRequest = NSFetchRequest(entityName: "SudoChallenge")
        do {
            return try sharedContext.executeFetchRequest(fetchRequest) as! [SudoChallenge]
        } catch let error as NSError {
            err("Error in fetchAllChallenges - \(error)")
            return [SudoChallenge]()
        }
    }
    
    func createSampleData() {
        assert(challenges.count == 0, "Shouldn't be inserting sample data - core data not empty")
        let sce = SudoChallenge(puzzleId: sampleChallengeIdE, problemString: sampleProbStrE, solutionString: sampleSoluStrE, context: sharedContext)
        challenges.append(sce)
        let sch = SudoChallenge(puzzleId: sampleChallengeIdH, problemString: sampleProbStrH, solutionString: sampleSoluStrH, context: sharedContext)
        challenges.append(sch)
//        let dum = SudoChallenge(puzzleId: dummyId, problemString: dummyProbStr, solutionString: dummySoluStr, context: sharedContext)
//        challenges.append(dum)
        CoreDataStackManager.sharedInstance.saveContext()
    }
    
    func createNewChallenge(puzzleId: String, problemString: String, solutionString: String) -> SudoChallenge {
        let newChallenge = SudoChallenge(puzzleId: puzzleId, problemString: problemString, solutionString: solutionString, context: sharedContext)
        challenges.append(newChallenge)
        sortChallenges()
        CoreDataStackManager.sharedInstance.saveContext()
        return newChallenge
    }
    
    func removeChallenge(challenge: SudoChallenge) {
        if let index = challenges.indexOf(challenge) {
            challenges.removeAtIndex(index)
            sharedContext.deleteObject(challenge)
            CoreDataStackManager.sharedInstance.saveContext()
        }
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