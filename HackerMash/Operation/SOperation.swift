//
//  SOperation.swift
//  20180207-MS-NYCSchools
//
//  Created by Manish Singh on 2/11/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//


//Some generic coding for Operation class overriding

import Foundation

class SOperation: Operation {
    private var _executing = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    private var _finished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isFinished: Bool {
        return _finished
    }
    override var isExecuting: Bool {
        return _executing
    }
    
    func executing(_ executing: Bool) {
        _executing = executing
    }
    func finish(_ finished: Bool) {
        _finished = finished
    }
}
