//
//  TableListModelItem.swift
//  homeWork_10
//
//  Created by Дмитрий Яковлев on 27.11.2019.
//  Copyright © 2019 Дмитрий Яковлев. All rights reserved.
//

import Foundation
class TAbleLIstModelItem:Equatable{
    static func == (lhs: TAbleLIstModelItem, rhs: TAbleLIstModelItem) -> Bool {
        if lhs.data.elementsEqual(rhs.data), lhs.isChecked == rhs.isChecked{
            return true
        }
        return false
    }
    

    var data: String
    var isChecked: Bool
    
    
    init(data: String, isChecked: Bool){
        self.data = data
        self.isChecked = isChecked
    }
}

