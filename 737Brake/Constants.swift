//
//  Constants.swift
//  737Brake
//
//  Created by Paul Galea on 2020-04-28.
//  Copyright © 2020 Paul Galea. All rights reserved.
//

import Foundation

struct k {
    static let weight = "weight"
    static let brakesOnSpeed = "brakesOnSpeed"
    static let taxiDistance = "taxiDistance"
    static let wind = "wind"
    static let elevation = "elevation"
    static let temperature = "temperature"
    static let autobrake = "autobrake"
    static let reverse = "reverse"
    
    
    
    static let autobrakeOptions = ["RTO Max Manual", "Max Manual", "Max AUTO", "Autobrake 3", "Autobrake 2","Autobrake 1"]
    static let brakeCoolingMsgCaution = "CAUTION"
    static let brakeCoolingMsgCautionDetails = "Cooling time is in the CAUTION ZONE. \n Wheel plugs may melt. \n Delay Takeoff and inspect after one hour. \n If overheat occurs after take-off, extend gear down soon for at least 12 minutes."
    static let brakeCoolingMsgMelt = "FUSE PLUG MELT ZONE"
    static let brakeCoolingMsgMeltDetails = "FUSE PLUG MELT ZONE. \n Clear runway immediately. \n Unless required, do not set parking brake.\n Do not approach gear or attempt taxi for one hour. \n Tire, wheel and brake replacement may be required. \n If overheat occurs after takeoff, extend gear soon for at least 12 minutes."
    static let noSpecialProcedureMsg = "-"
    static let noSpecialProcedureMsgDetails = "No Special Procedure Required"
    
    
    //Make this a PLIST of default values
    static var defaultValues: [String: Any?] = [weight: nil, brakesOnSpeed: 140, taxiDistance: 1.0, wind: 0, elevation: nil, temperature: nil, autobrake: "Autobrake 3", reverse: "Two-Engine Reverse" ]
}
