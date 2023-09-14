//
//  CustomView.swift
//  TotalityCorpAssignment
//
//  Created by APPLE on 11/09/23.
//

import UIKit

class CustomView: UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        }
        set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
}
