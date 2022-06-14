//
//  YogaTimer.swift
//  Stretch+Paws
//
//  Created by Maya Mircheva on 15/06/2022.
//

import Foundation

class YogaTimer {
    var timerActive = false
    var timerPaused = false
    var timerEnded = false
    var timerDuration = 30
    var yogaTimer = Timer()
    
    func startTimer() {
        timerActive = true;do {
            yogaTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { Timer in
                self.timerDuration -= 1
            })
            if self.timerDuration == 0 {
                stopTimer()
            }
    }
    
    func pauseTimer() {
        timerActive = false
        timerPaused = true
        yogaTimer.invalidate()
    }
    
    func stopTimer() {
        timerEnded = true
        timerActive = false
        yogaTimer.invalidate()
        timerDuration = 30
    }
    
    func playSound() {
        
    }
    }}
