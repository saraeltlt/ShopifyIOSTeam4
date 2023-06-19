//
//  NetworkConnection.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 18/06/2023.
//

import Foundation
import Network
class InternetConnectionObservation {
    var internetConnection:Observable<Bool>=Observable(nil)
    var pathMonitor = NWPathMonitor()
    static let getInstance = InternetConnectionObservation()
    private init() {}
    func checkInternetConnection() {
        pathMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Internet Connection ((FROM SCENE DELGATE))")
                self.internetConnection.value = true
            } else {
                print("No Internet Connection ((FROM SCENE DELGATE))")
                self.internetConnection.value = false
            }
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        pathMonitor.start(queue: queue)
    }
}

