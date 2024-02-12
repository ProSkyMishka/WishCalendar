//
//  MakeColor.swift
//  maprozorskiyPW2
//
//  Created by Михаил Прозорский on 02.02.2024.
//

import UIKit

class MakeColor {
    static func makeColor() -> UIColor {
        return UIColor(
            red: ((Vars.backColor.cgColor.components![0] != Constants.zero) ? Vars.backColor.cgColor.components![0] - Constants.diff : Constants.diff),
            green: ((Vars.backColor.cgColor.components![1] != Constants.zero) ? Vars.backColor.cgColor.components![1] - Constants.diff : Constants.diff),
            blue: ((Vars.backColor.cgColor.components![2] != Constants.zero) ? Vars.backColor.cgColor.components![2] - Constants.diff : Constants.diff),
            alpha: 1)
    }
}
