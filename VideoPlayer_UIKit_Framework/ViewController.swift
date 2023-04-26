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
    static let bunnyVideoURL = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
    static let hboChromecastURL = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"
}

