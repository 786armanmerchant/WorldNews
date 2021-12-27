//
//  Extension.swift
//  WorldNews
//
//  Created by Arman Merchant on 04/12/21.
//

import Foundation
import UIKit
import MaterialTextField


extension UITextField {
    func getText()-> String{
        return self.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    func makeCapital()->String{
        return self.getText().uppercased()
    }
}



extension MFTextField {
    func showError(_ message: String, _ animated: Bool = false, _ errorColor: UIColor = .red) {
        let error = NSError(domain: "errorDomain", code: 100, userInfo: [NSLocalizedDescriptionKey: NSLocalizedString(message, comment: message)])
        self.setError(error, animated: animated)
        self.errorColor = errorColor
    }

    func removeError() {
        self.setError(nil, animated: true)
    }
    func setActiveLabelColor(_ color: UIColor = .black) {
        self.tintColor = color
    }
}


extension UIView {
    func addShadow(cornerRadius:CGFloat = 15, shadowRadius:CGFloat = 20, shadowColor:UIColor = UIColor.gray, shadowOffset: CGSize = CGSize(width: 0.0, height: 0.3), opacity:Float = 0.5){
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: shadowRadius)

        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = opacity
        layer.shadowPath = shadowPath.cgPath

    }
}


extension UIViewController {
    var window: UIWindow? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
        return window
    }
}
