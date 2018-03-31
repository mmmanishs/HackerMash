//
//  LocalDataManagerUSP.swift
//  HackerMash
//
//  Created by Manish Singh on 3/22/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
///USP - User story preference

class LocalDataManagerUSP {
    let path = DiskPath.userStoryPref.filepath()
    
    func save(usp: USP) {
        let u = read()
        if let index = u.usps.index(of: usp) {
            u.usps.remove(at: index)
        }
        u.date = Date()
        u.usps.append(usp)
        let data = try? JSONEncoder().encode(u)
        do {
            try data?.write(to: path)
        }
        catch {
            print("Failure to write usp data")
        }
    }
    
    func read() -> USPDisk {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: path)
            do {
                return try jsonDecoder.decode(USPDisk.self, from: data)
            } catch {
                return USPDisk(date: Date(), usps: [])
            }
        } catch {
            return USPDisk(date: Date(), usps: [])
        }
    }
    
    func getUSP(id: Int) -> USP {
        let usp = USP(id: id, isRead: false, isSaved: false, date: Date()) // Dummy for finding
        let data = read()
        if let index = data.usps.index(of: usp) {
            return data.usps[index]
        }
        return usp
    }
}

class USPDisk: Codable {
    var date: Date //Date last updated
    var usps: [USP]
    init(date: Date, usps: [USP]) {
        self.date = date
        self.usps = usps
    }
}

struct USP: Codable {
    var id: Int
    var isRead: Bool
    var isSaved: Bool
    var date: Date //Date last created
}

extension USP: Comparable {
    static func <(lhs: USP, rhs: USP) -> Bool {
        return lhs.id < rhs.id
    }
    
    static func ==(lhs: USP, rhs: USP) -> Bool {
        return lhs.id == rhs.id
    }
}
