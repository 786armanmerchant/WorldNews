//
//  CricketTableViewCell.swift
//  WorldNews
//
//  Created by Arman Merchant on 05/12/21.
//

import UIKit

class CricketTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var matchName: UILabel!
    
    @IBOutlet weak var matchScore: UILabel!
    
    @IBOutlet weak var checkScoreButton: UIButton!
    var match: Match?{
        didSet{
          setupMatchCell(match: match)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        container.addShadow()
        checkScoreButton.makeStarndard(borderWidth: 1, borderColor: .black)
    }
    
    fileprivate func setupMatchCell(match:Match?){
        matchName.text = match?.name
        matchScore.text = match?.score
    }
}
