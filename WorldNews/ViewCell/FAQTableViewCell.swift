//
//  FAQTableViewCell.swift
//  WorldNews
//
//  Created by Arman Merchant on 04/12/21.
//

import UIKit

class FAQTableViewCell: UITableViewCell {
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer: UILabel!
    
    var FAQ: FAQ?{
        didSet{
            setupFAQs(FAQ:FAQ)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    fileprivate func setupFAQs(FAQ:FAQ?){
        question.text = FAQ?.question
        answer.text = FAQ?.answer
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
