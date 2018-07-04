    //
//  HomeViewController.swift
//  AiLaTrieuPhu
//
//  Created by hieunguyen on 6/30/14.
//  Copyright (c) 2014 FRUITYSOLUTION. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import AVFoundation
import iAd







class HomeViewController :UIViewController, ADBannerViewDelegate {

    
    @IBOutlet var adBannerView: ADBannerView?
    
    
    var audioPlayer = AVAudioPlayer()
    var question: Question = Question()
    var selected = 0
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false);
        // Do any additional setup after loading the view, typically from a nib.
        
        setFont()
        
        self.playBackgroundAudio()
        
        self.canDisplayBannerAds = true
        self.adBannerView?.delegate = self
        self.adBannerView?.alpha = 0.0 //hide until ad loaded

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func playBackgroundAudio()->Void{
        let bgAudio = URL(fileURLWithPath: Bundle.main.path(forResource: "start", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: bgAudio)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            // couldn't load file :(
        }
    }
    @IBOutlet var startBtn : UIButton?
    @IBOutlet var hightScoreBtn : UIButton?
    @IBOutlet var howtoPlayBtn : UIButton?
    

    @IBAction func onStartBtnPressed(_ sender : AnyObject) {
        if selected == 0{
            audioPlayer.pause()
            selected=1
            Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.start), userInfo: nil, repeats: false)
            let bgAudio = URL(fileURLWithPath: Bundle.main.path(forResource: "gofind", ofType: "mp3")!)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: bgAudio)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                // couldn't load file :(
            }
        }
    }
    
    
    @IBAction func onHightScoreBtnPressed(_ sender : AnyObject) {
        if selected == 0{
            UIApplication.shared.openURL(URL(string: "http://projectemplate.com")!)
        }
        
    }
    
    @IBAction func onHowtoPlayBtnPressed(_ sender : AnyObject) {
        if selected == 0{

            var gamePlay: HowToPlayController
            gamePlay = HowToPlayController(nibName: "HowToPlayView", bundle: nil)
            audioPlayer.pause()
            self.navigationController?.pushViewController(gamePlay, animated: true)
        }
    }
    func start()->Void{
        selected=0
        var gamePlay: GamePlayViewController
        gamePlay = GamePlayViewController(nibName: "GamePlayView", bundle: nil)
        gamePlay.level=1
        gamePlay.canFifty = true
        gamePlay.canCall = true
        gamePlay.canChange = true
        gamePlay.canViewer = true
        self.navigationController?.pushViewController(gamePlay, animated: true)
    }
    
    
    
    func setFont()->Void{
        startBtn?.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        howtoPlayBtn?.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        hightScoreBtn?.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
    }
    
    

    
    
    func bannerViewWillLoadAd(_ banner: ADBannerView!) {
        //self.adBannerView.alpha = 0.0
        //banner.alpha = 0.0
    }
    
    func bannerViewDidLoadAd(_ banner: ADBannerView!) {

        self.adBannerView?.alpha = 1.0 //now show banner as ad is loaded
        //banner.alpha = 1.0
    }
    
    func bannerViewActionDidFinish(_ banner: ADBannerView!) {

    }
    
    func bannerViewActionShouldBegin(_ banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {

        return willLeave //I do not know if that is the correct return statement
    }
    
    func bannerView(_ banner: ADBannerView!, didFailToReceiveAdWithError error: Error!) {

    }
    
    //... your class implementation code
    
    }
