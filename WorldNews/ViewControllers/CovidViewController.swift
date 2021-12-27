//
//  CovidViewController.swift
//  WorldNews
//
//  Created by Arman Merchant on 05/12/21.
//

import UIKit
import Lottie

class CovidViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        lottieAnimation()

        // Do any additional setup after loading the view.
    }
    

//    func lottieAnimation(){
//
//        let animationView = AnimationView(name: "orderfailed")
//        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 700)
//        animationView.center = self.view.center
//        animationView.contentMode = .scaleAspectFit
//        view.addSubview(animationView)
//        animationView.play()
//        animationView.loopMode = .loop
//    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CommonUtils.playLottieAnimation(fileName: "orderfailed", animationView: animationView, loopMode: .loop)
    }
    
}
