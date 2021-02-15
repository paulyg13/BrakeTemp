//
//  DetailViewController.swift
//  737Brake
//
//  Created by Paul Galea on 2020-04-26.
//  Copyright © 2020 Paul Galea. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //Views
    @IBOutlet weak var enterParameters: UIView!
    @IBOutlet weak var notWithinChart: UIView!
    
    //Autbrake Labels
    @IBOutlet weak var autoBrakeLabel: UILabel!
    
    @IBOutlet weak var otherAutobrakeSetting1: UILabel!
    @IBOutlet weak var otherAutobrakeSetting2: UILabel!
    @IBOutlet weak var otherAutobrakeSetting3: UILabel!
    @IBOutlet weak var otherAutobrakeSetting4: UILabel!
    
    
    //autobrake value
    @IBOutlet weak var otherAutobrakeLabel1: UILabel!
    @IBOutlet weak var otherAutobrakeLabel2: UILabel!
    @IBOutlet weak var otherAutobrakeLabel3: UILabel!
    @IBOutlet weak var otherAutobrakeLabel4: UILabel!
    
    @IBOutlet weak var autobrakeStack: UIStackView!
    
    
    
    @IBOutlet weak var coolingTimeAirLabel: UILabel!
    @IBOutlet weak var coolingTimeGroundLabel: UILabel!
    @IBOutlet weak var brakeMessageLabel: UILabel!
    var userData: ActualNums? {
        didSet {
            // DispatchQueue.main.async {
            self.refreshUI()
            // }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        // Do any additional setup after loading the view.
        
    }
    
    private func refreshUI() {
        loadViewIfNeeded()
        enterParameters?.isHidden = true
        notWithinChart?.isHidden = true
        
        
        if userData!.primaryCoolingTime != nil {
            
            //=====================
            //Update Cooling labels
            coolingTimeGroundLabel.textColor = UIColor.label
            coolingTimeAirLabel.textColor = UIColor.label
            
            //COOLING TIME AIR AND GROUND SECTION
            if let coolingAirText = userData?.primaryCoolingTime?.brakeCoolingTimeAir {
                coolingTimeAirLabel.text = coolingAirText
                
            } else {
                coolingTimeAirLabel.text = "-"
            }
            
            if let coolingGroundText = userData?.primaryCoolingTime?.brakeCoolingTimeGround {
                coolingTimeGroundLabel.text = coolingGroundText
            } else {
                coolingTimeGroundLabel.text = "-"
            }
            
            //If there is a brake cooling message
            if let brakeCoolingMsg = userData?.primaryCoolingTime?.brakeCoolingMsg, let brakeCoolingMsgDetails = userData?.primaryCoolingTime?.brakeCoolingMsgDetails {
                coolingTimeGroundLabel.text = brakeCoolingMsg
                coolingTimeAirLabel.text = brakeCoolingMsg
                
                if brakeCoolingMsg == k.brakeCoolingMsgCaution {
                    coolingTimeGroundLabel.textColor = .systemYellow
                    coolingTimeAirLabel.textColor = .systemYellow
                } else if brakeCoolingMsg == k.brakeCoolingMsgMelt {
                    coolingTimeGroundLabel.textColor = .red
                    coolingTimeAirLabel.textColor = .red
                }
                
                brakeMessageLabel.text = brakeCoolingMsgDetails
                brakeMessageLabel.textAlignment = .center
            } else {
                brakeMessageLabel.text = ""
            }
            //Display Alternate possibilities
            updateAlternateAutobrakeLabels()
            
        } else {
            print("Too high for chart")
            notWithinChart?.isHidden =  false
        }
    }
    
    //MARK: - Updating Alternate Autobrake Labels
    func updateAlternateAutobrakeLabels() {
        let timeArray = [otherAutobrakeLabel1, otherAutobrakeLabel2, otherAutobrakeLabel3, otherAutobrakeLabel4]
        let otherAutobrakeSettingArray = [otherAutobrakeSetting1, otherAutobrakeSetting2, otherAutobrakeSetting3, otherAutobrakeSetting4]
        
        //Update Setting actually used
        autoBrakeLabel.text = userData?.primaryCoolingTime?.autobrake
        
        if let coolingTimeArray = userData?.coolingTimeArray {
            if coolingTimeArray.count == 0 {
                autobrakeStack.isHidden = true
            }   else {
                autobrakeStack.isHidden = false
                for (i, coolingArray) in coolingTimeArray.enumerated() {
                    if let coolingTime = coolingArray.brakeCoolingTimeGround {
                        timeArray[i]?.text = coolingTime
                    } else if let coolingTime = coolingArray.brakeCoolingMsg {
                        if coolingTime == k.noSpecialProcedureMsg {
                            timeArray[i]?.text = "No Procedure Required"
                        } else {
                            timeArray[i]?.text = coolingTime
                        }
                    } else {
                        timeArray[i]?.text = "-"
                    }
                    otherAutobrakeSettingArray[i]?.text = coolingArray.autobrake
                }
            }
        }
    }
    
    
    
    
}

//MARK: - Extensions
extension DetailViewController: actualNumsDelegate {
    func resetForm() {
        enterParameters?.isHidden = false
    }
    
    func submittedData(_ actualNums: ActualNums) {
        userData = actualNums
    }
    
}

