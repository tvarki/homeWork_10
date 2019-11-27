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
    
    private var data : [TAbleLIstModelItem] = []
//    private var isChecked:[Bool] = []
    
    init(data:[TAbleLIstModelItem]){
        self.data = data
    }

    func add(str: String){
        self.data.append(TAbleLIstModelItem(data: str,isChecked: false))
    }
    
    func rem(at: Int){
        self.data.remove(at: at)
    }
    
    func getData()-> [TAbleLIstModelItem]{
        return self.data
    }
    func getString(at rowIndex: Int)-> TAbleLIstModelItem{
        return self.data[rowIndex]
    }
    
    func isContain(item : TAbleLIstModelItem) -> Bool{
        if self.data.contains(item){
            return true
        }
        return false
    }
    func clear(){
        return self.data.removeAll()
    }
    
}
