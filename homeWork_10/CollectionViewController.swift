//
//  ViewController.swift
//  homeWork_10
//
//  Created by Дмитрий Яковлев on 21.11.2019.
//  Copyright © 2019 Дмитрий Яковлев. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    //MARK:- outlets

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var scrollSwitcher: UISegmentedControl!
    @IBOutlet weak var rowPicker: UIPickerView!
    
    let cellID = "MyCollectionViewCell"
    let insents = UIEdgeInsets(top: 0, left: 10, bottom: 50, right: 10)
    let rowPickerCountOfRow = 2
    var rowPickerValue :CGFloat?

    //MARK:- image for collectionView
    let data = [
        (UIImage(named: "pictureBarbarian"),"Barbarian"),
        (UIImage(named: "pictureCleric"),"Cleric"),
        (UIImage(named: "pictureMage"),"Mage"),
        (UIImage(named: "pictureMonk"),"Monk"),
        (UIImage(named: "picturePaladin"),"Paladin"),
        (UIImage(named: "pictureRanger"),"Ranger"),
        (UIImage(named: "pictureRouge"),"Rouge"),
        (UIImage(named: "pictureSorc"),"Sorc"),
        (UIImage(named: "pictureWarior"),"Warior"),
        (UIImage(named: "pictureWarlock"),"Warlock")
    ]
    
    //MARK:- picker value

    let pickerData = [
        "1 строка",
        "2 строки"
    ]
    
    @IBAction func scrollSwicherValueCHanged(_ sender: UISegmentedControl) {
        
        let selectedSegment = sender.selectedSegmentIndex;
        
        if (selectedSegment == 0) {
            layout.scrollDirection = UICollectionView.ScrollDirection.vertical;
        }
        else{
            layout.scrollDirection = UICollectionView.ScrollDirection.horizontal;
        }
        resizeCollectionView(row: rowPicker.selectedRow(inComponent: 0))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        rowPickerSetup()
    }
    
    func collectionViewSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        //        collectionView.register(PhotCell.self, forCellWithReuseIdentifier: cellID)
        
        //        layout.itemSize = CGSize
        //        layout.minimumLineSpacing
        //        layout.sectionInset
    }
    
    func rowPickerSetup() {
        rowPicker.delegate = self
        rowPicker.dataSource = self
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        guard layout != nil else {return}
        layout.invalidateLayout()
        
        collectionView.reloadData()
    }
}

//MARK:- CollectionViewController: UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            as? MyCollectionViewCell else { return UICollectionViewCell() }
        let tmp : (UIImage?,String)
        //        if indexPath.section == 0{
        tmp = data[indexPath.row]
        //        }
        //        else {
        //            tmp = data[indexPath.row + 5]
        //        }
        guard tmp.0 != nil else{ return MyCollectionViewCell()}
        cell.setup(image: tmp.0!, imageName: tmp.1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
        
    }
}

//MARK:- CollectionViewController: UICollectionViewDelegateFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 10 - инсет, 5 - это то число, которое будет умножаться на 2 (между двумя столбцами)
        guard rowPickerValue != nil else{
            resizeCollectionView(row: 0)
            return ( CGSize(width: rowPickerValue!, height: rowPickerValue!))}
        let tmp1 = rowPickerValue!
        
        return CGSize(width: tmp1, height: tmp1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insents
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func resizeCollectionView(row: Int){
        let tmp : CGFloat
        
        if layout.scrollDirection == .vertical{
            tmp = collectionView.frame.width < collectionView.frame.height ? collectionView.frame.width : collectionView.frame.height
            switch row {
            case 0:
                rowPickerValue = tmp - 10
            case 1:
                rowPickerValue =  (tmp) / 2 - 10  - 5
            default:
                rowPickerValue = tmp - 30
            }}
            
        else{
            tmp = collectionView.frame.width
            switch row {
            case 0:
                rowPickerValue = tmp - 10
            case 1:
                rowPickerValue =  (tmp) / 2
            default:
                rowPickerValue = tmp - 30
                
            }
        }
    }
}

//MARK:- CollectionViewController:UIPickerViewDataSource
extension CollectionViewController:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rowPickerCountOfRow
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
}

//MARK:-  CollectionViewController: UIPickerViewDelegate
extension CollectionViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(row) \(component)")
        
        resizeCollectionView(row: row)
        collectionView.reloadData()
    }
    
}
