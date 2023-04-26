//
//  PlayerView.swift
//  BasicAVPlayer
//
//  Created by Kautilya Save on 4/25/23.
//

import UIKit
import AVFoundation
import Combine
public class PlayerView: UIView {
    
    private var player: AVPlayer?
    private var anyCancellables = Set<AnyCancellable>()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public convenience init(frame: CGRect, url: String) {
        self.init(frame: frame)
        setupPlayerView(url: url)
    }
    private func setupPlayerView(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        player = AVPlayer(url: url)
        
        let playerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.frame
        
        player?.play()
        
    }
    public func printCurrentVideoPlayheadPosition(timeValue: Int64 = 1, timeScale: Int32 = 2) {

        let interval = CMTime(value: timeValue, timescale: timeScale)
        player?.addPeriodicTimeObserver(forInterval: interval,
                                        queue: DispatchQueue.main,
                                        using: { (progressTime) in
            let seconds = CMTimeGetSeconds(progressTime)
            let formattedSeconds = String(format: "%.2f", seconds)
                print("\nSeconds: \(formattedSeconds)")
        })
    }
    public func subscribeToCurrentVideoStatus() {
        
        player?
            .publisher(for: \.timeControlStatus)
            .sink(receiveValue: { status in
                if case .playing = status {
                    print("Playing")
                }
                if case .paused = status {
                    print("Paused")
                }
            })
            .store(in: &anyCancellables)
    }
    
}
