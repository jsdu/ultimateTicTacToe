//
//  mainViewController.swift
//  uTicTacToe
//
//  Created by Jason Du on 2015-01-30.
//  Copyright (c) 2015 Jason Du. All rights reserved.
//

import UIKit
var gameMode = 1

class mainViewController: UIViewController {
    
    @IBOutlet var backToMenuButton: UIButton!
    
    @IBOutlet var onePlayerButton: UIButton!
    
    @IBOutlet var twoPlayerButton: UIButton!
    
    @IBAction func onePlayer(sender: AnyObject) {
        gameMode = 2
    }

    @IBAction func twoPlayer(sender: AnyObject) {
        gameMode = 1
    }
    @IBOutlet var instructionText: UITextView!
    
    @IBAction func instructionPressed(sender: AnyObject) {
        instructionText.hidden = false
        backToMenuButton.hidden = false
        onePlayerButton.hidden = true
        twoPlayerButton.hidden = true
    }
    
    @IBAction func backToMenuPressed(sender: AnyObject) {
        onePlayerButton.hidden = false
        twoPlayerButton.hidden = false
        instructionText.hidden = true
        backToMenuButton.hidden = true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
}