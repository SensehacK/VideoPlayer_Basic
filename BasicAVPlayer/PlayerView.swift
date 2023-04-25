//
//  PlayerView.swift
//  BasicAVPlayer
//
//  Created by Kautilya Save on 4/25/23.
//

import UIKit
import AVFoundation
public class PlayerView: UIView {
    
    private var player: AVPlayer?
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
}
