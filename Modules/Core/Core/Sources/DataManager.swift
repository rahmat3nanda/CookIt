//
//  DataManager.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 13/02/25.
//

import Foundation
import AVFoundation
import RCache

class DataManager {
    private static var _instance: DataManager?
    private static let lock = NSLock()
    
    var isFirstLaunch: Bool = false
    
    private init(){}
    
    static var instance: DataManager {
        if _instance == nil {
            lock.lock()
            defer {
                lock.unlock()
            }
            if _instance == nil {
                _instance = DataManager()
            }
        }
        return _instance!
    }
    
    func initialize(completion: () -> Void) {
        isFirstLaunch = RCache.common.readBool(key: .isFirstLaunch) ?? false
    }
}
