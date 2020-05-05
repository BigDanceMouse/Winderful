//
//  AudioTrickAppSleepSuppressor.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation
import AVFoundation


class AudioTrickAppSleepSuppressor: AppSleepSuppressor {
    
    func preventFromSleep() {
        self.subscribeAndPlay()
    }
    
    func stopSleepSuppression() {
        self.unsubscribeAndStop()
    }
    
    
    // MARK: - Private
    
    private var player: AVAudioPlayer?
    
    private lazy var soundPath = Bundle.main
        .path(forResource: "blank", ofType: "wav")
    
    private var notifictionCenter: NotificationCenter {
        .default
    }
    
    
    // MARK: - Private methods
    
    private func subscribeAndPlay() {
        subscribeToInterruption()
        play()
    }

    private func unsubscribeAndStop() {
        unsubscribeFromInterruption()
        stop()
    }
    
    
    // MARK: - Notification Center
    
    private func subscribeToInterruption() {
        notifictionCenter.addObserver(
            self,
            selector: #selector(audioInterrupted),
            name: AVAudioSession.interruptionNotification,
            object: AVAudioSession.sharedInstance())
    }
    
    private func unsubscribeFromInterruption() {
        notifictionCenter.removeObserver(
            self,
            name: AVAudioSession.interruptionNotification,
            object: nil)
    }
    
    
    // MARK: - AVPlayer
    
    private func play() {
        guard let path = soundPath
            , PrepareAudioSession() else {
            return
        }
        let soundURL = URL(fileURLWithPath: path)
        player = NewPlayer(forURL: soundURL)
        player?.play()
    }
    
    private func stop() {
        player?.stop()
    }
    
    
    // MARK: - Selectors
    
    @objc private func audioInterrupted(_ notification: Notification) {
        guard notification.name == AVAudioSession.interruptionNotification
            , let userInfo = notification.userInfo
            , let interuptionTypeRawValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt
            , let interuptionType = AVAudioSession.InterruptionType(rawValue: interuptionTypeRawValue)
            , interuptionType == .began
            else { return }
        play()
    }
}


// MARK: - Functions

private func NewPlayer(forURL url: URL) -> AVAudioPlayer? {
    let maybePlayer = try? AVAudioPlayer(contentsOf: url)
    maybePlayer?.numberOfLoops = -1
    maybePlayer?.volume = 0.01
    maybePlayer?.prepareToPlay()
    return maybePlayer
}

private func PrepareAudioSession() -> Bool {
    do {
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(.playback, options: [.mixWithOthers])
        try session.setActive(true)
        return true
        
    } catch {
        return false
    }
}
