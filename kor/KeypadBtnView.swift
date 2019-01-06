//
//  KeypadBtnView.swift
//  kor
//
//  Created by 박일호 on 31/12/2018.
//  Copyright © 2018 박일호. All rights reserved.
//

import Foundation
import UIKit

protocol KeypadBtnProtocol {
    func input(str: String)
}

class KeypadBtnView: UIView {
    
    let POSITION_0 = 0
    let POSITION_LEFT = 1
    let POSITION_TOP = 2
    let POSITION_RIGHT = 3
    let POSITION_DOWN = 4
    
    let LONG_PRESS_CHECK = 1.0
    
    let MOVING_POINT = CGFloat(30)
    
    var textDocumentProxy: UITextDocumentProxy?
    
    var firstPoint: CGPoint?
    
    var delegate: KeypadBtnProtocol?
    
    var isLongPress = false
    
    var beganStamp: Double?
    var endStamp: Double?
    
    // MARK: Touch event
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isLongPress = false
        if (restorationIdentifier) != nil {
            firstPoint = touches.first?.location(in: self)
            beganStamp = touches.first?.timestamp
            print("151515 began =\(touches.first?.timestamp)")
        }
        self.backgroundColor = UIColor.darkGray
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let id = restorationIdentifier {
            
            var position = POSITION_0
            var returnStr: String? = ""
            print("151515 end =\(touches.first?.timestamp)")
            if let lastPoint = touches.first?.location(in: self) {
            
                endStamp = touches.first?.timestamp
                
                if(endStamp! - beganStamp! > LONG_PRESS_CHECK) {
                    isLongPress = true;
                }
                
                let firstX = firstPoint?.x
                let firstY = firstPoint?.y
                let lastX = lastPoint.x
                let lastY = lastPoint.y
                
                var isLeft = false
                var isRight = false
                var isTop = false
                var isDown = false
                
                var movingX: CGFloat = 0
                var movingY: CGFloat = 0
                
                if(firstX! - lastX)>MOVING_POINT { // left
//                    position = POSITION_LEFT
                    movingX = firstX! - lastX
                    isLeft = true
                } else if (firstX! - lastX)<(-MOVING_POINT) { // right
//                    position = POSITION_RIGHT
                    movingX = -(firstX! - lastX)
                    isRight = true
                }
                
                if (firstY! - lastY) > MOVING_POINT { // down
//                    position = POSITION_TOP
                    movingY = firstY! - lastY
                    isTop = true
                } else if (firstY! - lastY)<(-MOVING_POINT) { //Top
//                    position = POSITION_DOWN
                    movingY = -(firstY! - lastY)
                    isDown = true
                }
                
                if isLeft {
                    position = POSITION_LEFT
                    if(isTop) {
                        if(movingX < movingY) {
                            position = POSITION_TOP
                        } else {
                            position = POSITION_LEFT
                        }
                    } else if(isDown) {
                        if(movingX < movingY) {
                            position = POSITION_DOWN
                        } else {
                            position = POSITION_LEFT
                        }
                    }
                } else if isRight {
                    position = POSITION_RIGHT
                    if(isTop) {
                        if(movingX < movingY) {
                            position = POSITION_TOP
                        } else {
                            position = POSITION_RIGHT
                        }
                    } else if(isDown) {
                        if(movingX < movingY) {
                            position = POSITION_DOWN
                        } else {
                            position = POSITION_RIGHT
                        }
                    }
                } else if isTop {
                    position = POSITION_TOP
                } else if isDown {
                    position = POSITION_DOWN
                }
            }
            switch id {
            case "1":
                if position == POSITION_0 {
                    returnStr = "ㄱ"
                } else if position == POSITION_LEFT {
                    returnStr = "ㅋ"
                } else if position == POSITION_TOP {
                    returnStr = "ㄲ"
                } else if position == POSITION_RIGHT {
                    returnStr = "ㅋ"
                } else if position == POSITION_DOWN {
                    returnStr = "#"
                }
                break
            case "2":
                if position == POSITION_0 {
                    returnStr = "ㄴ"
                } else if position == POSITION_LEFT {
                    returnStr = "ㅌ"
                } else if position == POSITION_TOP {
                    returnStr = "ㄸ"
                } else if position == POSITION_RIGHT {
                    returnStr = "ㅌ"
                } else if position == POSITION_DOWN {
                    returnStr = "ㄷ"
                }
                break
            case "3":
                if position == POSITION_0 {
                    returnStr = "ㅢ"
                } else if position == POSITION_LEFT {
                    returnStr = "ㅝ"
                } else if position == POSITION_TOP {
                    returnStr = "ㅚ"
                } else if position == POSITION_RIGHT {
                    returnStr = "ㅘ"
                } else if position == POSITION_DOWN {
                    returnStr = "ㅟ"
                }
                break
            case "4":
                if position == POSITION_0 {
                    returnStr = "ㄹ"
                } else if position == POSITION_LEFT {
                    returnStr = "="
                } else if position == POSITION_TOP {
                    returnStr = "^"
                } else if position == POSITION_RIGHT {
                    returnStr = "-"
                } else if position == POSITION_DOWN {
                    returnStr = "_"
                }
                break
            case "5":
                if position == POSITION_0 {
                    returnStr = "ㅁ"
                } else if position == POSITION_LEFT {
                    returnStr = "ㅍ"
                } else if position == POSITION_TOP {
                    returnStr = "ㅃ"
                } else if position == POSITION_RIGHT {
                    returnStr = "ㅍ"
                } else if position == POSITION_DOWN {
                    returnStr = "ㅂ"
                }
                break
            case "6":
                if position == POSITION_0 {
                    returnStr = "ㅣ"
                } else if position == POSITION_LEFT {
                    returnStr = "ㅓ"
                } else if position == POSITION_TOP {
                    returnStr = "ㅗ"
                } else if position == POSITION_RIGHT {
                    returnStr = "ㅏ"
                } else if position == POSITION_DOWN {
                    returnStr = "ㅜ"
                }
                break
            case "7":
                if position == POSITION_0 {
                    returnStr = "ㅅ"
                } else if position == POSITION_LEFT {
                    returnStr = "1"
                } else if position == POSITION_TOP {
                    returnStr = "ㅆ"
                } else if position == POSITION_RIGHT {
                    returnStr = "3"
                } else if position == POSITION_DOWN {
                    returnStr = "2"
                }
                break
            case "8":
                if position == POSITION_0 {
                    returnStr = "ㅇ"
                } else if position == POSITION_LEFT {
                    returnStr = "4"
                } else if position == POSITION_TOP {
                    returnStr = "ㅇ"
                } else if position == POSITION_RIGHT {
                    returnStr = "6"
                } else if position == POSITION_DOWN {
                    returnStr = "5"
                }
                break
            case "9":
                if position == POSITION_0 {
                    returnStr = "ㅡ"
                } else if position == POSITION_LEFT {
                    returnStr = "ㅔ"
                } else if position == POSITION_TOP {
                    returnStr = "ㅙ"
                } else if position == POSITION_RIGHT {
                    returnStr = "ㅐ"
                } else if position == POSITION_DOWN {
                    returnStr = "ㅞ"
                }
                break
            case "10":
                if position == POSITION_0 {
                    returnStr = "ㅈ"
                } else if position == POSITION_LEFT {
                    returnStr = "ㅊ"
                } else if position == POSITION_TOP {
                    returnStr = "ㅍ"
                } else if position == POSITION_RIGHT {
                    returnStr = "ㅊ"
                } else if position == POSITION_DOWN {
                    returnStr = "~"
                }
                break
            case "11":
                if position == POSITION_0 {
                    returnStr = "ㅎ"
                } else if position == POSITION_LEFT {
                    returnStr = "7"
                } else if position == POSITION_TOP {
                    returnStr = "0"
                } else if position == POSITION_RIGHT {
                    returnStr = "9"
                } else if position == POSITION_DOWN {
                    returnStr = "8"
                }
                break
            case "12":
                if position == POSITION_LEFT {
                    if(isLongPress) {
                        returnStr = "ㅖ"
                    } else {
                        returnStr = "ㅕ"
                    }
                } else if position == POSITION_TOP {
                    returnStr = "ㅛ"
                } else if position == POSITION_RIGHT {
                    if(isLongPress) {
                        returnStr = "ㅒ"
                    } else {
                        returnStr = "ㅑ"
                    }
                } else if position == POSITION_DOWN {
                    returnStr = "ㅠ"
                }
                break
            case "symbol1":
                if position == POSITION_0 {
                    returnStr = "?"
                } else if position == POSITION_LEFT {
                    returnStr = "+"
                } else if position == POSITION_TOP {
                    returnStr = "!"
                } else if position == POSITION_RIGHT {
                    returnStr = "?"
                } else if position == POSITION_DOWN {
                    returnStr = "="
                }
                break
            case "symbol2":
                if position == POSITION_0 {
                    returnStr = "."
                } else if position == POSITION_LEFT {
                    returnStr = ","
                } else if position == POSITION_TOP {
                    returnStr = "\""
                } else if position == POSITION_RIGHT {
                    returnStr = "."
                } else if position == POSITION_DOWN {
                    returnStr = "'"
                }
                break
            case "symbol3":
                if position == POSITION_0 {
                    returnStr = "/"
                } else if position == POSITION_LEFT {
                    returnStr = "@"
                } else if position == POSITION_TOP {
                    returnStr = ":"
                } else if position == POSITION_RIGHT {
                    returnStr = "/"
                } else if position == POSITION_DOWN {
                    returnStr = ";"
                }
                break
            default:
                break
                
            }
            
            delegate?.input(str: returnStr!)
            
        }
        
        self.backgroundColor = UIColor.black
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.backgroundColor = UIColor.black
    }
    
    // MARK: set Protocol
    func setProtocol(delegate: KeypadBtnProtocol) {
        self.delegate = delegate
    }
    
//    func setLongPress(isLongPress: Bool) {
//        self.isLongPress = isLongPress
//    }
}
