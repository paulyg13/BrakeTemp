//
//  OtherReverse.swift
//  737Brake
//
//  Created by Paul Galea on 2020-05-01.
//  Copyright © 2020 Paul Galea. All rights reserved.
//

import Foundation

struct CoolingTime {
    let reverseUsed: Bool
    let autobrake: String
    let table2Energy: Double
    var brakeCoolingTimeGround: String? //= nil
    var brakeCoolingTimeAir: String? //= nil
    var brakeCoolingMsg: String? //= nil
    var brakeCoolingMsgDetails: String? //= nil
    
    init(reverseUsed: Bool, autobrake: String, table2Energy: Double) {

        self.reverseUsed = reverseUsed
        self.autobrake = autobrake
        self.table2Energy = table2Energy
        
        switch table2Energy {
        case ..<16.4:
            brakeCoolingMsg = k.noSpecialProcedureMsg
            brakeCoolingMsgDetails = k.noSpecialProcedureMsgDetails
            
        case ...17:
            brakeCoolingTimeAir = "1.0 Minute"
            brakeCoolingTimeGround = "6.6 Minutes"
        case ...19:
            brakeCoolingTimeAir = "4.0 Minutes"
            brakeCoolingTimeGround = "16.1 Minutes"
        case ...20.9:
            brakeCoolingTimeAir = "5.0 Minutes"
            brakeCoolingTimeGround = "24.2 Minutes"
        case ...22.4:
            brakeCoolingTimeAir = "5.6 Minutes"
            brakeCoolingTimeGround = "30.0 Minutes"
        case ...23.5:
            brakeCoolingTimeAir = "6.0 Minutes"
            brakeCoolingTimeGround = "34.3 Minutes"
        case ...25.1:
            brakeCoolingTimeAir = "6.5 Minutes"
            brakeCoolingTimeGround = "40 Minutes"
        case ...26.9:
            brakeCoolingTimeAir = "7.0 Minutes"
            brakeCoolingTimeGround = "45.8 Minutes"
        case ...28.2:
            brakeCoolingTimeAir = "7.3 Minutes"
            brakeCoolingTimeGround = "50 Minutes"
        case 29.9...40:
            brakeCoolingMsg = k.brakeCoolingMsgCaution
            brakeCoolingMsgDetails = k.brakeCoolingMsgCautionDetails
        case 41...:
            brakeCoolingMsg = k.brakeCoolingMsgMelt
            brakeCoolingMsgDetails = k.brakeCoolingMsgMeltDetails
           // brakeCoolingTimeAir = nil
            //brakeCoolingTimeGround = nil
        default:
            brakeCoolingMsg = "xxx"
            brakeCoolingMsgDetails = "There is an error"
        }
    }
}
