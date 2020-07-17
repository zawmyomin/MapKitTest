//
//  Connection.swift
//  Test
//
//  Created by Justin Zaw on 24/04/2020.
//  Copyright © 2020 Justin Zaw. All rights reserved.
//

import Foundation
import Alamofire


class Connection {
    class func isInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}


