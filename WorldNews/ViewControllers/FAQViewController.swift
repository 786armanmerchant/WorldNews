//
//  FAQViewController.swift
//  WorldNews
//
//  Created by Arman Merchant on 04/12/21.
//

import UIKit

class FAQViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var FAQ: [FAQ]?//FAQModel?
    var sqliteModel = DBHelper()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        setDataSourceAndUI()
        addRightBarButton()
//        setBackButton()
//        setNavBarTintColor(color: #colorLiteral(red: 0, green: 0.5209681392, blue: 0.706921041, alpha: 1), titleColor: .white)
//        navigationController?.setNavi
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setDataSourceAndUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        fetchData()
    }
    
    func addRightBarButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigateToAddFAQVC))
    }
   @objc fileprivate func navigateToAddFAQVC(){
    guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddFAQViewController") as? AddFAQViewController else { return}
    vc.delegate = self
    vc.pageTitle = "Add FAQ"
    vc.buttonTitle = "Add"

    let navVC = UINavigationController(rootViewController: vc)
    self.present(navVC, animated: true, completion: nil)
    }
    fileprivate func fetchData(){
        FAQ = sqliteModel.read()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    fileprivate func updateData(FAQ:FAQ){
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddFAQViewController") as? AddFAQViewController else { return}
        vc.delegate = self
        vc.FAQ = FAQ
        vc.pageTitle = "Edit FAQ"
        vc.buttonTitle = "Edit"
        let navVC = UINavigationController(rootViewController: vc)
        self.present(navVC, animated: true, completion: nil)

    }
    fileprivate func deleteFAQ(id:Int){
        sqliteModel.deleteItem(id: id)
        FAQ?.removeAll()
        fetchData()
    }
}

extension FAQViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FAQ?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FAQTableViewCell") as? FAQTableViewCell else {
            return UITableViewCell()
        }
        
        cell.FAQ = FAQ?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }

    @available(iOS 11.0, *)
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            guard let id = self.FAQ?[indexPath.row].id else { return }
            self.deleteFAQ(id: id)
            completionHandler(true)
        }

        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, sourceView, completionHandler) in
            guard let faq = self.FAQ?[indexPath.row] else { return }
            self.updateData(FAQ: faq)
            completionHandler(true)
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [edit, delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
}

extension FAQViewController: AddFAQDelegate {
    func didAddedItem(question: String, answer: String) {
        sqliteModel.insert(question: question, answer: answer)
        FAQ?.removeAll()
        fetchData()
    }
    func didUpdatedItem(id: Int, question: String, answer: String) {
        sqliteModel.update(id: id, question: question, answer: answer)
        FAQ?.removeAll()
        fetchData()
    }
}
