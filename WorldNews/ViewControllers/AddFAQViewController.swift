//
//  AddFAQViewController.swift
//  WorldNews
//
//  Created by Arman Merchant on 04/12/21.
//

import UIKit


protocol AddFAQDelegate:NSObject {
    func didAddedItem(question:String, answer:String)
    func didUpdatedItem(id:Int, question:String, answer:String)
}

class AddFAQViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var answerTextField: UITextField!
    
    
    @IBOutlet weak var addButton: UIButton!
    
    weak var delegate:AddFAQDelegate?
    var FAQ:FAQ?
    var pageTitle:String?
    var buttonTitle:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "Add FAQ"
        addButton.makeStarndard()
        setupUI()
        if let faq = FAQ{
            questionTextField.text = faq.question
            answerTextField.text = faq.answer
        }
    }
    fileprivate func setupUI(){
        title = pageTitle ?? ""
        addButton.setTitle(buttonTitle ?? "", for: .normal)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func addButtonClicked(_ sender: Any)  {
        if !(questionTextField.text?.isEmpty ?? true) && !(answerTextField.text?.isEmpty ?? true){
            self.dismiss(animated: true) {
                if let faq = self.FAQ{
                    self.delegate?.didUpdatedItem(id: faq.id!, question: self.questionTextField.getText(), answer: self.answerTextField.getText())
                }else{
                    self.delegate?.didAddedItem(question: self.questionTextField.getText(), answer: self.answerTextField.getText())
                }
            }
        }
    }
}




extension UIButton {
    
    func makeStarndard(radius: CGFloat = 10, borderWidth: CGFloat = 0, borderColor:UIColor = .white){
        layer.cornerRadius = radius
        layer.masksToBounds = true
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}


