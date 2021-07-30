//
//  Score.swift
//  Score
//
//  Created by 張又壬 on 2021/7/28.
//

import Foundation

struct Person {
    var name: String
    var game: Int
    var score: Int
    mutating func clear() {
        game = 0
        score = 0
    }
    mutating func changeName(name: String) {
        self.name = name
    }
}

struct Score {
    var person_A: Person
    var person_B: Person
    var isLeftA: Bool
    var isServeA: Bool
    var serveCount: Int
    
    mutating func clear() {
        person_A.clear()
        person_B.clear()
        isLeftA = true
        isServeA = true
        serveCount = 0
    }
    mutating func changeName(nameA: String, nameB: String) {
        person_A.changeName(name: nameA)
        person_B.changeName(name: nameB)
    }
}
