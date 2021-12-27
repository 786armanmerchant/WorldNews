//
//  CricketViewController.swift
//  WorldNews
//
//  Created by Arman Merchant on 05/12/21.
//

import UIKit

class CricketViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @Published var matches = [Match]()
    var filteredMatches = [Match]()
    override func viewDidLoad() {
        super.viewDidLoad()
//        setNavBarTintColor(color: #colorLiteral(red: 0, green: 0.5209681392, blue: 0.706921041, alpha: 1), titleColor: .white)
//        hideNavBar(false, animated: true)
        uiSetup()
        setupTableView()
        fetchMatches()
    }
    //MARK:- UI
    fileprivate func uiSetup(){
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    //MARK:- Tableview setup
    fileprivate func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        segmentControl.selectedSegmentIndex = 0
    }
    //MARK:- Segment Actions
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            loadOnedayMatches()
        case 1:
            loadT20Matches()
        default:
            loadTestMatches()
        }
    }
    //MARK:- Load Premium policies
    fileprivate func loadOnedayMatches(){
        filterMatches(.oneday)
    }
    //MARK:- Load Cheapest policies
    fileprivate func loadT20Matches(){
        filterMatches(.t20)
    }
    //MARK:- Load Moderate policies
    fileprivate func loadTestMatches(){
        filterMatches(.test)
    }
    //MARK:- Filter
    fileprivate func filterMatches(_ type: MatchType){
        filteredMatches = matches.filter({$0.type == type.rawValue})
        reloadTableView()
    }
    //MARK:- Reload
    fileprivate func reloadTableView(){
        tableView.reloadData()
    }
    //MARK:- Fetch Policies
    fileprivate func fetchMatches(){
        WNFirestore.db.collection(FirestoreKeys.matches).addSnapshotListener { querySnapshot, Error in
            guard let documents = querySnapshot?.documents else { return }
            self.matches = documents.compactMap({ (querySnapshot)-> Match? in
               return try? querySnapshot.data(as: Match.self)
            })
            self.filteredMatches = self.matches
            self.loadOnedayMatches()
        }
    }
    //MARK:- Navigation
    
    @objc fileprivate func navigateToScore(){
        guard let eligibilityVC = CommonUtils.getViewController(id: "ScoreViewController")   as? ScoreViewController else {
            return
        }
        navigationController?.pushViewController(eligibilityVC, animated: true)
    }
}

extension CricketViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMatches.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CricketTableViewCell", for: indexPath) as? CricketTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.match = filteredMatches[indexPath.row]
        cell.checkScoreButton.addTarget(self, action: #selector(navigateToScore), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

