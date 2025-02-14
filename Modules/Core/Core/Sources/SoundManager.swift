//
//  SoundManager.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 14/02/25.
//

import AVFoundation
import Shared

class SoundManager {
    private static var _instance: SoundManager?
    private static let lock = NSLock()
    
    private var bgmPlayer: AVAudioPlayer?
    
    private init(){}
    
    static var instance: SoundManager {
        if _instance == nil {
            lock.lock()
            defer {
                lock.unlock()
            }
            if _instance == nil {
                _instance = SoundManager()
            }
        }
        return _instance!
    }
    
    func initialize(completion: () -> Void) {
        guard let path = Bundle.main.path(forResource: "bgm", ofType: "mp3") else {
            printIfDebug("MP3 file not found")
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            bgmPlayer = try AVAudioPlayer(contentsOf: url)
            bgmPlayer?.numberOfLoops = -1
            bgmPlayer?.prepareToPlay()
            completion()
        } catch {
            printIfDebug("Error loading music: \(error)")
        }
    }
    
    func playBgm() {
        bgmPlayer?.play()
    }
}

