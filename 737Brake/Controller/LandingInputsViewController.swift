//
//  MasterViewControllerTableViewController.swift
//  737Brake
//
//  Created by Paul Galea on 2020-04-26.
//  Copyright © 2020 Paul Galea. All rights reserved.
//

import UIKit
import Eureka

protocol actualNumsDelegate: class {
    func submittedData(_ actualNums: ActualNums)
    func resetForm()
}

class LandingInputsViewController: FormViewController, UISplitViewControllerDelegate {
    
    weak var delegate: actualNumsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Max Calculator"
        splitViewController?.delegate = self
        createForm()
    }
    

}


//MARK: - Creating Form
extension LandingInputsViewController {
    func createForm() {
        
        let speedArray: [Int] = Array(80...180)
        let windArray: [Int] = Array(-20...40)
        
        LabelRow.defaultCellUpdate = { cell, row in
            cell.contentView.backgroundColor = .red
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
            cell.textLabel?.textAlignment = .right
            
        }
        
        //        let formatter = NumberFormatter()
        //        formatter.maximumFractionDigits = 1
        //        formatter.maximumSignificantDigits = 3
        
        form
            +++ Section()
            <<< IntRow(k.weight){
                $0.title = "Weight (Kg)"
                $0.placeholder = "Min: 40000 Max: 90000"
                $0.add(rule: RuleRequired(msg: "Weight is required"))
                $0.add(rule: RuleSmallerOrEqualThan(max: 90000, msg: "Maximum Weight is 90,000Kg"))
                $0.add(rule: RuleGreaterOrEqualThan(min: 40000, msg: "Minimum Weight is 40,000Kg"))
                $0.validationOptions = .validatesOnBlur
                //                $0.formatter = formatter
                //                $0.useFormatterDuringInput = false
                //                $0.useFormatterOnDidBeginEditing = false
            }.onRowValidationChanged { cell, row in
                let rowIndex = row.indexPath!.row
                while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
                    row.section?.remove(at: rowIndex + 1)
                }
                if !row.isValid {
                    for (index, validationMsg) in row.validationErrors.map({ $0.msg }).enumerated() {
                        let labelRow = LabelRow() {
                            $0.title = validationMsg
                            $0.cell.height = { 30 }
                        }
                        let indexPath = row.indexPath!.row + index + 1
                        row.section?.insert(labelRow, at: indexPath)
                    }
                }
            }
            //    +++ Section("Positve for Headwind / Negative for Tailwind")
            +++ Section()
            <<< PickerInlineRow<Int>(k.brakesOnSpeed) {
                $0.title = "Brake on Speed (Kts)"
                $0.value = 140
                $0.add(rule: RuleRequired(msg: "Brakes on Speed is required"))
                $0.validationOptions = .validatesOnDemand
                $0.options = speedArray
            }
            <<< SwitchRow("groundSpeedTag"){
                $0.title = "Ground Speed Used"
                $0.value = false
            }
            <<< StepperRow(k.taxiDistance) {
                $0.title = "Taxi Distance (mi)"
                $0.value = 1.0
                $0.add(rule: RuleRequired(msg: "Taxi Distance is required"))
                $0.validationOptions = .validatesOnDemand
                self.tableView.rowHeight = 45.0
            }.cellSetup { cell, row in
                cell.stepper.maximumValue = 10.0
                cell.stepper.minimumValue = 0.0
                cell.stepper.stepValue = 0.5
            }
            +++ Section() {
                $0.hidden = Condition.function(["groundSpeedTag"], { form in
                    return ((form.rowBy(tag: "groundSpeedTag") as? SwitchRow)?.value ?? false)
                })}
            <<< PickerInlineRow<Int>(k.wind) {
                $0.title = "Headwind (Kts)"
                $0.value = 0
                $0.add(rule: RuleRequired(msg: "Wind is required when not using Groundspeed"))
                $0.validationOptions = .validatesOnDemand
                $0.options = windArray
            }
            
            <<< IntRow(k.elevation) {
                $0.title = "Elevation (ft)"
                $0.placeholder = "Min: 0 Max: 14500"
                $0.add(rule: RuleRequired(msg: "Elevation is required when not using Groundspeed"))
                $0.add(rule: RuleSmallerOrEqualThan(max: 14500, msg: "Maximum Elevations is 14500"))
                $0.add(rule: RuleGreaterOrEqualThan(min: 0, msg: "Minimum Elevation is 0"))
                $0.validationOptions = .validatesOnDemand
            }.onRowValidationChanged { cell, row in
                if let rowIndex = row.indexPath?.row {
                    while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
                        row.section?.remove(at: rowIndex + 1)
                    }
                    if !row.isValid {
                        for (index, validationMsg) in row.validationErrors.map({ $0.msg }).enumerated() {
                            let labelRow = LabelRow() {
                                $0.title = validationMsg
                                $0.cell.height = { 30 }
                            }
                            if let newindexPath = row.indexPath?.row {
                                let indexPath = newindexPath + index + 1
                                row.section?.insert(labelRow, at: indexPath) }
                        }
                    }
                }}
            
            //            .onRowValidationChanged { cell, row in
            //                if let rowIndex = row.indexPath?.row{
            //                while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
            //                    row.section?.remove(at: rowIndex + 1)
            //                }
            //                if !row.isValid {
            //                    for (index, validationMsg) in row.validationErrors.map({ $0.msg }).enumerated() {
            //                        let labelRow = LabelRow() {
            //                            $0.title = validationMsg
            //                            $0.cell.height = { 30 }
            //                        }
            //                        let indexPath = row.indexPath!.row + index + 1
            //                        row.section?.insert(labelRow, at: indexPath)
            //                    }
            //                    }}
            //            }
            <<< IntRow(k.temperature){
                $0.title = "OAT (ºC)"
                $0.add(rule: RuleRequired(msg: "OAT is required when not using Groundspeed"))
                $0.add(rule: RuleSmallerOrEqualThan(max: 50, msg: "Maximum Temperature is 50"))
                $0.add(rule: RuleGreaterOrEqualThan(min: 0, msg: "Minimum Temperature is 0"))
                $0.placeholder = "Min: 0 Max: 50"
                $0.validationOptions = .validatesOnDemand
                
            }.onRowValidationChanged { cell, row in
                if let rowIndex = row.indexPath?.row {
                    while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
                        row.section?.remove(at: rowIndex + 1)
                    }
                    if !row.isValid {
                        for (index, validationMsg) in row.validationErrors.map({ $0.msg }).enumerated() {
                            let labelRow = LabelRow() {
                                $0.title = validationMsg
                                $0.cell.height = { 30 }
                            }
                            if let newindexPath = row.indexPath?.row {
                                let indexPath = newindexPath + index + 1
                                row.section?.insert(labelRow, at: indexPath) }
                        }
                    }
                }}
            
            +++ Section()
            <<< ActionSheetRow<String>(k.autobrake) {
                $0.title = "Autobrake"
                $0.value = "Autobrake 3"
                $0.options = k.autobrakeOptions
                $0.add(rule: RuleRequired(msg: "Autobrake is Required"))
                $0.validationOptions = .validatesOnDemand
                
            }
            <<< SegmentedRow<String>(k.reverse) {
                // $0.title = "Reverse Thrust"
                $0.value = "Two-Engine Reverse"
                $0.options = ["Two-Engine Reverse", "No Reverse"]
                $0.add(rule: RuleRequired(msg: "Reverse is required"))
                $0.validationOptions = .validatesOnDemand
            }
            +++ Section()
            <<< ButtonRow() {
                $0.title = "Calculate" 
                // $0.disabled = Condition.function(
                //   form.allRows.compactMap { $0.tag }, // All row tags
                // { !$0.validate().isEmpty }) // Form has no validation errors
                $0.cell.height = {60}
            }.onCellSelection { [weak self] (cell, row) in
                if row.section?.form?.validate().count == 0{
                    self!.submitButtonPressed()
                }}
            <<< ButtonRow() {
                $0.title = "Reset"
                $0.cell.height = {50}
            }.onCellSelection({ (cell, row) in
                self.form.removeAll()
                self.createForm()
                self.resetInputParameter()
                //self.resetAllField()
            })
        //  print(form.validate().count)
    }
}

//MARK: - Form Submit and Reset
extension LandingInputsViewController {
    
    func resetInputParameter() {
        delegate?.resetForm()
    }
    
    //    func resetAllField() {
    //        //Set Each default value
    //        self.form.setValues(k.defaultValues)
    //
    //        //For each form item, reload after default set
    //        for (key, _) in k.defaultValues {
    //            resetFieldByTag(key)
    //        }
    //    }
    
    //Reload each form item by tag
    func resetFieldByTag(_ tag: String) {
        let fieldToReset = self.form.rowBy(tag: tag)
        fieldToReset?.reload()
    }
    
    func submitButtonPressed() {
        
        let submittedValues = form.values()
        
        //Groundspeed
        let groundSpeed: Bool = submittedValues["groundSpeedTag"]! as! Bool
       
        //Weight
        var weight: Double {
            let rawWeight = submittedValues[k.weight]! as! Int
            return Double(rawWeight) / 1000.00
        }
        
        //Bos
        var bos: Int {
            let rawBos:Int = submittedValues[k.brakesOnSpeed]! as! Int
            
            if let wind = submittedValues[k.wind] as? Int {
                if wind > 0 {
                    return (Int(Double(rawBos) - (Double(wind)/2.0)))
                 //   print(actualNums.brakesOnSpeed)
                } else {
                    return (Int(Double(rawBos) + (Double(abs(wind)) * 1.5)))
            }
            } else {
            return rawBos
            }
        }

        //Pressure Altitude
        var pressureAltitude: Double {
            
            if let rawPressureAltitude = (submittedValues[k.elevation] as? Int) {
            return (Double(rawPressureAltitude)/1000)
            } else {
                return 0.0
        }
        }
        
        //Temperature
        var temperature: Int {
         return submittedValues[k.temperature] as? Int ?? 15
        }
        
        //Reverse
        var reverse: Bool {
            let rawReverse = submittedValues[k.reverse] as! String
            
            if rawReverse == "Two-Engine Reverse" {
                return true
            } else {
                return false
            }
        }
             
        //Autobrake
        let autobrake = submittedValues[k.autobrake]! as! String
        
        //Taxi
        let taxi = submittedValues[k.taxiDistance] as! Double
        
        
        
        let actualNums = ActualNums(weight: weight, pressureAltitude: pressureAltitude, brakesOnSpeed: bos, taxiDistance: taxi, temperature: temperature, autobrake: autobrake, groundspeed: groundSpeed, reverse: reverse)
        
        delegate?.submittedData(actualNums)
        
        if
            let detailViewController = delegate as? DetailViewController,
            let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
        
    }
}
