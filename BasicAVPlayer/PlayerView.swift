//
//  PlayerView.swift
//  BasicAVPlayer
//
//  Created by Kautilya Save on 4/25/23.
//

import UIKit
import AVFoundation
import Combine


/**
 Creates an UIView which will display AVPlayer with default videoURL resource provided while initialization

 ```text
 Parameter frame: CGRect Pass your UI frame parameters.
 Parameter url: Pass the URL string and it will safely unwrap or print out error in console.
 ```
 
 - Warning: If the url provided in initializer is valid. PlayerView will automatically play the video on start.
 
```swift
 var playerView: PlayerView?
 playerView = PlayerView(frame: view.bounds, url: "www.something.com")
 view.addSubview(playerView)
```
*/
public class PlayerView: UIView {
    
    // MARK: - Internal variables
    private var player: AVPlayer?
    private var anyCancellables = Set<AnyCancellable>()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private init() { fatalError("Please use PlayerView(frame: CGRect, url: String) initializer") }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(frame: CGRect, url: String) {
        self.init(frame: frame)
        setupPlayerView(url: url)
    }

    private func setupPlayerView(url: String) {
        print("[LOG] URL Passed: \(url)")
        guard let url = URL(string: url) else {
            print("Error parsing URL!. Please provide an appropriate URL to the initializer.")
            // We can handle throw URLError(.badURL)
            return
        }
        player = AVPlayer(url: url)
        
        let playerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.frame
        
        player?.play()
        
    }
    
    
    // MARK: - Public functions
    
    /**
     Tracks video player progress every seconds passed in the function.

     - Parameter timeValue: TimeValue at which the interval with execute the function. Defaults: 1
     - Parameter timeScale: Amount of time scaling to be applied. Defaults: 2
     - Returns: Console prints every time interval defined in parameters.
     - Warning: This is only available for `Decodable` but anyone who conforms to `Codable` should be fine.
     
    ```swift
     var playerView: PlayerView?
     playerView = PlayerView(frame: videoPlayerFrame, url: "www.something.com")
     playerView?.printCurrentVideoPlayheadPosition()
    ```
    */
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
    
    /**
     Prints video player playback status whenever it is in `.playing` or `.paused` state of type `AVPlayer.TimeControlStatus`
     
     

     - Returns: Console prints every time playback status changes.
     
    ```swift
     var playerView: PlayerView?
     playerView = PlayerView(frame: videoPlayerFrame, url: "www.something.com")
     playerView?.subscribeToCurrentVideoStatus()
    ```
    */
    ///
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
