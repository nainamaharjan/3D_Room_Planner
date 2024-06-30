//
//  NepaliDatePicker.swift
//  CleanSwiftTest
//
//  Copyright © 2020 Prabhu Pay. All rights reserved.
//
#if os(iOS)

import Foundation
import UIKit

class NepaliDatePicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let months = ["Baisakh", "Jestha", "Asadh", "Shrawan", "Bhadra", "Ashwin", "Kartik", "Mangshir", "Poush", "Magh", "Falgun", "Chaitra"]
    
    var delegate_: NepaliPickerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        delegate = self
        dataSource = self
        
        selectRow(76, inComponent: 0, animated: false)
        selectRow(0, inComponent: 1, animated: false)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // 3 pickers for year, month and day
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        let dateConversionServices = DateConversionServices()
        
        if component == 0 { // year
            return  88
        } else if component == 1 { // month
            return 12
        } else { // day
            return dateConversionServices.getDaysCount(year: pickerView.selectedRow(inComponent: 0) + 2001, month: pickerView.selectedRow(inComponent: 1) + 1)
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return String(2001 + row)
        } else if component == 1 {
            return months[row]
        } else {
            return String(row + 1)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // get data of selected date
        var year = selectedRow(inComponent: 0)
        var month = (selectedRow(inComponent: 1) ) + 1
        var day = (selectedRow(inComponent: 2) ) + 1
        
        if component == 0 {
            year = row
        } else if component == 1 {
            month = row + 1
        } else {
            day = row + 1
        }
        
        // if selected month has lesser days than previously selected month, set day to max day count
        let maxDaysForDate = DateConversionServices().getDaysCount(year: 2001 + year, month: month)
        if day > maxDaysForDate {
            day = maxDaysForDate
        }
        
        let yyyy = String(2001 + year)
       
        // append "0" if value is single digit
        let mm = month <= 9 ? String("0\(month)") : String(month)
        let dd = day <= 9 ? String("0\(day)") : String(day)
        
        self.delegate_?.nepaliDatePicker(self, year: yyyy, month: mm, day: dd)

        reloadComponent(2)
        return
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        if component == 0 {
            return NSAttributedString(string: String(2001 + row))
        } else if component == 1 {
            return NSAttributedString(string: months[row])
        } else {
            return NSAttributedString(string: String(row + 1))
        }
    }
    
    
}


protocol NepaliPickerViewDelegate {
    func nepaliDatePicker(_ view: NepaliDatePicker, year: String, month: String, day: String)
}

#endif
