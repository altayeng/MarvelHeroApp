//
//  Favorites.swift
//  MarvelHeroApp
//
//  Created by Altay Kırlı on 3.02.2022.
//

import Foundation
import RealmSwift

class Favorite: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var thumbnail = ""
    @objc dynamic var detail = ""
}
