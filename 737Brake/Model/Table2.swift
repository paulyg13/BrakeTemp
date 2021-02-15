//
//  Table2.swift
//  737Brake
//
//  Created by Paul Galea on 2020-04-29.
//  Copyright © 2020 Paul Galea. All rights reserved.
//

import Foundation

class Table2 {
    
    let table2aData = [10:[10.0, 7.9, 7.4, 7.1, 6.6, 6.1],
                       20:[20.0, 16.4, 15.3, 14.4, 13.3, 12.2],
                       30:[30.0, 25.5, 23.7, 22.1, 20.1, 18.3],
                       40:[40.0, 35.0, 32.6, 30.0, 27.1, 24.5],
                       50:[50.0, 44.8, 41.9, 38.3, 34.3, 30.9],
                       60:[60.0, 54.8, 51.5, 47.0, 41.8, 37.6]]
    
    let table2bData = [10:[10.0, 7.2, 6.0, 4.3, 2.4, 1.7],
                       20:[20.0, 15.2, 12.6, 9.0, 5.2, 3.6],
                       30:[30.0, 23.7, 19.8, 14.3, 8.4, 5.8],
                       40:[40.0, 32.6, 27.5, 20.2, 12.0, 8.3],
                       50:[50.0, 41.8, 35.7, 26.5, 16.1, 11.1],
                       60:[60.0, 51.0, 44.4, 33.3, 20.6, 14.3]]
    
    let event = ["RTO MAX MANUAL", "MAX MANUAL", "MAX AUTO", "AUTOBRAKE 3", "AUTOBRAKE 2","AUTOBRAKE 1"]
    
    func getTable2Energy(table1Energy: Int, reverseUsed: Bool, indexForAutobreak: Int) -> Double {
        if reverseUsed {
            //Table 2b is reverse
            return table2bData[table1Energy]?[indexForAutobreak] ?? 0
        } else {
            //Table 2a is no-reverse used
            return table2aData[table1Energy]?[indexForAutobreak] ?? 0
        }
    }
    
}
