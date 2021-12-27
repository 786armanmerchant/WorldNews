//
//  FAQModel.swift
//  WorldNews
//
//  Created by Arman Merchant on 04/12/21.
//

import Foundation


class FAQModel: NSObject {
    var faqs:[FAQ]?
    func initArrays(ques:[String],answs:[String]) {
        var faqsArr = [FAQ]()
        for (index, item) in ques.enumerated(){
            let model = FAQ()
            model.initValues(ques: item, ans: answs[index])
            faqsArr.append(model)
        }
        faqs = faqsArr
    }
}
class FAQ: NSObject{
    var id:Int?
    var question:String?
    var answer:String?
    func initValues(ques:String?, ans: String?) {
//        self.id = id
        question = ques
        answer = ans
    }
}
