//
//  self.swift
//  AiLaTrieuPhu
//
//  Created by hieunguyen on 7/6/14.
//  Copyright (c) 2014 FRUITYSOLUTION. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import AVFoundation


class GamePlayViewController: UIViewController {
    
    
    
    let url = "http://fruitysolution.vn:8020/Millionaire/ailatrieuphu.txt"
    var audioPlayer = AVAudioPlayer()

    var questionArray:NSMutableArray = NSMutableArray()
    var answerArray:NSMutableArray = NSMutableArray()
    
    var question: Question = Question()
    var answer: Answer = Answer()
    var correctAnswer = 1
    var choseAnswer = 0
    var times = 0
    var canSelected = 1
    var level: Int
    
    
    var canFifty: Bool
    var canCall: Bool
    var canChange: Bool
    var canViewer: Bool
    var isCalled = 0
    
    var callTime: Int
    var timer = Timer()
    
    var callTimer = Timer()

    @IBOutlet var answerALbl : UILabel?

    
    @IBOutlet var answerBLbl : UILabel?
    
    @IBOutlet var answerCLbl : UILabel?
    
    
    @IBOutlet var answerDLbl : UILabel?
    
    
    @IBOutlet var imageLevel : UIButton?
    
    @IBOutlet var answerABtn : UIButton?
    
    @IBOutlet var answerBBtn : UIButton?
    
    @IBOutlet var answerCBtn : UIButton?
    
    @IBOutlet var answerDBtn : UIButton?
    
    @IBOutlet var selectBtn : UIButton?
    
    @IBOutlet var questionLbl : UILabel?
    
    @IBOutlet var fiftyBtn : UIButton?
    
    
    @IBOutlet var changeBtn : UIButton?
    
    
    @IBOutlet var viewerBtn : UIButton?
    
    
    @IBOutlet var viewer1 : UIButton?
    
    
    @IBOutlet var viewer2 : UIButton?
    
    
    @IBOutlet var viewer3 : UIButton?
    
    @IBOutlet var questionBg : UIImageView?
    

    
    required init(coder aDecoder: NSCoder)
    {
        level = 1
        canFifty = false
        canCall = false
        canChange = false
        canViewer = false
        callTime = 0
        super.init(coder: aDecoder)!

    }
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        level = 1
        canFifty = false
        canCall = false
        canChange = false
        canViewer = false
        callTime = 0
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false);
        
        self.levelAudio()

        loadQuestion()
        
        setButtonCanSlect()
        
        let levelImg : UIImage = UIImage(named:"cau\(level).png")!
        
        imageLevel?.setBackgroundImage(levelImg, for: UIControlState())
        
        setFont()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    @IBAction func onAnserASelected(_ sender : AnyObject) {
        if canSelected == 0{
            return
        }
        self.selectedItem(answerABtn!);
        choseAnswer=1
    }
    @IBAction func onAnserBSelected(_ sender : AnyObject) {
        if canSelected == 0{
            return
        }
        self.selectedItem(answerBBtn!);
        choseAnswer=2
    }
    @IBAction func onAnserCSelected(_ sender : AnyObject) {
        if canSelected == 0{
            return
        }
        self.selectedItem(answerCBtn!);
        choseAnswer=3
    }
    @IBAction func onAnserDSelected(_ sender : AnyObject) {
        if canSelected == 0{
            return
        }
        self.selectedItem(answerDBtn!);
        choseAnswer=4
    }
    
    @IBAction func onSelectbtnSelected(_ sender : AnyObject) {
        

        if (canSelected != 0) && (choseAnswer != 0) {
            canSelected = 0
            var op = "ans_"
            switch(choseAnswer){
                case 1: op = "ans_a"
                case 2: op = "ans_b"
                case 3: op = "ans_c"
                case 4: op = "ans_d"
                default: op = "ans_a"
            }
            let bgAudio = URL(fileURLWithPath: Bundle.main.path(forResource: op, ofType: "mp3")!)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: bgAudio)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                // couldn't load file :(
            }
        
            Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.lastOption), userInfo: nil, repeats: false)
        }
    }
    
    
    
    
    @IBAction func onFiftyHelpSelected(_ sender : AnyObject) {
        if canFifty == true{

        
            canFifty = false
        
            let bgImg = UIImage(named: "fifty_end.png");
            fiftyBtn?.setBackgroundImage(bgImg, for: UIControlState())
        
            let bgAudio = URL(fileURLWithPath: Bundle.main.path(forResource: "sound5050", ofType: "mp3")!)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: bgAudio)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                // couldn't load file :(
            }
        
             Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.fiftyFiftyAction), userInfo: nil, repeats: false)
        }
    }
    
    

    
    func showCallView()->Void{
        callTime = 20
        callTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countTime), userInfo: nil, repeats: true)
    }
    
    @IBAction func showCallAnswer(_ sender : AnyObject) {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.showAnswer), userInfo: nil, repeats: false)
    }
    
    func showAnswer()->Void{

//        let bgAudio = URL(fileURLWithPath: Bundle.main.path(forResource: "s5050", ofType: "mp3")!)
//        
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: bgAudio)
//            audioPlayer.prepareToPlay()
//            audioPlayer.play()
//        } catch {
//            // couldn't load file :(
//        }
//        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.playBackgroundAudio), userInfo: nil, repeats: false)
//        var ans = Int(arc4random_uniform(100))
//        if ans>30{
//            caller?.setTitle(answer.isTrue.uppercased, for: UIControlState())
//        }
//        else{
//            ans = Int(arc4random_uniform(4))
//            switch(ans){
//            case 0: caller?.setTitle("A", for: UIControlState())
//            case 1: caller?.setTitle("B", for: UIControlState())
//            case 2: caller?.setTitle("C", for: UIControlState())
//            case 3: caller?.setTitle("D", for: UIControlState())
//            default: caller?.setTitle("D", for: UIControlState())
//            }
//        }

    }
    
    func hideCallView() {
//        callView?.isHidden = true
    }
    
    
    
    @IBAction func onChangeHelpSelected(_ sender : AnyObject) {
        if canChange == true{
            canChange = false
            let bgImg = UIImage(named: "change_end.png");
            changeBtn?.setBackgroundImage(bgImg, for: UIControlState())
            let curLevel = self.question.id
            while curLevel == self.question.id{
                loadQuestion()
            }
            setAllButtonToDefault()
        }
        
        
    }
    
    
    @IBAction func onViewerHelpSelected(_ sender : AnyObject) {
        if canViewer == true{
            canViewer = false
            let bgImg = UIImage(named: "khangia_end.png");
            viewerBtn?.setBackgroundImage(bgImg, for: UIControlState())
            
            let bgAudio = URL(fileURLWithPath: Bundle.main.path(forResource: "khan_gia", ofType: "mp3")!)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: bgAudio)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                // couldn't load file :(
            }
            
            
            Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(self.viewer1Help), userInfo: nil, repeats: false)
        }
        
    }
    
// Mark: -get Json
    
    
    func loadQuestion(){
        
//        var json = parseJson(getJSONFromServer())
//        
//        var error: NSError?
//        var jsonQuestionArray = json["question"] as! NSArray
//        
//        for details:AnyObject in jsonQuestionArray {
//            var q : Question = parseQuestionDetail(details as! NSDictionary) as Question
//            var levelString = "\(level)"
//            if q.level == levelString{
//                questionArray.add(q)
//            }
//            
//        }
//        
//        var k = Int(arc4random_uniform(UInt32(questionArray.count)))
//        
//        question = questionArray.object(at: k) as! Question
//
//        questionLbl?.text = question.content as String
//        if question.audio.length > 0{
//            
//            
//            
//            
//        }
//        var jsonAnswerArray = json["answer"] as! NSArray
//        for details:AnyObject in jsonAnswerArray{
//            parseAnswerDetail(details as! NSDictionary)
//            
//        }
//        
//        answerALbl?.text = "A. \(answer.answerA)"
//        answerBLbl?.text = "B. \(answer.answerB)"
//        answerCLbl?.text = "C. \(answer.answerC)"
//        answerDLbl?.text = "D. \(answer.answerD)"
//        
//        switch(answer.isTrue){
//        case "a": correctAnswer = 1
//        case "b": correctAnswer = 2
//        case "c": correctAnswer = 3
//        case "d": correctAnswer = 4
//        default: correctAnswer = 0
//        }
    }
    
    func playAudioOnline(_ urlAudio: NSString)->Void{
        let bgAudio = URL(string: urlAudio as String)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: bgAudio!)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            // couldn't load file :(
        }
    }
    

    
    
    func setButtonCanSlect()->Void{
        var bgImg = UIImage(named: "fifty.png");
        if canFifty == false{
            bgImg = UIImage(named: "fifty_end.png");
        }
        fiftyBtn?.setBackgroundImage(bgImg, for: UIControlState())
        

        var bgImg3 = UIImage(named: "change.png");
        if canChange == false{
            bgImg3 = UIImage(named: "change_end.png");
        }
        changeBtn?.setBackgroundImage(bgImg3, for: UIControlState())
        
        var bgImg4 = UIImage(named: "khangia.png");
        if canViewer == false{
            bgImg4 = UIImage(named: "khangia_end.png");
        }
        viewerBtn?.setBackgroundImage(bgImg4, for: UIControlState())
        
    }
    
    func lastOption()->Void{
        canSelected=0;
        if choseAnswer == correctAnswer {
            print("cau tra loi chinh xac")
            var op = "true_"
            switch(choseAnswer){
            case 1: op = op+"a"
            case 2: op = op+"b"
            case 3: op = op+"c"
            case 4: op = op+"d"
            default: op = op+"a"
            }

            let bgAudio = URL(fileURLWithPath: Bundle.main.path(forResource: op, ofType: "mp3")!)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: bgAudio)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                // couldn't load file :(
            }
            Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.nextLevel), userInfo: nil, repeats: false)
        }
        else{
            print("cau tra loi khong chinh xac")
            var op = "lose_"
            switch(correctAnswer){
            case 1: op = op+"a"
            case 2: op = op+"b"
            case 3: op = op+"c"
            case 4: op = op+"d"
            default: op = op+"a"
            }
            
            let bgAudio = URL(fileURLWithPath: Bundle.main.path(forResource: op, ofType: "mp3")!)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: bgAudio)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                // couldn't load file :(
            }

             Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.goodluck), userInfo: nil, repeats: false)
        }
        
        times = 0;
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.rightAnswer), userInfo: nil, repeats: true)
    }
    
    func levelAudio()->Void{
        let q1 = URL(fileURLWithPath: Bundle.main.path(forResource: "ques\(level)", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: q1)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            // couldn't load file :(
        }
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.playBackgroundAudio), userInfo: nil, repeats: false)
    }
    
    
    func playBackgroundAudio()->Void{
        let moc = Int((level-1)/5)+1;
        let q1 = URL(fileURLWithPath: Bundle.main.path(forResource: "moc\(moc)", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: q1)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            // couldn't load file :(
        }
        audioPlayer.numberOfLoops = -1
    }
    
    
    func selectedItem(_ btn:UIButton)->Void{
        self.setAllButtonToDefault()
        let bgImg = UIImage(named: "case_correct.png");
        btn.setBackgroundImage(bgImg, for: UIControlState())
        btn.titleLabel?.textColor = UIColor.blue
    }
    
    
    func setAllButtonToDefault() ->Void{
        let bgImg = UIImage(named: "case3.png");
        answerABtn?.setBackgroundImage(bgImg, for: UIControlState())
        answerBBtn?.setBackgroundImage(bgImg, for: UIControlState())
        answerCBtn?.setBackgroundImage(bgImg, for: UIControlState())
        answerDBtn?.setBackgroundImage(bgImg, for: UIControlState())

    }
    
    
    
    
    
    
    func rightAnswer()->Void{
        
        var bgImg = UIImage(named: "case_correct.png");
        switch(times%2){
            case 0:bgImg = UIImage(named: "case3.png");
            case 1:bgImg = UIImage(named: "case_correct.png");
            default:bgImg = UIImage(named: "case_correct.png");
            
        }
        times += 1
        if times == 21{
            timer.invalidate()
            if choseAnswer == correctAnswer{
                bgImg = UIImage(named: "case_correct.png");
            }
            else{
                bgImg = UIImage(named: "case_wrong.png");
            }
        }
        animation(bgImg!)
    }
    
    
    
    
    func animation(_ bgImg:UIImage)->Void{
        switch(answer.isTrue){
        case "a": answerABtn?.setBackgroundImage(bgImg, for: UIControlState())
        case "b": answerBBtn?.setBackgroundImage(bgImg, for: UIControlState())
        case "c": answerCBtn?.setBackgroundImage(bgImg, for: UIControlState())
        case "d": answerDBtn?.setBackgroundImage(bgImg, for: UIControlState())
        default: answerDBtn?.setBackgroundImage(bgImg, for: UIControlState())
        }
    }
    

    
    
    
    
    
    
    
    func fiftyFiftyAction()->Void{
        
        let bgAudio = URL(fileURLWithPath: Bundle.main.path(forResource: "s5050", ofType: "mp3")!)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.playBackgroundAudio), userInfo: nil, repeats: false)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: bgAudio)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            // couldn't load file :(
        }
        
        
        
        answerALbl?.text = ""
        answerBLbl?.text = ""
        answerCLbl?.text = ""
        answerDLbl?.text = ""

        setAllButtonToDefault()
        
        var fiftyfifty = Int(arc4random_uniform(3)+1)
        
        while fiftyfifty == correctAnswer{
            fiftyfifty = (fiftyfifty + 1)%4
        }
        switch(correctAnswer){
            case 1: answerALbl?.text = "A. \(answer.answerA)"
            case 2: answerBLbl?.text = "B. \(answer.answerB)"
            case 3: answerCLbl?.text = "C. \(answer.answerC)"
            case 4: answerDLbl?.text = "D. \(answer.answerD)"
            default: answerALbl?.text = "A. \(answer.answerA)"
        }
        switch(fiftyfifty){
            case 1: answerALbl?.text = "A. \(answer.answerA)"
            case 2: answerBLbl?.text = "B. \(answer.answerB)"
            case 3: answerCLbl?.text = "C. \(answer.answerC)"
            case 4: answerDLbl?.text = "D. \(answer.answerD)"
            default: answerALbl?.text = "A. \(answer.answerA)"
        }
        
    }

    
    
    
    func viewer1Help()->Void{
        
        let bgAudio = URL(fileURLWithPath: Bundle.main.path(forResource: "s5050", ofType: "mp3")!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: bgAudio)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            // couldn't load file :(
        }
        
        var ans = Int(arc4random_uniform(100))
        if ans>30{
            viewer1?.setTitle(answer.isTrue.uppercased, for: UIControlState())
        }
        else{
            ans = Int(arc4random_uniform(4))
            switch(ans){
            case 0: viewer1?.setTitle("A", for: UIControlState())
            case 1: viewer1?.setTitle("B", for: UIControlState())
            case 2: viewer1?.setTitle("C", for: UIControlState())
            case 3: viewer1?.setTitle("D", for: UIControlState())
            default: viewer1?.setTitle("D", for: UIControlState())
            }
        }
        viewer1?.isHidden = false
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.viewer2Help), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.playBackgroundAudio), userInfo: nil, repeats: false)
    }
    
    
    
    func viewer2Help()->Void{
        
        let bgAudio = URL(fileURLWithPath: Bundle.main.path(forResource: "s5050", ofType: "mp3")!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: bgAudio)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            // couldn't load file :(
        }
        
        var ans = Int(arc4random_uniform(100))
        if ans>30{
            viewer2?.setTitle(answer.isTrue.uppercased, for: UIControlState())
        }
        else{
            ans = Int(arc4random_uniform(4))
            switch(ans){
            case 0: viewer2?.setTitle("A", for: UIControlState())
            case 1: viewer2?.setTitle("B", for: UIControlState())
            case 2: viewer2?.setTitle("C", for: UIControlState())
            case 3: viewer2?.setTitle("D", for: UIControlState())
            default: viewer2?.setTitle("D", for: UIControlState())
            }
        }
        viewer2?.isHidden = false
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.viewer3Help), userInfo: nil, repeats: false)
    }
    
    
    
    func viewer3Help()->Void{
        
        let bgAudio = URL(fileURLWithPath: Bundle.main.path(forResource: "s5050", ofType: "mp3")!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: bgAudio)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            // couldn't load file :(
        }
        
        var ans = Int(arc4random_uniform(100))
        if ans>30{
            viewer3?.setTitle(answer.isTrue.uppercased, for: UIControlState())
        }
        else{
            ans = Int(arc4random_uniform(4))
            switch(ans){
            case 0: viewer3?.setTitle("A", for: UIControlState())
            case 1: viewer3?.setTitle("B", for: UIControlState())
            case 2: viewer3?.setTitle("C", for: UIControlState())
            case 3: viewer3?.setTitle("D", for: UIControlState())
            default: viewer3?.setTitle("D", for: UIControlState())
            }
        }
        viewer3?.isHidden = false
    }
    
    
    
    
    

    
    
    func nextLevel()->Void{
        if level<15{
            var gamePlay: GamePlayViewController
            gamePlay = GamePlayViewController(nibName: "GamePlayView", bundle: nil)
            
            gamePlay.level = self.level+1
            
            gamePlay.canFifty = self.canFifty
            gamePlay.canCall = self.canCall
            gamePlay.canChange = self.canChange
            gamePlay.canViewer = self.canViewer
            
            self.navigationController?.pushViewController(gamePlay, animated: true)
        }
        else{
            let q1 = URL(fileURLWithPath: Bundle.main.path(forResource: "best_player", ofType: "mp3")!)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: q1)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                // couldn't load file :(
            }
        }
    }
    
    
    func goodluck()->Void{
        let q1 = URL(fileURLWithPath: Bundle.main.path(forResource: "lose", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: q1)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            // couldn't load file :(
        }
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.backToMenu), userInfo: nil, repeats: false)
    }
    
    
    func backToMenu()->Void{
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    func setFont()->Void{
        questionLbl?.font = UIFont(name: "Helvetica", size: 13)
        answerALbl?.font = UIFont(name: "Helvetica", size: 11)
        answerBLbl?.font = UIFont(name: "Helvetica", size: 11)
        answerCLbl?.font = UIFont(name: "Helvetica", size: 11)
        answerDLbl?.font = UIFont(name: "Helvetica", size: 11)
        selectBtn?.titleLabel?.font = UIFont(name: "Helvetica", size: 11)
    }
    
    
    
    
    func countTime()->Void{
        
        callTime -= 1;
        print(callTime)

        if callTime == 0 {
            callTimer.invalidate()
            hideCallView()
        }
    }
    
}
