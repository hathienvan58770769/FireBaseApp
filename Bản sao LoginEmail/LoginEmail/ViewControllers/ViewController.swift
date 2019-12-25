//
//  ViewController.swift
//  LoginEmail
//
//  Created by Van on 12/16/19.
//  Copyright © 2019 Van. All rights reserved.
//

import UIKit
import AVKit
class ViewController: UIViewController {
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
    }
    func setUpElements()  {
        Utilities.styleFilledButton(SignUpButton)
        Utilities.styleHollowButton(LoginButton)
        
    }
    func setUpVideo() {
        let bundlePath = Bundle.main.path(forResource: "summertime", ofType: "mp4")
        guard bundlePath != nil else{
            return
        }
        //Create a Url from it
        let url = URL(fileURLWithPath: bundlePath!)
        //Create the video a player item
        let item = AVPlayerItem(url: url)
        //Create the Player
        videoPlayer = AVPlayer(playerItem: item)
        //Create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        //Adjust the size and Frame
        videoPlayerLayer?.frame = CGRect(x: -view.frame.size.width*1.5, y: 0, width: view.frame.size.width*4, height: view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        //Add it to the view and play it
        videoPlayer?.playImmediately(atRate: 1)
    }

}

