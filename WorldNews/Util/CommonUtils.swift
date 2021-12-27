//
//  CommonUtils.swift
//  WorldNews
//
//  Created by Arman Merchant on 04/12/21.
//

import Foundation
import UIKit
import Lottie

class CommonUtils {
    
    class func getViewController(id:String)-> UIViewController? {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        return sb.instantiateViewController(withIdentifier: id)
    }
    
    class func validateTextfield(item:String, regEx:String)->Bool{
        let emailPred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return emailPred.evaluate(with: item)
    }
    
    
    class func playLottieAnimation(fileName: String,animationView: AnimationView, loopMode:LottieLoopMode){
        animationView.animation = Animation.named(fileName)
        animationView.loopMode = loopMode
        animationView.play()
    }
    
    
}
