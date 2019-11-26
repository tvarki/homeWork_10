//
//  TableViewController.swift
//  homeWork_10
//
//  Created by Дмитрий Яковлев on 26.11.2019.
//  Copyright © 2019 Дмитрий Яковлев. All rights reserved.
//


import UIKit

class TableViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var myAddButton: UIButton!
    
    //MARK:- Model far actions eith list
    private var tableModel = TableListModel(data: [])
    private let identifier = "ItemCell"
    
    //MARK:- Struct for actions settings (Title,backgroundColor, AccessoryType)
    private struct cellActionSettings{
        var title : String //"Check"
        var bColor : UIColor
        var aType : UITableViewCell.AccessoryType
        
        init(initTitle : String , initColor : UIColor, initAType : UITableViewCell.AccessoryType){
            title = initTitle
            bColor = initColor
            aType = initAType
        }
    }
    enum cellActions{
        case delete
        case deleteAll
        case checkUncheck
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK:- setupView
    private func setupView(){
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.tableFooterView = UIView()
    }
    
    //MARK:- addButtonACtion
    @IBAction func addButtonPressed(_ sender: UIButton) {
        guard let str = myTextField.text , str.count  > 0 else {return}
        
        if isTableViewModelContains(item: str) {
            makeAlert(title: "Внимание", text: "В вашем списке уже есть пункт \(str). Добавить еще один?", str: str, actionAdd: addItem)
        }else {
            addItem(str: str)
        }
    }
    
    //MARK:- function for item add to TableView and tableModel
    private func addItem(str: String ){
        addItemToTableViewModel(label: str)
        myTableView.beginUpdates()
        let ip = IndexPath(row: getCountOfTableViewMOdelData()-1, section: 0)
        myTableView.insertRows(at: [ip], with: .automatic)
        myTableView.endUpdates()
        
        //        myTableView.reloadData()
    }
    
    //MARK:- function for alert qustion
    private func makeAlert(title: String , text: String, str: String ,  actionAdd: @escaping (String)->()) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отменить", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { action in
            actionAdd(str)
        }))
        self.present(alert, animated: true)
    }
}

//MARK:- Delegate extension
extension TableViewController: UITableViewDelegate{
    
    //MARK:- function for delete item from TableView and tableModel
    private func deleteItem(indexPath: IndexPath ,tableView : UITableView){
        tableView.beginUpdates()
        uncheck(at: indexPath, tableView: tableView)
        tableView.deleteRows(at: [ indexPath ], with: .automatic)
        removeItemFromTableViewModel(at: indexPath.row)
        tableView.endUpdates()
    }
    
    //MARK:- function for delete all items from TableView and tableModel
    
    private func deleteAllItem(tableView : UITableView){
        uncheck(at: nil, tableView: tableView)
        clearTableViewModel()
        tableView.reloadData()
    }
    
    //MARK:- Swipe action  for delete
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let cell = tableView.cellForRow(at: indexPath)
        let actionSettings = createTypeActionSettings(cell: cell!,toDo: .delete)
        let action = UIContextualAction(style: .normal, title: actionSettings.title) { (action, view, completionHandler) in
            self.deleteItem(indexPath: indexPath, tableView: tableView)
            completionHandler(true)
        }
        action.backgroundColor = actionSettings.bColor
        
        let actionDeleteAllSettings = createTypeActionSettings(cell: cell!,toDo: .deleteAll)
        let actionDeleteAll = UIContextualAction(style: .normal, title: actionDeleteAllSettings.title) { (action, view, completionHandler) in
            self.deleteAllItem(tableView: tableView)
            
            completionHandler(true)
        }
        actionDeleteAll.backgroundColor = actionDeleteAllSettings.bColor
        
        let configuration = UISwipeActionsConfiguration(actions: [action, actionDeleteAll])
        return configuration
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteItem(indexPath: indexPath, tableView: tableView)
        }
    }
    
    //MARK:- Swipe(right) action
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let cell = tableView.cellForRow(at: indexPath)
        let actionSettings = createTypeActionSettings(cell: cell!,toDo: .checkUncheck)
        
        let action = UIContextualAction(style: .normal, title: actionSettings.title) { (action, view, completionHandler) in
            cell?.accessoryType = actionSettings.aType
            completionHandler(true)
        }
        action.backgroundColor = actionSettings.bColor
        let configuration = UISwipeActionsConfiguration(actions: [ action ])
        return configuration
    }
    
    //MARK:- uncheck action for safe delete
    private func uncheck(at indexPath: IndexPath?, tableView : UITableView){
        guard indexPath != nil else {
            for row in 0..<tableView.numberOfRows(inSection: 0) {
                if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) {
                    cell.accessoryType =  .none
                }
            }
            return
        }
        guard let cell = tableView.cellForRow(at: indexPath!) else {return}
        if cell.accessoryType == UITableViewCell.AccessoryType.checkmark{
            cell.accessoryType = .none
        }
    }
    
    //MARK:- Change accessory type on cell click
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        cell.accessoryType = createTypeActionSettings(cell: cell,toDo: .checkUncheck).aType
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK:- Create accessory type settings struct for cell
    private func createTypeActionSettings(cell: UITableViewCell, toDo : cellActions) -> cellActionSettings{
        var settings : cellActionSettings
                
        switch toDo {
        case .delete:
            settings = cellActionSettings(initTitle: "Удалить", initColor: UIColor.red, initAType: .none)
        case .deleteAll:
            settings = cellActionSettings(initTitle: "Очистить таблицу", initColor: UIColor.purple, initAType: .none)
        case .checkUncheck:
            if cell.accessoryType == UITableViewCell.AccessoryType.none{
                settings = cellActionSettings(initTitle: "Пометить", initColor: UIColor.blue, initAType: .checkmark)
            }else{
                settings = cellActionSettings(initTitle: "Снять пометку", initColor: UIColor.gray, initAType: .none)
            }
        }
        return settings
    }
}

//MARK:- Data Source extension
extension TableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.getData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = tableModel.getString(at: indexPath.row)
        return cell
    }
}

//MARK:- ModelWork extension
extension TableViewController{
    private func addItemToTableViewModel(label: String){
        tableModel.add(str: label)
    }
    private func getCountOfTableViewMOdelData()->Int{
        return tableModel.getData().count
    }
    private func removeItemFromTableViewModel(at index: Int){
        tableModel.rem(at: index)
    }
    private func isTableViewModelContains(item: String) -> Bool{
        return tableModel.isContain(item: item)
    }
    private func clearTableViewModel(){
        tableModel.clear()
    }
    
}

