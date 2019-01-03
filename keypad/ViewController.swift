//
//  ViewController.swift
//  keypad
//
//  Created by 박일호 on 31/12/2018.
//  Copyright © 2018 박일호. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var text: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        text.becomeFirstResponder()
    }


}

