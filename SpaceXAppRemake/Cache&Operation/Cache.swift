//
//  Cache.swift
//  SpaceXAppRemake
//
//  Created by Perez Willie Nwobu on 1/7/19.
//  Copyright © 2019 Perez Willie Nwobu. All rights reserved.
//

import Foundation

class ConcurrentOperation: Operation {
    
    enum State: String {
        case isReady, isExecuting, isFinished
    }
    
    private var _state = State.isReady
    
    private let stateQueue = DispatchQueue(label: "CSG.SpaceXAppRemake.ConcurrentOperationStateQueue")
    
    
    var state: State {
        get {
            var result: State?
            let queue = self.stateQueue
            
            queue.sync {
                result = _state
            }
            return result!
            
            //First time this is run it will return the "isReadyState" then if can change later
        }
        
        set {
            let oldValue = state
            willChangeValue(forKey: newValue.rawValue)
            willChangeValue(forKey: oldValue.rawValue)
            
            stateQueue.sync { self._state = newValue }
            
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: newValue.rawValue)
        }
        
    }
    
    override  dynamic var isReady: Bool {
        return super.isReady && state == .isReady
    }
    
    override dynamic var isExecuting: Bool {
        return state == .isExecuting
    }
    
    override dynamic var  isFinished: Bool {
        return state == .isFinished
    }
    
    override  var isAsynchronous: Bool {
        return true
    }
    
}
