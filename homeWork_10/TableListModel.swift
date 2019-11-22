//
//  TableListModel.swift
//  homeWork_10
//
//  Created by Дмитрий Яковлев on 21.11.2019.
//  Copyright © 2019 Дмитрий Яковлев. All rights reserved.
//

import Foundation
//MARK:- TableListModel
class TableListModel {
    
    private var data : [String] = []

    init(data:[String]){
        self.data = data
    }

    func add(str: String){
        self.data.append(str)
    }
    
    func rem(at: Int){
        self.data.remove(at: at)
    }
    
    func getData()-> [String]{
        return self.data
    }
    func getString(at rowIndex: Int)-> String{
        return self.data[rowIndex]
    }
    func isContain(item : String) -> Bool{
        if self.data.contains(item){
            return true
        }
        return false
    }
    func clear(){
        return self.data.removeAll()
    }
    
}
