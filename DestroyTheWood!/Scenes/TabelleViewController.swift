//
//  TabelleViewController.swift
//  DestroyTheWood!
//
//  Created by Tony Borchert on 06.05.20.
//  Copyright © 2020 Tony Borchert. All rights reserved.
//

import UIKit

class TabelleViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControl: SelectSegmentedControl!
    @IBOutlet weak var segmentedControlMitOhne: SelectSegmentedControl!
    
    var highscore = 0
    
    var dataSource:[EigeneCell]
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        dataSource = getTabelle()!
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder: NSCoder) {
        dataSource = getTabelle()!
        highscore = userDefaults.integer(forKey: KeysForUserDefaults.highscore)
        print(highscore)
        super.init(coder: coder)
            overrideUserInterfaceStyle = .light
        //        for i in 0...9 {
        //            addToTabelle(EigeneCell(date: Date(), score: 200 + i * 100))
        //        }
                
                
        //fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        segmentedControllValueChanged(nil)
        //tableView.allowsSelection = false
        //tableView.allowsMultipleSelection = true
        
       
    }
    
    @IBAction func segmentedControllValueChanged(_ sender: UISegmentedControl?) {
        var sortType:SortType!
        var mit:Bool!
        if sender == nil {
            if !isKeyPresentInUserDefaults(key: KeysForUserDefaults.lastSegmentedControlValue) {
                
            } else {
                sortType = SortType(rawValue: userDefaults.integer(forKey: KeysForUserDefaults.lastSegmentedControlValue))
                segmentedControl.selectedSegmentIndex = sortType.rawValue
                
                
                mit = SortType(rawValue: userDefaults.integer(forKey: KeysForUserDefaults.lastSegmentedControlValueForWithoutZero))!.rawValue == 0
                segmentedControlMitOhne.selectedSegmentIndex = mit ? 0 : 1
                //print(sortType!)
                
            }
        } else {
            if sender! == segmentedControl {
                userDefaults.set(sender!.selectedSegmentIndex, forKey: KeysForUserDefaults.lastSegmentedControlValue)
                sortType = SortType(rawValue: sender!.selectedSegmentIndex)
            } else {
                userDefaults.set(sender!.selectedSegmentIndex, forKey: KeysForUserDefaults.lastSegmentedControlValueForWithoutZero)
                        mit = sender!.selectedSegmentIndex == 0
            }
            
            
            
        }
        dataSource = getTabelle()!
        switch SortType(rawValue:userDefaults.integer(forKey: KeysForUserDefaults.lastSegmentedControlValue ))! {
            
            case .letztes:
            break
            case .erstes:
            dataSource = dataSource.reversed()
            case .niedrig:
            dataSource.sort { (first, second) -> Bool in
                return first.score > second.score
            }
            case .hoch:
            dataSource.sort { (first, second) -> Bool in
                return first.score < second.score
            }
        }
//            if sortType! == .erstes {
//
//            } else if sortType! == .letztes {
//
//            } else if sortType! == .hoch {
//
//            } else {
//
//            }
        
        
        if userDefaults.integer(forKey: KeysForUserDefaults.lastSegmentedControlValueForWithoutZero) == 0 {
            dataSource.removeAll { (eigeneCell) -> Bool in
                eigeneCell.score == 0
            }
        }
        tableView.reloadData()
    }
    
//    @IBAction func mitOderOhneClicked(_ sender: UISegmentedControl?) {
//        var sortType = 0
//        if sender == nil {
//            if !isKeyPresentInUserDefaults(key: KeysForUserDefaults.lastSegmentedControlValueForWithoutZero) {
//                userDefaults.set(0, forKey: KeysForUserDefaults.lastSegmentedControlValueForWithoutZero)
//            }
//            sortType = userDefaults.integer(forKey: KeysForUserDefaults.lastSegmentedControlValueForWithoutZero)
//            segmentedControlMitOhne.selectedSegmentIndex = sortType
//        } else {
//            userDefaults.set(sender!.selectedSegmentIndex, forKey: KeysForUserDefaults.lastSegmentedControlValue)
//            sortType = sender!.selectedSegmentIndex
//        }
//        //segmentedControllValueChanged(nil)
//        if sortType == 0 {
//            dataSource.removeAll { (eigeneCell) -> Bool in
//                eigeneCell.score == 0
//            }
//        } else {
//            dataSource = getTabelle()!
//            segmentedControllValueChanged(nil)
//        }
//        tableView.reloadData()
//
//    }
    
    @IBAction func backButton_tapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    

}
extension TabelleViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let allEigeneCells = getTabelle()!
        let singleEigeneCell = dataSource[(dataSource.count - 1) - (indexPath[1])]
        
        //une fprint(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "eigeneTableViewCell")
        cell?.detailTextLabel?.text = singleEigeneCell.dateInString
        cell?.textLabel?.text = String(singleEigeneCell.score)
        if singleEigeneCell.score == highscore {
            print("highscoreFound")
            cell?.backgroundColor = UIColor(red: 0.7373, green: 0.2863, blue: 0.0667, alpha: 1.0)
            //cell?.backgroundColor = UIColor(red: 0.0627, green: 0.6588, blue: 0.4588, alpha: 1.0)
        } else {
            cell?.backgroundColor = UIColor(red: 0.8588, green: 0.3294, blue: 0, alpha: 1.0) /* #db5400 */
        }
        if let cell = cell {
            return cell
        } else {
            print("failed to make cell")
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        selectionFeedbackGenerator.selectionChanged()
        print("halal")
        playSound(called: AudioIdentifiers.button)
    }
}

enum SortType:Int {
    case letztes = 0
    case erstes = 1
    case niedrig = 2
    case hoch = 3
}
