//
//  SearchController.swift
//  gpsApp
//
//  Created by WENDRA RIANTO on 2021/10/14.
//

import Foundation

import RealmSwift

class SearchController: UIViewController{
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var stopDatePicker: UIDatePicker!
    var startDate:Date? = nil
    var stopDate:Date? = nil
    override func viewDidLoad() {
        startDatePicker.locale = Locale(identifier: "ja_JP")
        startDatePicker.timeZone = TimeZone.current
        stopDatePicker.locale = Locale(identifier: "ja_JP")
        stopDatePicker.timeZone = TimeZone.current
        startDate = startDatePicker.date
        stopDate = stopDatePicker.date
    }
    
    @IBAction func searchTime(_ sender: UIButton) {
        let storyboard:UIStoryboard = self.storyboard!
        startDate = startDatePicker.date
        stopDate = stopDatePicker.date
        
//            let nextViewController:UpdateViewController = storyboard.instantiateViewController(withIdentifier:"UpdateViewController") as! UpdateViewController
        let nextViewController:ViewController = storyboard.instantiateViewController(withIdentifier:"ViewController") as! ViewController
        
        nextViewController.startDate = startDate
        nextViewController.stopDate = stopDate
        
        self.present(nextViewController,animated: true, completion: nil)
    }
    
    @IBAction func changeStartDatePicker(_ sender: UIDatePicker) {
        //stopDatePicker.minimumDate = startDatePicker.date
        if (stopDatePicker.date < startDatePicker.date){
            stopDatePicker.setDate(startDatePicker.date, animated: true)
        }
    }
    
    @IBAction func changeStopDatePicker(_ sender: UIDatePicker) {
//        startDatePicker.maximumDate = stopDatePicker.date
        if (stopDatePicker.date < startDatePicker.date){
            startDatePicker.setDate(stopDatePicker.date, animated: true)
        }
    }
}
