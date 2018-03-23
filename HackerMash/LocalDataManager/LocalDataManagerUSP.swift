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
        var u = read()
        if let index = u.index(of: usp) {
            u.remove(at: index)
        }
        u.append(usp)
        let data = try? JSONEncoder().encode(u)
        do {
            try data?.write(to: path)
        }
        catch {
            print("Failure to write usp data")
        }
    }
    
    func read() -> [USP] {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: path)
            do {
                return try jsonDecoder.decode([USP].self, from: data)
            } catch {
                return []
            }
        } catch {
            return []
        }
    }
    
    func getUSP(id: Int) -> USP {
        let usp = USP(id: id, isRead: false, isSaved: false) // Dummy for finding
        let data = read()
        if let index = data.index(of: usp) {
            return data[index]
        }
        return usp
    }
}

struct USP: Codable {
    var id: Int
    var isRead: Bool
    var isSaved: Bool
}

extension USP: Comparable {
    static func <(lhs: USP, rhs: USP) -> Bool {
        return lhs.id < rhs.id
    }
    
    static func ==(lhs: USP, rhs: USP) -> Bool {
        return lhs.id == rhs.id
    }
}
