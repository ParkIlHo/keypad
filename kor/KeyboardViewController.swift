//
//  KeyboardViewController.swift
//  kor
//
//  Created by 박일호 on 31/12/2018.
//  Copyright © 2018 박일호. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, KeypadBtnProtocol {
    
    var keypadView: UIView!
    
    var lastText: Character!
    var prevText: Character!
    var completeText: String!
    
    var delLongPressRecognizer: UILongPressGestureRecognizer!
    
    let firstSet = [ // ㄱ = 12593
        "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ" // 초성 19개
    ]
    
    let midleSet = [// ㅏ = 12623 ㅣ = 12643
        "ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ" // 중성 21개
    ]
    
    let lastSet = [
        " ", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ" // 종성 28개
    ]
    
    var isDelLongPress = false
    var delCount = 0;
    
    @IBOutlet weak var first: KeypadBtnView!
    @IBOutlet weak var second: KeypadBtnView!
    @IBOutlet weak var third: KeypadBtnView!
    @IBOutlet weak var forth: KeypadBtnView!
    @IBOutlet weak var fifth: KeypadBtnView!
    @IBOutlet weak var sixth: KeypadBtnView!
    @IBOutlet weak var seventh: KeypadBtnView!
    @IBOutlet weak var eighth: KeypadBtnView!
    @IBOutlet weak var ninth: KeypadBtnView!
    @IBOutlet weak var tenth: KeypadBtnView!
    @IBOutlet weak var eleventh: KeypadBtnView!
    @IBOutlet weak var twelveth: KeypadBtnView!
    @IBOutlet weak var symbol1: KeypadBtnView!
    @IBOutlet weak var symbol2: KeypadBtnView!
    @IBOutlet weak var symbol3: KeypadBtnView!
    
    @IBOutlet weak var del: UIButton!

    @IBOutlet var nextKeyboardButton: UIButton!
    
    @IBAction func pressed(_ sender: UIButton) {
//        var id = sender.restorationIdentifier
//        (textDocumentProxy as UIKeyInput).insertText(id ?? "")
        if let id = sender.restorationIdentifier as! String? {
            switch id {
            case "del" :
                print("151515 : delete press")
                self.delete()
//                (textDocumentProxy as UIKeyInput).deleteBackward()
                break
            case "space":
                (textDocumentProxy as UIKeyInput).insertText(" ")
                break
            case "change_keyboard":
                advanceToNextInputMode()
                break
            case "enter":
                (textDocumentProxy as UIKeyInput).insertText("\n")
                break
            case "other":
                (textDocumentProxy as UIKeyInput).insertText("ㅋㅋㅋ")
                break
            default:
                break
                
            }
        }
    }
    
    @IBAction func delLongPress(_ sender: UILongPressGestureRecognizer) {
        //        print("151515 Long Press\(sender.state)")
        if sender.state == UIGestureRecognizer.State.began {
            isDelLongPress = true
            self.delAsync()
            print("151515 Long Press Began")
        } else if sender.state == UIGestureRecognizer.State.ended {
            isDelLongPress = false
            delCount = 0
            print("151515 Long Press Ended")
        }
        else if sender.state == UIGestureRecognizer.State.cancelled {
            isDelLongPress = false
            delCount = 0
            print("151515 Long Press cancelled")
        } else if sender.state == UIGestureRecognizer.State.failed {
            isDelLongPress = false
            delCount = 0
            print("151515 Long Press failed")
        }
    }
    
    // MARK: override method
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delLongPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(delLongPress))
        self.delLongPressRecognizer.minimumPressDuration = 1.0
        
        self.loadInterface()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
    // MARK: Keypad protocol
    func input(str: String) {
        if(str == "") {
            return
        }
        var isMo = false
        var isJa = false
        var isAdd = false
//        var isFirst = true
//        var isMiddle = false
//        var isLast = false
        
        let strValue = (str.unicodeScalars.first?.value)!
        
        if(strValue >= UInt32(12593) && strValue < UInt32(12623)) {
            isJa = true
        } else if (strValue >= UInt32(12623) && strValue < UInt32(12644)) {
            isMo = true
        }
        
        if let last = textDocumentProxy.documentContextBeforeInput {
            lastText = last.last
            let lastTextValue = (lastText.unicodeScalars.first?.value)!
            if(lastText != prevText) {
              prevText = " "
              lastText = " "
            } else if(lastTextValue < UInt32(44032) || lastTextValue > UInt32(55203)) { // 한글이 아닐 경우. 자음모음이 조합되지 않은 경우에도 포함
                if(lastTextValue >= UInt32(12593) && lastTextValue < UInt32(12623)) {
                    if(isMo) {
                        
                        let chosung = firstSet.index(of: String(lastText))
                        let jungsung = midleSet.index(of: str)
//                        (textDocumentProxy as UIKeyInput).insertText("\("ㄱ".unicodeScalars.first?.value)")
                        completeText = getKorCode(chosung: chosung!, jungsung: jungsung!, jongsung: 0)
                        print("testest")
                        
                    } else if(isJa) {
                        lastText = " "
                        print("testest2")
                    } else {
                        lastText = " "
                    }
                } else if (strValue >= UInt32(12623) && strValue < UInt32(12644)) {
                    lastText = " "
                    print("testest3")
                } else {
                    lastText = " "
                }
            } else { // 모음과 자음이 합성된 한글일 경우
                let korArray = splitKor(text: String(prevText))
                print("testest4")
                if(korArray[2] == 0) {
                    if let jongsung = lastSet.index(of: str) {
                        completeText = getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: jongsung)
                    } else {
                        lastText = " "
                    }
                } else { // 한글이 종성까지 있을 경우에 대한 check
                    if(isJa) {
                        switch korArray[2] {
                        case 1: // ㄱ // 겹받침 체크
                            if firstSet.index(of: str) == firstSet.index(of: "ㅅ") {
                                completeText = getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄳ")!)
                            } else {
                                lastText = " "
                            }
                            break
                        case 4: // ㄴ // 겹받침 체크
                            if firstSet.index(of: str) == firstSet.index(of: "ㅈ") {
                                completeText = getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄵ")!)
                            } else if firstSet.index(of: str) == firstSet.index(of: "ㅎ") {
                                completeText = getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄶ")!)
                            } else {
                                lastText = " "
                            }
                            break
                        case 8: // ㄹ // 겹받침 체크
                            if firstSet.index(of: str) == firstSet.index(of: "ㄱ") {
                                completeText = getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄺ")!)
                            } else if firstSet.index(of: str) == firstSet.index(of: "ㅁ") {
                                completeText = getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄻ")!)
                            } else if firstSet.index(of: str) == firstSet.index(of: "ㅂ") {
                                completeText = getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄼ")!)
                            } else if firstSet.index(of: str) == firstSet.index(of: "ㅅ") {
                                completeText = getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄽ")!)
                            } else if firstSet.index(of: str) == firstSet.index(of: "ㅌ") {
                                completeText = getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄾ")!)
                            } else if firstSet.index(of: str) == firstSet.index(of: "ㅍ") {
                                completeText = getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄿ")!)
                            } else if firstSet.index(of: str) == firstSet.index(of: "ㅎ") {
                                completeText = getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㅀ")!)
                            } else {
                                lastText = " "
                            }
                            break
                        case 17: // ㅂ // 겹받침 체크
                            if firstSet.index(of: str) == firstSet.index(of: "ㅅ") {
                                completeText = getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㅄ")!)
                            } else {
                                lastText = " "
                            }
                            break
                        default:
                            lastText = " "
                            break
                        }
                    } else if(isMo) { // 입력된 값이 모음인 경우 마지막 글자의 종성과 조합
                        isAdd = true
                        switch korArray[2] {
//                            " ", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ" // 종성 28개
                        case 3: // ㄳ
                            (textDocumentProxy as UIKeyInput).deleteBackward()
                            (textDocumentProxy as UIKeyInput).insertText(getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄱ")!))
                            completeText = getKorCode(chosung: firstSet.index(of: "ㅅ")!, jungsung: midleSet.index(of: str)!, jongsung: 0)
                            break
                        case 5: // ㄵ
                            (textDocumentProxy as UIKeyInput).deleteBackward()
                            (textDocumentProxy as UIKeyInput).insertText(getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄴ")!))
                            completeText = getKorCode(chosung: firstSet.index(of: "ㅈ")!, jungsung: midleSet.index(of: str)!, jongsung: 0)
                            break
                        case 6: // ㄶ
                            (textDocumentProxy as UIKeyInput).deleteBackward()
                            (textDocumentProxy as UIKeyInput).insertText(getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄴ")!))
                            completeText = getKorCode(chosung: firstSet.index(of: "ㅎ")!, jungsung: midleSet.index(of: str)!, jongsung: 0)
                            break
                        case 9: // ㄺ
                            (textDocumentProxy as UIKeyInput).deleteBackward()
                            (textDocumentProxy as UIKeyInput).insertText(getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄹ")!))
                            completeText = getKorCode(chosung: firstSet.index(of: "ㄱ")!, jungsung: midleSet.index(of: str)!, jongsung: 0)
                            break
                        case 10: // ㄻ
                            (textDocumentProxy as UIKeyInput).deleteBackward()
                            (textDocumentProxy as UIKeyInput).insertText(getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄹ")!))
                            completeText = getKorCode(chosung: firstSet.index(of: "ㅁ")!, jungsung: midleSet.index(of: str)!, jongsung: 0)
                            break
                        case 11: // ㄼ
                            (textDocumentProxy as UIKeyInput).deleteBackward()
                            (textDocumentProxy as UIKeyInput).insertText(getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄹ")!))
                            completeText = getKorCode(chosung: firstSet.index(of: "ㅂ")!, jungsung: midleSet.index(of: str)!, jongsung: 0)
                            break
                        case 12: // ㄽ
                            (textDocumentProxy as UIKeyInput).deleteBackward()
                            (textDocumentProxy as UIKeyInput).insertText(getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄹ")!))
                            completeText = getKorCode(chosung: firstSet.index(of: "ㅅ")!, jungsung: midleSet.index(of: str)!, jongsung: 0)
                            break
                        case 13: // ㄾ
                            (textDocumentProxy as UIKeyInput).deleteBackward()
                            (textDocumentProxy as UIKeyInput).insertText(getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄹ")!))
                            completeText = getKorCode(chosung: firstSet.index(of: "ㅌ")!, jungsung: midleSet.index(of: str)!, jongsung: 0)
                            break
                        case 14: // ㄿ
                            (textDocumentProxy as UIKeyInput).deleteBackward()
                            (textDocumentProxy as UIKeyInput).insertText(getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄹ")!))
                            completeText = getKorCode(chosung: firstSet.index(of: "ㅍ")!, jungsung: midleSet.index(of: str)!, jongsung: 0)
                            break
                        case 15: // ㅀ
                            (textDocumentProxy as UIKeyInput).deleteBackward()
                            (textDocumentProxy as UIKeyInput).insertText(getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㄹ")!))
                            completeText = getKorCode(chosung: firstSet.index(of: "ㅎ")!, jungsung: midleSet.index(of: str)!, jongsung: 0)
                            break
                        case 18: // ㅄ
                            (textDocumentProxy as UIKeyInput).deleteBackward()
                            (textDocumentProxy as UIKeyInput).insertText(getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: lastSet.index(of: "ㅂ")!))
                            completeText = getKorCode(chosung: firstSet.index(of: "ㅅ")!, jungsung: midleSet.index(of: str)!, jongsung: 0)
                            break
                        default:
                            (textDocumentProxy as UIKeyInput).deleteBackward()
                            (textDocumentProxy as UIKeyInput).insertText(getKorCode(chosung: korArray[0], jungsung: korArray[1], jongsung: 0))
                            completeText = getKorCode(chosung: firstSet.index(of: lastSet[korArray[2]])!, jungsung: midleSet.index(of: str)!, jongsung: 0)
                            break
                        }
                    } else {
                        lastText = " "
                    }
                }
            }
        } else {
            lastText = " "
        }
    
        if lastText == Character(" ") {
            (textDocumentProxy as UIKeyInput).insertText(str)
            prevText = str.last
        } else {
            if(!isAdd) {
                (textDocumentProxy as UIKeyInput).deleteBackward()
            }
            (textDocumentProxy as UIKeyInput).insertText(completeText)
            prevText = completeText.last
            completeText = " "
        }
//        (textDocumentProxy as UIKeyInput).insertText(getKorCode(chosung: 0, jungsung: 1, jongsung: 0))
//        (Character(firstSet[0])).unicodeScalars.first?.value
    }
    
    // MARK: Private Method
    func loadInterface() {
        var keypad = UINib(nibName: "korView", bundle: nil)
        
        keypadView = keypad.instantiate(withOwner: self, options: nil)[0] as! UIView
        keypadView.frame.size = view.frame.size
        view.addSubview(keypadView)
        
        first.setProtocol(delegate: self)
        second.setProtocol(delegate: self)
        third.setProtocol(delegate: self)
        forth.setProtocol(delegate: self)
        fifth.setProtocol(delegate: self)
        sixth.setProtocol(delegate: self)
        seventh.setProtocol(delegate: self)
        eighth.setProtocol(delegate: self)
        ninth.setProtocol(delegate: self)
        tenth.setProtocol(delegate: self)
        eleventh.setProtocol(delegate: self)
        twelveth.setProtocol(delegate: self)
        symbol1.setProtocol(delegate: self)
        symbol2.setProtocol(delegate: self)
        symbol3.setProtocol(delegate: self)
        
        self.del.addGestureRecognizer(delLongPressRecognizer)
    }
    
    func getKorCode(chosung: Int, jungsung: Int, jongsung: Int) -> String {
        var korCode = 44032 + (chosung * 588) + (jungsung * 28) + jongsung
        return String(UnicodeScalar(korCode)!)
    }
    
    func splitKor(text: String) -> Array<Int> {
        var returnArray = Array<Int>()

        let charCode = (text.unicodeScalars.first?.value)! - 44032
        let chosung = charCode / 28 / 21
        let jungsung = (charCode / 28) % 21
        let jongsung = charCode % 28

        returnArray.append(Int(chosung))
        returnArray.append(Int(jungsung))
        returnArray.append(Int(jongsung))
//        let tmp = text.
        return returnArray
    }
    
    func delete() {
        if let last = textDocumentProxy.documentContextBeforeInput {
            lastText = last.last
            let lastTextValue = (lastText.unicodeScalars.first?.value)!
            if(lastText != prevText) {
                (textDocumentProxy as UIKeyInput).deleteBackward()
            } else if(lastTextValue < UInt32(44032) || lastTextValue > UInt32(55203)) { // 한글이 아닐 경우. 자음모음이 조합되지 않은 경우에도 포함
                (textDocumentProxy as UIKeyInput).deleteBackward()
            } else {
                let splitText = splitKor(text: String(lastText))
                if(splitText[2] == 0) {
                    completeText = firstSet[splitText[0]]
                } else {
                    completeText = getKorCode(chosung: splitText[0], jungsung: splitText[1], jongsung: 0)
                }
                (textDocumentProxy as UIKeyInput).deleteBackward()
                (textDocumentProxy as UIKeyInput).insertText(completeText)
                prevText = completeText.last
                completeText = " "
            }
        }
    }
    
    func delAsync() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.delCount = self.delCount + 1
            if self.isDelLongPress {
                for _ in 0..<self.delCount {
                    (self.textDocumentProxy as UIKeyInput).deleteBackward()
                }
                self.delAsync()
            }
            print("151515 Long Press Async")
        })
    }
}

