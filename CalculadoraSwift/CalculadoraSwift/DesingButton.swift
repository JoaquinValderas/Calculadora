//
//  DesingButton.swift
//  CalculadoraSwift
//
//  Created by Joaquin Custodio  on 9/2/22.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    var roundButton: Bool = false{
        didSet{
            if roundButton {
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if roundButton {
            layer.cornerRadius = frame.height / 2
        }
    }
}
