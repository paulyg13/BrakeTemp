//
//  InputModel.swift
//  737Brake
//
//  Created by Paul Galea on 2020-04-27.
//  Copyright © 2020 Paul Galea. All rights reserved.
//

import Foundation

struct ActualNums {
    let weight: Double
    let pressureAltitude: Double
    let brakesOnSpeed: Int
    let taxiDistance: Double
    let temperature: Int
    let autobrake: String
    let reverse: Bool
    let groundspeed: Bool
    var primaryCoolingTime: CoolingTime?
    var coolingTimeArray: [CoolingTime]?
    
    
    init(weight: Double, pressureAltitude: Double, brakesOnSpeed: Int, taxiDistance: Double, temperature: Int, autobrake: String, groundspeed: Bool, reverse: Bool) {
        self.weight = weight
        self.pressureAltitude = pressureAltitude
        self.brakesOnSpeed = brakesOnSpeed
        self.taxiDistance = taxiDistance
        self.temperature = temperature
        self.autobrake = autobrake
        self.groundspeed = groundspeed
        self.reverse = reverse
        
        //DEBUGGING TESTING
        print("actual weight is: \(weight)")
        print("actual pa is: \(pressureAltitude)")
        print("actual bos is: \(brakesOnSpeed)")
        print("actual taxi is: \(taxiDistance)")
        print("actual temperature is: \(temperature)")
        print("actual autobrake is: \(autobrake)")
        print("actual reverse is: \(reverse)")
        print("actual groundspeed is: \(groundspeed)")
        
        //========================
        
        // Is the Rounded up values (highest possible Table 1 brake energy) on the chart so we can compute something?
        var worstCase: Bool {
            get {
                let table1 = Table1()
                if (table1.getBrakeEnergy(weight: (weightRange[1]), bos: (brakesOnSpeedRange[1]), pa: (pressureAltitudeRange[1]), temp: temperatureRange[1])) == nil {
                    return false
                } else {
                    print("Worst Case is: \(table1.getBrakeEnergy(weight: (weightRange[1]), bos: (brakesOnSpeedRange[1]), pa: (pressureAltitudeRange[1]), temp: temperatureRange[1]))")
                    return true
                }
            }
        }
        
        
        //CREATE ALL THE RANGE DYNAMIC VARIABLES
        var weightRange: [Int] {
            let rangeWeight = Int(weight)
            //  print("rangeweight is: \(rangeWeight)")
            switch weight {
            case 40.001..<50.000:
                return [40,50]
            //       print(self.weightRange)
            case 50.001..<60.000:
                return [50,60]
            //         print(weightRange)
            case 60.001..<70.000:
                return [60,70]
            //         print(weightRange)
            case 70.001..<80.000:
                return [70,80]
            //            print(weightRange)
            case 80.001..<90.000:
                return [80,90]
            //          print(weightRange)
            default:
                //   print("Exact weight")
                return [rangeWeight, rangeWeight]
                //   print(weightRange)
                //  weight.append(contentsOf: [rangeWeight/1000,rangeWeight/1000])
                
                //print(weight)
                
            }
        }
        var pressureAltitudeRange: [Double] {
            get {
                let pa = pressureAltitude
                switch pa {
                case 0.001..<5.0:
                    return [0,5]
                    // print(pressureAltitudeRange)
                    // pressureAltitude?.append(contentsOf: [0,5])
                //print(pressureAltitude!)
                case 5.001..<10.0:
                    return [5,10]
                    // print(pressureAltitudeRange)
                    
                case 10.001..<12.0:
                    return [10,12]
                    // print(pressureAltitudeRange)
                    
                case 12.001..<14.5:
                    return [12,14.5]
                    //print(pressureAltitudeRange)
                    
                default:
                    //  print("exact pa")
                    return [pa, pa]
                    //print("exact pressure alt")
                }
            }
        }
        var brakesOnSpeedRange: [Int] {
            get {
                let bos = brakesOnSpeed
                switch bos {
                case ..<80:
                    //   print(self.brakesOnSpeedRange)
                    return [80,80]
                case 81..<100:
                    //   print(brakesOnSpeedRange)
                    return [80,100]
                case 101..<120:
                    //   print(brakesOnSpeedRange)
                    return [100,120]
                case 121..<140:
                    //   print(brakesOnSpeedRange)
                    return[120,140]
                case 141..<160:
                    //   print(brakesOnSpeedRange)
                    return [140,160]
                case 161..<180:
                    //     print(brakesOnSpeedRange)
                    return [160,180]
                case 181...:
                    //       print(brakesOnSpeedRange)
                    return [180,180]
                default:
                    //    print("exact bos")
                    return [bos, bos]
                    //   print(brakesOnSpeedRange)
                }
            }
        }
        var temperatureRange: [Int] {
            get {
                let temp = temperature
                switch temp {
                case 1..<10:
                    return [0, 10]
                //print(temperatureRange)
                case 11..<15:
                    return [10, 15]
                    // print(temperatureRange)
                    
                case 16..<20:
                    return [15, 20]
                    // print(temperatureRange)
                    
                case 21..<30:
                    return [20, 30]
                //  print(temperatureRange)
                case 31..<40:
                    return [30, 40]
                //print(temperatureRange)
                case 41..<50:
                    return [40, 50]
                    //print(temperatureRange)
                    
                default:
                    // print ("exact temp")
                    return [temp, temp]
                    // print("exact temp")
                }
            }
        }
        
        
        
        
        
        //If all values are on the chart, then we can determine Cooling Times.
        if worstCase {
            var tempCoolingTimeArray: [CoolingTime] = []
            let table2 = Table2()
            var primaryIsRTO = false
            
            var table2Range: [Int] {
                get {
                    let brakeTemp = Int(table1Energy)
                    switch brakeTemp {
                    case 1..<10:
                        return [0, 10]
                    //print(table2Range)
                    case 11..<20:
                        return [10, 20]
                    // print(table2Range)
                    case 21..<30:
                        return[20, 30]
                    //print(table2Range)
                    case 31..<40:
                        return [30, 40]
                    // print(table2Range)
                    case 41..<50:
                        return [40, 50]
                    // print(table2Range)
                    case 51..<60:
                        return [50, 60]
                    // print(table2Range)
                    default:
                        return [brakeTemp, brakeTemp]
                        
                    }
                }
            }
            
            
            for (index,element) in k.autobrakeOptions.enumerated() {
                //Setting is primary
                if index == (k.autobrakeOptions.firstIndex(of: autobrake)!) {
                    let  primaryTable2 = table2.getTable2Energy(table1Energy: table2Range[1], reverseUsed: reverse, indexForAutobreak: (index))
                    primaryCoolingTime = CoolingTime(reverseUsed: reverse, autobrake: element, table2Energy: primaryTable2)
                    if element == k.autobrakeOptions[0] {
                        //print("Element is: \(element)")
                        primaryIsRTO = true
                    }
                    //IF Setting used is not RTO and is not Primary then...
                } else if index != (k.autobrakeOptions.firstIndex(of: autobrake)!) && element != k.autobrakeOptions[0] && !primaryIsRTO {
                    //TABLE 2 VALUES
                    let table2Value = table2.getTable2Energy(table1Energy: table2Range[1], reverseUsed: reverse, indexForAutobreak: (index))
                    tempCoolingTimeArray.append(CoolingTime(reverseUsed: reverse, autobrake: element, table2Energy: table2Value))
                    
                }
            }
            coolingTimeArray = tempCoolingTimeArray
        } else {
            //coolingTimeArray = nil
            //primaryCoolingTime = nil
        }
        
        
        //Create Every Possible brake energy
        var brakeEnergyList: [Double] {
            get {
                let table1 = Table1()
                var tempEnergyList: [Double] = []
                for w in weightRange {
                    for b in brakesOnSpeedRange {
                        for p in pressureAltitudeRange {
                            for t in temperatureRange {
                                tempEnergyList.append(table1.getBrakeEnergy(weight: w, bos: b, pa: p, temp: t)!)
                            }
                        }
                    }
                }
                return tempEnergyList
            }
        }
        
        //Create Table1 Energy Value (by taking all brake energies (brakeenergylist), and interpolating down to 1 value. Then adjusting value for taxi
        var table1Energy: Double {
            get {
                var reducedEnergiesForTemp: [Double] = []
                var reducedEnergiesForPa: [Double] = []
                var reducedEnergiesForBos: [Double] = []
                
                
                var i = 0
                //Interpolate Temp
                while i < brakeEnergyList.count {
                    let lowNum = brakeEnergyList[i]
                    if i + 1 < brakeEnergyList.count {
                        let highNum = brakeEnergyList[i+1]
                        reducedEnergiesForTemp.append(interpolate(inputVal: Double(temperature), valLow: Double(temperatureRange[0]), valHigh: Double(temperatureRange[1]), energyLow: lowNum, energyHigh: highNum))
                    }
                    i += 2
                }
             //   print("Interpolated Temps are: \(reducedEnergiesForTemp)")
                i = 0
                
                //Interpolate PA
                while i < reducedEnergiesForTemp.count {
                    let lowNum = reducedEnergiesForTemp[i]
                    if i + 1 < reducedEnergiesForTemp.count {
                        let highNum = reducedEnergiesForTemp[i+1]
                        reducedEnergiesForPa.append(interpolate(inputVal: pressureAltitude, valLow: pressureAltitudeRange[0], valHigh: pressureAltitudeRange[1], energyLow: lowNum, energyHigh: highNum))
                    }
                    i += 2
                }
               // print("Interpolated PA are: \(reducedEnergiesForPa)")
                i = 0
                
                //Interpolate BOS
                while i < reducedEnergiesForPa.count {
                    let lowNum = reducedEnergiesForPa[i]
                    if i + 1 < reducedEnergiesForPa.count {
                        let highNum = reducedEnergiesForPa[i+1]
                        reducedEnergiesForBos.append(interpolate(inputVal: Double(brakesOnSpeed), valLow: Double(brakesOnSpeedRange[0]), valHigh: Double(brakesOnSpeedRange[1]), energyLow: lowNum, energyHigh: highNum))
                    }
                    i += 2
                }
               // print("Interpolated BOS are: \(reducedEnergiesForBos)")
                i = 0
                
                //Interpolate for Weight
                let earlyTable1 = interpolate(inputVal: Double(weight), valLow: Double(weightRange[0]), valHigh: Double(weightRange[1]), energyLow: reducedEnergiesForBos[0], energyHigh: reducedEnergiesForBos[1])
                print("Table 1 energy is: \(earlyTable1)") //deugging
                print("Adjusted table 1 for taxi is \(earlyTable1 + taxiDistance)")
                return earlyTable1 + taxiDistance
                
            }
            
        } // INIT Closure
        
        
        
    } // STRUCT CLOSURE
    
    
    //MARK: - Interpolating Every Value Functions
    
    func interpolate(inputVal: Double,valLow: Double, valHigh: Double, energyLow: Double, energyHigh: Double) -> Double {
        if energyLow == energyHigh { //They are the same, nothign to interpolate
            return energyHigh
        }
        let  newValue = (((inputVal - valLow)*(energyHigh - energyLow))/(valHigh - valLow)) + energyLow
        return newValue
    }
    
}
