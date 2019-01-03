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
    var completeText: Character!
    
    let firstSet = [ // ㄱ = 12593
        "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ" // 초성 19개
    ]
    
    let midleSet = [// ㅏ = 12623 ㅣ = 12643
        "ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ" // 중성 21개
    ]
    
    let lastSet = [
        " ", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ" // 종성 28개
    ]
    
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

    @IBOutlet var nextKeyboardButton: UIButton!
    
    @IBAction func pressed(_ sender: UIButton) {
//        var id = sender.restorationIdentifier
//        (textDocumentProxy as UIKeyInput).insertText(id ?? "")
        if let id = sender.restorationIdentifier as! String? {
            switch id {
            case "del" :
                (textDocumentProxy as UIKeyInput).deleteBackward()
                break
            case "space":
                (textDocumentProxy as UIKeyInput).insertText(" ")
                break
            case "change_keyboard":
                advanceToNextInputMode()
                break
            default:
                break
                
            }
        }
    }
    
    // MARK: override method
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
//        self.nextKeyboardButton = UIButton(type: .system)
//
//        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
//        self.nextKeyboardButton.sizeToFit()
//        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
//        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
//        self.view.addSubview(self.nextKeyboardButton)
        
//        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
//        self.nextKeyboardButton.addTarget(self, action: #selector(UIInputViewController.advanceToNextInputMode), for: .touchUpInside)
        
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
        var isMo = false
        var isJa = false
        var isFirst = true
        var isMiddle = false
        var isLast = false
        
        if((str.unicodeScalars.first?.value)! >= UInt32(12593) || (str.unicodeScalars.first?.value)! < UInt32(12623)) {
            isJa = true
        } else if ((str.unicodeScalars.first?.value)! >= UInt32(12623) || (str.unicodeScalars.first?.value)! < UInt32(12643)) {
            isMo = true
        }
        
        if let last = textDocumentProxy.documentContextBeforeInput {
            lastText = last.last
            let lastTextValue = (lastText.unicodeScalars.first?.value)!
            if(lastText != prevText) {
              prevText = " "
              lastText = " "
            } else if(lastTextValue < UInt32(44032) || lastTextValue > UInt32(55203)) { // 한글이 아닐 경우. 자음모음이 조합되지 않은 경우에도 포함
                if(lastTextValue >= UInt32(12593) || lastTextValue < UInt32(12623)) {
                    
                }
            } else { // 모음과 자음이 합성된 한글일 경우
                
            }
        } else {
            lastText = " "
        }
    
        if lastText == Character(" ") {
            (textDocumentProxy as UIKeyInput).insertText(str)
        } else {
            (textDocumentProxy as UIKeyInput).insertText("1")
        }
        (textDocumentProxy as UIKeyInput).insertText("\((Character(firstSet[0])).unicodeScalars.first?.value)")
        (textDocumentProxy as UIKeyInput).insertText("\((Character(midleSet[0])).unicodeScalars.first?.value)")
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
        first.setProtocol(delegate: self)
    }

}
