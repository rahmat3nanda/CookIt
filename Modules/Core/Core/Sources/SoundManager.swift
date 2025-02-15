//
//  SoundManager.swift
//  Core
//
//  Created by Rahmat Trinanda Pramudya Amar on 14/02/25.
//

import AVFoundation
import Shared

enum SFXType: String {
    case box = "SfxBox"
    case sparkle = "SfxSparkle"
}

class SoundManager {
    private static var _instance: SoundManager?
    private static let lock = NSLock()
    
    private var bgmPlayer: AVAudioPlayer?
    private var sfxPlayer: AVAudioPlayer?
    
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
        guard let url = "bgm".url else { return }
        
        do {
            bgmPlayer = try AVAudioPlayer(contentsOf: url)
            bgmPlayer?.numberOfLoops = -1
            bgmPlayer?.prepareToPlay()
            completion()
        } catch {
            printIfDebug("Error loading bgm: \(error)")
        }
    }
    
    func playBgm() {
        bgmPlayer?.play()
    }
    
    func playSfx(type: SFXType) {
        guard let url = type.rawValue.url else { return }
        
        do {
            sfxPlayer = try AVAudioPlayer(contentsOf: url)
            sfxPlayer?.numberOfLoops = 0
            sfxPlayer?.prepareToPlay()
            sfxPlayer?.play()
        } catch {
            printIfDebug("Error loading sfx: \(error)")
        }
    }
}

fileprivate extension String {
    var url: URL? {
        guard let path = Bundle.main.path(forResource: self, ofType: "mp3") else {
            printIfDebug("File not found")
            return nil
        }
        
        return URL(fileURLWithPath: path)
    }
}
