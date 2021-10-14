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
    
    override func viewDidLoad() {
        startDatePicker.locale = Locale.current
        startDatePicker.timeZone = TimeZone.current
        stopDatePicker.locale = Locale.current
        stopDatePicker.timeZone = TimeZone.current
    }
    
    @IBAction func searchTime(_ sender: UIButton) {
    }
    
}
