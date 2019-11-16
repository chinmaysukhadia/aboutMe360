//
//  QuestionsViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 18/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import MBCircularProgressBar

enum ProfileRate {
    
    case otherProfile
    case selfProfile
}


class QuestionsViewController: BaseViewController {
    
    //MARK: - IBOUtlets
    @IBOutlet weak var  questionsTableView: UITableView!
    @IBOutlet weak var progressView: MBCircularProgressBarView!
    @IBOutlet weak var countLabel: UILabel!
    
    //MARK: - Variables
    var arrayDataSource = [QuestionsDataModel]()
    var arraySelectedData = [QuestionsDataModel]()
    var questionsViewModel: QuestionsViewModel?
    var profileRate: ProfileRate = .otherProfile
    var dataDict = [String: String]()
    var catID: String?
    var ratedTo: String?
    var selectedIndex:IndexPath?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setuUp()
    }
    
    //MARK: - Private Methods
    
    private func setuUp() {
        self.registerCell()
        self.setupViewModel()
        progressView.value = CGFloat(1)
        countLabel.text = "1"
        if let tabbarViewController = AppDelegate.delegate()?.window?.rootViewController as? TabbarViewController {
            tabbarViewController.showHideCenteredButton()
        }
    }
    
    private func registerCell() {
        questionsTableView.register(nibs: [QuestionsCell.className])
    }
    
    // Set data model view
    private func setupViewModel() {
        
        questionsViewModel = QuestionsViewModel()
        if let dataSource = self.questionsViewModel?.getDataSource() {
            arrayDataSource = dataSource
            arraySelectedData.append(dataSource[0])
        }
    }
    
    func scrollToSelectedRow() {
        let selectedRows = self.questionsTableView.indexPathsForSelectedRows
        if let selectedRow = selectedRows?[0] {
            self.questionsTableView.scrollToRow(at: selectedRow as IndexPath, at: .top, animated: true)
        }
    }
    
    func otherRatingAPI() {
        
        self.questionsViewModel?.otherRatingAPI(paramDict: dataDict,completion: { (responseData, success) in
            
            if success {
                
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        })
    }
    
    func selfRatingAPI() {
        
        self.questionsViewModel?.selfRatingAPI(paramDict: dataDict,completion: { (responseData, success) in
            
            if success {
               
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        })
    }
    
    func updateRating() {
        
        let totalIndices = arraySelectedData.count - 1 // We get this value one time instead of once per iteration.
        
        for arrayIndex in 0...totalIndices {
            print(arraySelectedData[totalIndices - arrayIndex].title)
            let key = "q" + String(arrayIndex+1)
            
            dataDict[key] = Utilities.toString(object: arraySelectedData[totalIndices - arrayIndex].rating)
        }
        
        if profileRate == .selfProfile {
            self.selfRatingAPI()
        } else {
            dataDict[Constants.Keys.kIsInvited] = "1"
            dataDict[Constants.Keys.kTypeID] = "1"
            dataDict[Constants.Keys.kCatID] = catID
            dataDict[Constants.Keys.kRatedTO] = ratedTo
            self.otherRatingAPI()
        }
    }
    
    //
    func validateRating() {
        
        var isAdded = true
        
        for data in arraySelectedData {
            
            if data.rating == 0 {
                isAdded = false
            }
        }
        
        if isAdded {
            
            var isUpdate = false
            
            for data in arraySelectedData {
                
                if data.rating > 2 {
                    isUpdate = true
                }
            }
            
            if isUpdate  {
                self.updateRating()
            } else {
                Alert.showAlertWithActionWithColor(title: nil, message: "As per Artificial Intelligence (Al), the evaluation appears to be biased, hence being disqualified.\n\nPlease rate with honest feedback or avoid Rating this individual.", actionTitle: "OKAY ", showCancel: false) { (_ success) in
                    self.navigationController?.popToRootViewController(animated: false)
                    if let tabbarViewController = AppDelegate.delegate()?.window?.rootViewController as? TabbarViewController {
                        tabbarViewController.selectedIndex = 0
                        if let navVC = tabbarViewController.viewControllers?[0] as? UINavigationController {
                            navVC.popToRootViewController(animated: false)
                        }
                        tabbarViewController.showHideCenteredButton()
                    }
                }
            }
           
        }
    }
    
    //MARK: - IBAction
    
    @IBAction func backButoonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension QuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySelectedData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: QuestionsCell.className, for: indexPath) as? QuestionsCell {
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.delegate =  self
            cell.configureCell(cellData: arraySelectedData[indexPath.row])
            
            if indexPath.row == 0 || selectedIndex == indexPath {
                cell.transparentImageView.isHidden = true
                cell.ratingButton1.isUserInteractionEnabled = true
                cell.ratingButton2.isUserInteractionEnabled = true
                cell.ratingButton3.isUserInteractionEnabled = true
                cell.ratingButton4.isUserInteractionEnabled = true
                cell.ratingButton4.isUserInteractionEnabled = true
            } else {
                cell.transparentImageView.isHidden = false
                cell.ratingButton1.isUserInteractionEnabled = false
                cell.ratingButton2.isUserInteractionEnabled = false
                cell.ratingButton3.isUserInteractionEnabled = false
                cell.ratingButton4.isUserInteractionEnabled = false
                cell.ratingButton4.isUserInteractionEnabled = false
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedIndex == indexPath {
            selectedIndex = nil
        } else {
            selectedIndex = indexPath
        }
        
        Threads.performTaskInMainQueue {
            self.questionsTableView.reloadData()
        }
    }
    
}

extension QuestionsViewController: QuestionsCellDelegate {
    
    func didTapQuestionsCell(cell: QuestionsCell, rating: Int) {
        
        //
        guard let indexPath = self.questionsTableView.indexPath(for: cell) else {
            return
        }
        selectedIndex = nil

        let selectData =  arraySelectedData[indexPath.row]
        selectData.rating = rating
        arraySelectedData[indexPath.row] = selectData
        
        if indexPath.row == 0 {
            
            //
            var isAdded = false
            
            let addedIndex = arraySelectedData.count
            
            if arrayDataSource.count > addedIndex {
                
                let nextData = arrayDataSource[addedIndex]
                
                for data in arraySelectedData {
                    
                    if data.position == nextData.position {
                        isAdded = true
                    }
                }
            }
            
            if isAdded == false,arrayDataSource.count > addedIndex {
                arraySelectedData.insert(arrayDataSource[addedIndex], at: 0)
                let range = NSMakeRange(0, self.questionsTableView.numberOfSections)
                let sections = NSIndexSet(indexesIn: range)
                self.questionsTableView.reloadSections(sections as IndexSet, with: .automatic)
            }
            
           // self.questionsTableView.reloadData()
        }
        
        progressView.value = CGFloat(arraySelectedData.count)
        countLabel.text = String(arraySelectedData.count)
        
        if arraySelectedData.count == arrayDataSource.count {
            
            self.validateRating()
        }
        
    }
    
}
