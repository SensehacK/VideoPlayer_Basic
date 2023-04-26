//
//  ViewController.swift
//  VideoPlayer_UIKit_Framework
//
//  Created by Kautilya Save on 4/25/23.
//

import UIKit
import AVKit
import BasicAVPlayer

class ViewController: UIViewController {
    var playerView: PlayerView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPlayerView()
        displayPlayTimeStamps()
        displayCurrentVideoStatus()
    }

    func addPlayerView() {
        let containerView = UIView(frame: view.frame)
        containerView.backgroundColor = UIColor.white
        containerView.frame = CGRect(x: view.frame.width - 10, y: view.frame.height - 10, width: 10, height: 10)
        
        let height = view.frame.width * 9 / 16
        let videoPlayerFrame = CGRect(x: 0, y: 40, width: view.frame.width, height: height)
        playerView = PlayerView(frame: videoPlayerFrame, url: Constants.videoURL)
        if let playerView {
            containerView.addSubview(playerView)
        }

        view.addSubview(containerView)
        containerView.frame = view.frame
    }
    
    func displayPlayTimeStamps() {
        print("Current Playback Seconds")
        if let playerView {
            playerView.printCurrentVideoPlayheadPosition()
        }
    }
    
    func displayCurrentVideoStatus() {
        print("Current video status")
        if let playerView {
            playerView.subscribeToCurrentVideoStatus()
        }
    }

}



struct Constants {
    static let videoURL = "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8"
}

