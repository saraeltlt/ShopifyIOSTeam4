//
//  Observable.swift
//  Shopify_team4
//
//  Created by Sara Eltlt on 03/06/2023.
//

import Foundation

class Observable<T> {

    var value: T? {
        didSet {
                self.listener?(self.value)
        }
    }
    
    init( _ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind( _ listener: @escaping ((T?) -> Void)) {
        listener(value)
        self.listener = listener
    }
}
