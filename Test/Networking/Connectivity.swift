//
//  Connectivity.swift
//  Test
//
//  Created by Justin Zaw on 17/07/2020.
//  Copyright © 2020 Justin Zaw. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
