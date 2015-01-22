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
    
    @IBOutlet var instructions: UILabel!
    
    @IBOutlet var backToGame: UIButton!
    
    @IBOutlet var instructionsText: UITextView!
    
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
    
    // Keeps track of valid places to go
    // 0 is not valid, 1 is valid
    var validMoveState = [0,0,0,0,0,0,0,0,0]
    
    // All the possible winning combinations
    let winningCombinations = [[0,1,2], [3,4,5], [6,7,8],
                              [0,3,6], [1,4,7], [2,5,8],
                              [0,4,8], [2,4,6]]
    
    // Returns an array of all the possible moves
    func validMoves()->[Int] {
        var validIndex = [Int]()
        for var i = 0; i < 9; i++ {
            if validMoveState[i] == 1 {
                for var j = 0; j < 9; j++ {
                    if gameState[i][j] == 0{
                        validIndex.append (i*10 + j)
                    }
                }
            }
        }
        return validIndex
    }
    
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
    
    // Places piece on the board
    // Checks if game is won/draw
    func makeMove(row: Int, column: Int) {
        var buttonPic = UIButton()
        buttonPic = view.viewWithTag(row*10 + column) as UIButton
        
        var imageButton = UIImage()
        
        if (gameState[row][column] == 0) && winner == 0 {
            
            // Places an X or an O depending on whos turn it is
            if (goNum % 2 == 0) {
                
                imageButton = UIImage(named: "x.png")!
                gameState[row][column] = 2
                result.text = "O Turn"
                
            } else {
                
                imageButton = UIImage(named: "o.png")!
                gameState[row][column] = 1
                result.text = "X Turn"
                
            }
            goNum++
            buttonPic.setImage(imageButton, forState: .Normal)
            
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
            if trueGameState[row] == 0{
                for numbers in gameState[row] {
                    if numbers == 0 {
                        checker++
                    }
                }
            }
            
            if checker == 0 {
                trueGameState[row] = 3
            }
            
            // Check for win
            for combination in winningCombinations {
                
                if gameState[row][combination[0]] == gameState[row][combination[1]]
                    && gameState[row][combination[1]] == gameState[row][combination[2]]
                    && gameState[row][combination[0]] != 0 {
                        
                        //Hides all the x and o in little tictactoe
                        var button : UIButton
                        for var i = 0; i < 9; i++ {
                            button = view.viewWithTag(i + row * 10) as UIButton
                            button.setImage(nil, forState: .Normal)
                        }
                        
                        //Displays BIG X or BIG O
                        var uiImage : UIImageView
                        uiImage = view.viewWithTag(100 + row) as UIImageView
                        
                        if gameState[row][combination[0]] == 2 {
                            uiImage.image =  UIImage (named: "x.png")
                            trueGameState[row] = 2
                        } else if gameState[row][combination[0]] == 1 {
                            uiImage.image = UIImage (named: "o.png")
                            trueGameState[row] = 1
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
                
            }
            
            // Check for draw in big tic tac toe EXCEPTION
            if winner == 0 {
                var checker1 = 0
                for checkPiece in trueGameState {
                    if checkPiece == 0 {
                        checker1++
                    }
                }
                
                if checker1 == 0 {
                    winner = 3
                }
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
                if trueGameState[column] == 0 {
                    
                    // Shows buttons if it is valid move
                    // Highlights where to put next move
                    for var i = 0; i < 9; i++ {
                        if column != i {
                            reveal = view.viewWithTag(200 + i) as UIButton
                            reveal.hidden = false
                            validMoveState[i] = 0
                        } else {
                            imageBoard = view.viewWithTag(100 + i) as UIImageView
                            imageBoard.image =  UIImage (named: "goBoard.png")
                            validMoveState[i] = 1
                        }
                    }
                    
                // If the spot is not a valid move
                } else {
                    // Shows all valid possible moves
                    for var i = 0; i < 9; i++ {
                        if trueGameState[i] != 0 {
                            reveal = view.viewWithTag(200 + i) as UIButton
                            reveal.hidden = false
                            validMoveState[i] = 0
                        } else {
                            imageBoard = view.viewWithTag(100 + i) as UIImageView
                            imageBoard.image =  UIImage (named: "goBoard.png")
                            validMoveState[i] = 1
                        }
                    }
                }
            }
        }
        
    }

    // When the user presses a square on the board
    @IBAction func buttonPressed(sender: AnyObject) {

        makeMove(sender.tag/10, column: sender.tag%10)
        
        // 1 player vs computer (Plays a random move)
        var moves = validMoves()
//        println(moves)
//        if winner == 0 {
//        var randomIndex = Int(arc4random_uniform(UInt32(moves.count)))
//        makeMove(moves[randomIndex]/10, column: moves[randomIndex]%10)
//        computerMove()
//          }
    }
    
    // player is either 1 for computer or 2 for player
    func computerMove(player: Int) {
        var moves = validMoves()
        var testBoard = gameState
        var scores = [Int]()
        
        for testMove in moves {
            
            // places piece in test board
            testBoard[testMove/10][testMove%10] = player
            
            // checks for win for computer
            for combination in winningCombinations {
                
                // If computer wins
                if testBoard[testMove/10][combination[0]] == testBoard[testMove/10][combination[1]]
                && testBoard[testMove/10][combination[1]] == testBoard[testMove/10][combination[2]]
                && testBoard[testMove/10][combination[0]] != 0 {
                    scores.append(100)
                }
            }
            
            //Checks for win for player and tries to block
            computerMove(1)
            
            testBoard = gameState
        }
        
    }

    
    @IBAction func helpPressed(sender: AnyObject) {
        backToGame.hidden = false
        instructions.hidden = false
        instructionsText.hidden = false
        
    }
    
    @IBAction func backToGamePressed(sender: AnyObject) {
         backToGame.hidden = true
        instructions.hidden = true
        instructionsText.hidden = true
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        
        return true;
    }

}

