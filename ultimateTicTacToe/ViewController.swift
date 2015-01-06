//
//  ViewController.swift
//  ultimateTicTacToe
//
//  Created by Jason Du on 2014-12-25.
//  Copyright (c) 2014 Jason Du. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var board0: UIImageView!
    
    @IBOutlet var result: UILabel!
    
    @IBOutlet var playAgainButton: UIButton!
    
    @IBOutlet var background: UIImageView!
    
    @IBOutlet var button0: UIButton!
    
    var winner = 0
    var goNum = 0
    
    // Array of 9 tic tac toe boards
    var gameState = [[0,0,0,0,0,0,0,0,0],
                     [0,0,0,0,0,0,0,0,0],
                     [0,0,0,0,0,0,0,0,0],
                     [0,0,0,0,0,0,0,0,0],
                     [0,0,0,0,0,0,0,0,0],
                     [0,0,0,0,0,0,0,0,0],
                     [0,0,0,0,0,0,0,0,0],
                     [0,0,0,0,0,0,0,0,0],
                     [0,0,0,0,0,0,0,0,0]]
    
    var trueGameState = [0,0,0,0,0,0,0,0,0]
    
    // All the possible winning combinations
    let winningCombinations = [[0,1,2], [3,4,5], [6,7,8],
                              [0,3,6], [1,4,7], [2,5,8],
                              [0,4,8], [2,4,6]]
    
    @IBAction func playAgain(sender: AnyObject) {
        
        result.text = "X Turn"
        
        gameState = [[0,0,0,0,0,0,0,0,0],
                     [0,0,0,0,0,0,0,0,0],
                     [0,0,0,0,0,0,0,0,0],
                     [0,0,0,0,0,0,0,0,0],
                     [0,0,0,0,0,0,0,0,0],
                     [0,0,0,0,0,0,0,0,0],
                     [0,0,0,0,0,0,0,0,0],
                     [0,0,0,0,0,0,0,0,0],
                     [0,0,0,0,0,0,0,0,0]]
        
        trueGameState = [0,0,0,0,0,0,0,0,0]
        
         winner = 0
         goNum = 0
        
        // Hide all buttons
        var hide2 : UIButton
        for var i = 0; i < 9; i++ {
            hide2 = view.viewWithTag(i + 200) as UIButton
            hide2.hidden = true
        }
        
        var normalBoard2 : UIImageView
        
        for var i = 0; i < 9; i++ {
            if trueGameState[i] == 0 {
                normalBoard2 = view.viewWithTag(100 + i) as UIImageView
                normalBoard2.image = UIImage (named: "goBoard")
            }
        }
        
        var button : UIButton
        
        for var j = 0; j < 9; j++ {
            for var i = 0; i < 9; i++ {
            
                button = view.viewWithTag(j * 10 + i) as UIButton
            
                button.setImage(nil, forState: .Normal)
            
            }
        }
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        var image = UIImage()
        
        if (gameState[sender.tag/10][sender.tag%10] == 0) && winner == 0 {
            
            // Places an X or an O depending on whos turn it is
            if (goNum % 2 == 0) {
                
                image = UIImage(named: "x.png")!
                gameState[sender.tag/10][sender.tag%10] = 2
                result.text = "O Turn"
                
            } else {
                
                image = UIImage(named: "o2.png")!
                gameState[sender.tag/10][sender.tag%10] = 1
                result.text = "X Turn"
                
            }
            goNum++
            sender.setImage(image, forState: .Normal)
            
            
            // Hide all buttons
            var hide : UIButton
            for var i = 0; i < 9; i++ {
                hide = view.viewWithTag(i + 200) as UIButton
                hide.hidden = true
            }
            
            // Sets the goBoards back to normal Boards
            var normalBoard : UIImageView
            
            for var i = 0; i < 9; i++ {
                if trueGameState[i] == 0 {
                    normalBoard = view.viewWithTag(100 + i) as UIImageView
                    normalBoard.image = UIImage (named: "newBoard")
                }
            }

            // Check for draw in small tic tac toe
            var checker = 0
            if trueGameState[sender.tag/10] == 0{
                for numbers in gameState[sender.tag/10] {
                    if numbers == 0 {
                        checker++
                    }
                }
            }
            
            if checker == 0 {
                trueGameState[sender.tag/10] = 3
            }
            
            // Check for draw in big tic tac toe
            var checker1 = 0
            for checkPiece in trueGameState {
                if checkPiece == 0 {
                    checker1++
                }
            }
            
            if checker1 == 0 {
                winner = 3
            }
            
            // Check for win
            for combination in winningCombinations {
                
                if gameState[sender.tag/10][combination[0]] == gameState[sender.tag/10][combination[1]]
                    && gameState[sender.tag/10][combination[1]] == gameState[sender.tag/10][combination[2]]
                    && gameState[sender.tag/10][combination[0]] != 0 {
                        
                        //Hides all the x and o in little tictactoe
                        var button : UIButton
                        for var i = 0; i < 9; i++ {
                            button = view.viewWithTag(i + (sender.tag/10) * 10) as UIButton
                            button.setImage(nil, forState: .Normal)
                        }
                        
                        //Displays BIG X or BIG O
                        var uiImage : UIImageView
                        uiImage = view.viewWithTag(100 + (sender.tag/10)) as UIImageView
                        
                        if gameState[sender.tag/10][combination[0]] == 2 {
                            uiImage.image =  UIImage (named: "x.png")
                            trueGameState[sender.tag/10] = 2
                        } else if gameState[sender.tag/10][combination[0]] == 1 {
                            uiImage.image = UIImage (named: "o2.png")
                            trueGameState[sender.tag/10] = 1
                        }
                        
                        // Check for win in big tic tac toe
                        for combination2 in winningCombinations {
                            
                            if trueGameState[combination2[0]] == trueGameState[combination2[1]] &&
                                trueGameState[combination2[1]] == trueGameState[combination2[2]] &&
                                trueGameState[combination2[0]] != 0 && trueGameState[combination2[0]] != 3 {
                                    
                                    winner = trueGameState[combination2[0]]
                            }
                        }
                }
                
//                // Check for draw in big tic tac toe EXCEPTION
//                checker1 = 0
//                for checkPiece in trueGameState {
//                    if checkPiece == 0 {
//                        checker1++
//                    }
//                }
//                
//                if checker1 == 0 {
//                    winner = 3
//                }
                
            }
            
            if winner != 0 {
                if winner == 2{
                    result.text = "X wins!"
                } else if winner == 1 {
                    result.text = "O wins!"
                } else {
                    result.text = "Draw!"
                }
            } else {
    
                var reveal : UIButton
                var imageBoard : UIImageView
        
                // If the spot pressed is a valid move
                if trueGameState[sender.tag % 10] == 0 {
            
                    // Show buttons if it is valid move
                    for var i = 0; i < 9; i++ {
                        if (sender.tag % 10) != i {
                            reveal = view.viewWithTag(200 + i) as UIButton
                            reveal.hidden = false
                        } else {
                            imageBoard = view.viewWithTag(100 + i) as UIImageView
                            imageBoard.image =  UIImage (named: "goBoard2.png")
                        }
                    }
                
                    // If the spot is not a valid move
                } else {
                    // Shows all valid possible moves
                    for var i = 0; i < 9; i++ {
                        if trueGameState[i] != 0 {
                            reveal = view.viewWithTag(200 + i) as UIButton
                            reveal.hidden = false
                        } else {
                            imageBoard = view.viewWithTag(100 + i) as UIImageView
                            imageBoard.image =  UIImage (named: "goBoard2.png")
                        }
                    }
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
