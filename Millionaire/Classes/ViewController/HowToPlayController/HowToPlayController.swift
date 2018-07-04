//
//  HowToPlayController.swift
//  AiLaTrieuPhu
//
//  Created by hieunguyen on 7/8/14.
//  Copyright (c) 2014 FRUITYSOLUTION. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import AVFoundation
import iAd
class HowToPlayController: UIViewController, ADBannerViewDelegate {
    
    
    @IBOutlet var adBannerView: ADBannerView?
    var audioPlayer = AVAudioPlayer()
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    required override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false);
        // Do any additional setup after loading the view, typically from a nib.
        
        playBackground()
        
        
        
        self.canDisplayBannerAds = true
        self.adBannerView?.delegate = self
        self.adBannerView?.alpha = 0.0 //hide until ad loaded
    }
    
    @IBOutlet var guide1 : UILabel?
    
    @IBOutlet var guide2 : UILabel?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func backToMenuBtnPressed(_ sender : AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func playBackground(){
        let bgAudio = URL(fileURLWithPath: Bundle.main.path(forResource: "luatchoi", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: bgAudio)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    func setFont()->Void{
        guide1?.font = UIFont(name: "Helvetica", size: 15)
        guide2?.font = UIFont(name: "Helvetica", size: 15)
        
    }

    func bannerViewWillLoadAd(_ banner: ADBannerView!) {
        //self.adBannerView.alpha = 0.0
        //banner.alpha = 0.0
    }
    
    func bannerViewDidLoadAd(_ banner: ADBannerView!) {
        NSLog("bannerViewDidLoadAd")
        self.adBannerView?.alpha = 1.0 //now show banner as ad is loaded
        //banner.alpha = 1.0
    }
    
    func bannerViewActionDidFinish(_ banner: ADBannerView!) {
        NSLog("bannerViewDidLoadAd")
    }
    
    func bannerViewActionShouldBegin(_ banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        NSLog("bannerViewActionShouldBegin")
        return willLeave //I do not know if that is the correct return statement
    }
    
    func bannerView(_ banner: ADBannerView!, didFailToReceiveAdWithError error: Error!) {
        NSLog("bannerView error: \(error)")
    }
    
    //... your class implementation code
    
}
