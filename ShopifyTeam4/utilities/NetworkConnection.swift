//
//  NetworkConnection.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 18/06/2023.
//

import Foundation
import Network

class NetworkConnection {
   static func checkInternetConnection(pathMonitor:NWPathMonitor,completion: @escaping (Bool) -> Void) {
        pathMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("There is  Internet Connection")
                completion(true)
            } else {
                print("No Internet Connection")
                completion(false)
            }
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        pathMonitor.start(queue: queue)
    }
}
