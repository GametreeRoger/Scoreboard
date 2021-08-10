//
//  Settings.swift
//  Settings
//
//  Created by 張又壬 on 2021/7/29.
//

import Foundation

struct Settings {
    var player1: String
    var player2: String
    var theme: Theme
    init(player1: String, player2: String, theme: Theme = .Default) {
        self.player1 = player1
        self.player2 = player2
        self.theme = theme
    }
}

enum Theme: Int, CaseIterable {
    case Default = 0
    case Dark
    case TableTennisTable
    case SpringFestival
    case SoccerField
    
    var getString: String {
        switch self {
        case .Default:
            return "Default"
        case .Dark:
            return "Dark"
        case .TableTennisTable:
            return "TableTennisTable"
        case .SpringFestival:
            return "SpringFestival"
        case .SoccerField:
            return "SoccerField"
        }
    }
    
    var getTitle: String {
        switch self {
        case .Default:
            return "Default"
        case .Dark:
            return "Dark"
        case .TableTennisTable:
            return "Table Tennis Table"
        case .SpringFestival:
            return "Spring Festival"
        case .SoccerField:
            return "Soccer Field"
        }
    }
}
