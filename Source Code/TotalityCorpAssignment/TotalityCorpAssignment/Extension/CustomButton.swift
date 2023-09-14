//
//  CustomButton.swift
//  TotalityCorpAssignment
//
//  Created by APPLE on 12/09/23.
//

import UIKit

class CustomButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        }
        set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }

}
