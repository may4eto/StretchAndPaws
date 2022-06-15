//
//  YogaTimer.swift
//  Stretch+Paws
//
//  Created by Maya Mircheva on 15/06/2022.
//

import Foundation
import AVFoundation

// What kind of data type should this be? A class or a struct?
// Where does the timer need to be shared?
class YogaTimer: ObservableObject {
  
  // Timer states
  @Published var timerActive = false
  @Published var timerPaused = false
  @Published var timerEnded = false
  @Published var timerDuration = 30
  var yogaTimer = Timer()
  var audioPlayer: AVAudioPlayer?
  
  // Timer functionality
  
  // Start the timer
  
  func startTimer() {
    timerActive = true
    timerPaused = false
    timerEnded = false
    yogaTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { Timer in
      // Remove a second from the timer duration & loop over
      self.timerDuration -= 1
      // If the timer gets to 0, stop the timer
      if self.timerDuration == 0 {
        self.stopTimer()
      }
    })
    
  }
  
  // Pause the timer
  
  func pauseTimer() {
    timerActive = false
    timerPaused = true
    yogaTimer.invalidate()
  }
  
  // End the timer
  func stopTimer() {
    playSound(sound: "chime", type: "wav")
    timerEnded = true
    timerActive = false
    yogaTimer.invalidate()
    timerDuration = 30
  }
  
  // Play a sound
  func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
      do {
        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        audioPlayer?.play()
      } catch {
        print("ERROR")
      }
    }
  }
  
  // Timer styles
  
  func setTitleText() -> String {
    if timerEnded {
      return "You did it!"
    } else {
      return "Hold the pose"
    }
  }
  
  func setDescriptionText() -> String {
    if timerEnded {
      return "Purrrfect!"
    } else {
      return "Try staying in this pose for 30 seconds. If you need to come out sooner, that's ok."
    }
  }
}
