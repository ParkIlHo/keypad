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
    
    let MOVING_POINT = CGFloat(15)
    
    var textDocumentProxy: UITextDocumentProxy?
    
    var firstPoint: CGPoint?
    
    var delegate: KeypadBtnProtocol?
    
    // MARK: Touch event
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (restorationIdentifier) != nil {
            firstPoint = touches.first?.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let id = restorationIdentifier {
            
            var position = POSITION_0;
            var returnStr: String? = ""
            
            if let lastPoint = touches.first?.location(in: self) {
            
                let firstX = firstPoint?.x
                let firstY = firstPoint?.y
                let lastX = lastPoint.x
                let lastY = lastPoint.y
                
                if(firstX! - lastX)>MOVING_POINT { // left
                    position = POSITION_LEFT
                } else if (firstX! - lastX)<(-MOVING_POINT) { // right
                    position = POSITION_RIGHT
                } else if (firstY! - lastY) > MOVING_POINT { // down
                    position = POSITION_TOP
                } else if (firstY! - lastY)<(-MOVING_POINT) { //Top
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
                if position == POSITION_0 {
                    returnStr = ""
                } else if position == POSITION_LEFT {
                    returnStr = "ㅕ"
                } else if position == POSITION_TOP {
                    returnStr = "ㅛ"
                } else if position == POSITION_RIGHT {
                    returnStr = "ㅑ"
                } else if position == POSITION_DOWN {
                    returnStr = "ㅠ"
                }
                break
            default:
                break
                
            }
            
            delegate?.input(str: returnStr!)
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    // MARK: set Protocol
    func setProtocol(delegate: KeypadBtnProtocol) {
        self.delegate = delegate
    }
}
