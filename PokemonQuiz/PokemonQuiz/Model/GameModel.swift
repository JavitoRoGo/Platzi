//
//  GameModel.swift
//  PokemonQuiz
//
//  Created by Javier Rodríguez Gómez on 13/3/23.
//

import Foundation

struct GameModel {
    var score = 0
    
    mutating func checkAnswer(_ userAnswer: String, _ correctAnswer: String) -> Bool {
        if userAnswer.lowercased() == correctAnswer.lowercased() {
            self.score += 1
            return true
        }
        return false
    }
    
    func getScore() -> Int {
        return score
    }
    
    mutating func setScore(socre: Int) {
        self.score = socre
    }
}
