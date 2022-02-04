//
//  Config.swift
//  MarvelHeroApp
//
//  Created by Altay Kırlı on 3.02.2022.
//

import Foundation
import CryptoSwift
import UIKit


struct App {
    static var serviceurl = "https://gateway.marvel.com/v1/public/"
    static var privatekey = "dcc1e5345995b05e6e95f2a893bf8e2f4515f86b"
    static var publickey = "f1042e09ed7e3c30df9e606e110b5a62"
    static var hash = "\(ts)\(privatekey)\(publickey)".md5()
    static var ts = "\(Int((Date().timeIntervalSince1970 * 1000.0).rounded()))"
}


