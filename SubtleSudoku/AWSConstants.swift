//
//  AWSConstants.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 14/04/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import Foundation

// Constants for AWS access

struct AWSConstants {
    
    
    static let CognitoRegionType = AWSRegionType.EUWest1
    static let DefaultServiceRegionType = AWSRegionType.EUWest1
    static let CognitoIdentityPoolId = "eu-west-1:6507b807-d1a0-4ba3-a665-7c00ea87db1b"
    
    static let MaxRetry: UInt32 = 1
    static let TimeoutInterval: NSTimeInterval = 20
    static let PageLimit = 100
}
