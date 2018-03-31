//
//  LocalDataManagerUSP.swift
//  HackerMash
//
//  Created by Manish Singh on 3/22/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
///USP - User story preference

class LocalDataManagerFavorites {
    let path = DiskPath.userStoryPref.filepath()
    
    func save(favorite: Favorite) {
        let u = read()
        if let index = u.favorites.index(of: favorite) {
            u.favorites.remove(at: index)
        }
        u.date = Date()
        u.favorites.append(favorite)
        let data = try? JSONEncoder().encode(u)
        do {
            try data?.write(to: path)
        }
        catch {
            print("Failure to write usp data")
        }
    }
    
    func read() -> FavoritesDiskData {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: path)
            do {
                return try jsonDecoder.decode(FavoritesDiskData.self, from: data)
            } catch {
                return FavoritesDiskData(date: Date(), favorites: [])
            }
        } catch {
            return FavoritesDiskData(date: Date(), favorites: [])
        }
    }
    
    func getFavorite(id: Int) -> Favorite {
        let usp = Favorite(id: id, isRead: false, isSaved: false, date: Date()) // Dummy for finding
        let data = read()
        if let index = data.favorites.index(of: usp) {
            return data.favorites[index]
        }
        return usp
    }
}

class FavoritesDiskData: Codable {
    var date: Date //Date last updated
    var favorites: [Favorite]
    init(date: Date, favorites: [Favorite]) {
        self.date = date
        self.favorites = favorites
    }
}

struct Favorite: Codable {
    var id: Int
    var isRead: Bool
    var isSaved: Bool
    var date: Date //Date last created
}

extension Favorite: Comparable {
    static func <(lhs: Favorite, rhs: Favorite) -> Bool {
        return lhs.id < rhs.id
    }
    
    static func ==(lhs: Favorite, rhs: Favorite) -> Bool {
        return lhs.id == rhs.id
    }
}
