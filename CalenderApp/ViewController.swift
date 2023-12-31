//
//  ViewController.swift
//  CalenderApp
//
//  Created by AmitArya on 9/9/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedDate = Date()
    var totalSquares = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellsView()
        setMonthView()
    
    }
    
    func setCellsView(){
        let width = (collectionView.frame.size.width - 2) / 7
        let height = (collectionView.frame.size.height - 2) / 7
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
        
    }
    
    func setMonthView(){
        totalSquares.removeAll()
        
        let daysInMonth = CalenderHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalenderHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalenderHelper().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while(count <= 42){
            if(count <= startingSpaces || count-startingSpaces > daysInMonth){
                totalSquares.append("")
            } else{
                totalSquares.append(String(count-startingSpaces))
            }
            count += 1
        }
        
        monthLabel.text = CalenderHelper().monthString(date: selectedDate)
                           + " " + CalenderHelper().yearString(date: selectedDate)
        
        collectionView.reloadData()
    }
    
    @IBAction func previousMonth(_ sender: UIButton) {
        selectedDate = CalenderHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: UIButton) {
        selectedDate = CalenderHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool{
        return false
    }
    
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalenderCell", for: indexPath) as? CalenderCell else { return UICollectionViewCell() }
        
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath)?.backgroundColor == UIColor.tintColor{
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.white
        } else{
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.tintColor
        }
    }
    
}

