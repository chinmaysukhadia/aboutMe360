//
//  Threads.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 15/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation

class Threads {
    
    static let concurrentQueue = DispatchQueue(label: "ConcurrentQueue", attributes: .concurrent)
    static let serialQueue = DispatchQueue(label: "SerialQueue")
    
    /// Perform task in global background thread
    ///
    /// - Parameter background: write your code inside task closure
    class func performTaskInBackground(task:@escaping () throws -> ()) {
        DispatchQueue.global(qos: .background).async {
            do {
                try task()
            } catch let error as NSError {
                print("error in background thread:\(error.localizedDescription)")
            }
        }
    }
    
    class func performTaskInMainQueue(task:@escaping () -> ()) {
        DispatchQueue.main.async {
            task()
        }
    }
    
    class func perfromTaskInConcurrentQueue(task:@escaping () throws -> ()) {
        concurrentQueue.async {
            do {
                try task()
            } catch let error as NSError {
                print("error in background thread:\(error.localizedDescription)")
            }
        }
    }
    
    class func perfromTaskInSerialQueue(task:@escaping () throws -> ()) {
        serialQueue.async {
            do {
                try task()
            } catch let error as NSError {
                print("error in background thread:\(error.localizedDescription)")
            }
        }
    }
    
    class func performTaskAfterDealy(_ timeInteval: TimeInterval, _ task:@escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: (.now() + timeInteval)) {
            task()
        }
    }
    
}

