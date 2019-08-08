//
//  WaterViewModel.swift
//  WaterApp
//
//  Created by Ahmad Ibrahim on 7/18/19.
//  Copyright © 2019 WW. All rights reserved.
//

import Foundation

protocol WaterViewModelDelegate: class {
    func completedAllCheckboxes(from viewModel: WaterViewModel)
    func reloadViewData(from viewModel: WaterViewModel)
}

enum Units {
    case ounces
    case liters
    case gallons
}

class WaterViewModel {
    var weight: Int
    var unitsUsed: Units
    var sizeOfBottle: Int
    var currentDate = Date()
    let calendar = Calendar.current
    
    weak var delegate: WaterViewModelDelegate?
    
    var weightChanged = false
    var bottleSizeChanged = false
    
    init(unitUsed: Units) {
        self.unitsUsed = unitUsed
        self.weight = UserDefaults.standard.object(forKey: "weight") as? Int ?? 0
        self.sizeOfBottle = UserDefaults.standard.object(forKey: "bottleSize") as? Int ?? 1
        updateIfNewDay()
    }
    
    func updateIfNewDay() {
        if !isKeyPresentInUserDefaults(key: "oldDate") {
            UserDefaults.standard.set(self.currentDate, forKey: "oldDate")
        }
        
        if !calendar.isDateInToday(UserDefaults.standard.object(forKey: "oldDate") as! Date) {
            UserDefaults.standard.set(0, forKey: "checkedBoxes")
            UserDefaults.standard.set(self.currentDate, forKey: "oldDate")
        }
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }

    func getWeight() -> Int {
        return UserDefaults.standard.object(forKey: "weight") as? Int ?? 0
    }
    
    func getBottleSize() -> Int {
        return UserDefaults.standard.object(forKey: "bottleSize") as? Int ?? 1
    }
    
    func setWeight(weight: Int) {
        self.weightChanged = true
        self.weight = weight
    }
    
    func setBottleSize(size: Int) {
        self.bottleSizeChanged = true
        self.sizeOfBottle = size
    }
    
    func getNumberOfCups() -> Int {
        let waterIntake = Float(getWeight()) * (2/3)
        let cupsOfWater = ceil(waterIntake / Float(getBottleSize()))
        return (Int(cupsOfWater) > 0) ? Int(cupsOfWater) : 1
    }
    
    func weightUPDATE() {
        if weightChanged {
            self.weightChanged = false
            UserDefaults.standard.set(self.weight, forKey: "weight")
        }
    }
    
    func bottleSizeUPDATE() {
        if bottleSizeChanged {
            self.bottleSizeChanged = false
            UserDefaults.standard.set(self.sizeOfBottle, forKey: "bottleSize")
        }
    }
    
    func checkedBoxesUPDATE() {
        let val = Int(getCheckedBoxes())
        if (val < getNumberOfCups()) {
            UserDefaults.standard.set(val + 1, forKey: "checkedBoxes")
            if (getCheckedBoxes() == getNumberOfCups()) {
                delegate?.completedAllCheckboxes(from: self)
            }
        } else if (val > getNumberOfCups()) {
            UserDefaults.standard.set(getNumberOfCups(), forKey: "checkedBoxes")
        }
    }
    
    func getCheckedBoxes() -> Int {
        let val = UserDefaults.standard.object(forKey: "checkedBoxes") as? Int ?? 0
        if (val > getNumberOfCups()) {
            UserDefaults.standard.set(getNumberOfCups(), forKey: "checkedBoxes")
        }
        return UserDefaults.standard.object(forKey: "checkedBoxes") as? Int ?? 0
    }
    
    func resetCheckedBoxes() {
        UserDefaults.standard.set(0, forKey: "checkedBoxes")
    }
    
    func undoCheckedBox() {
        if (isKeyPresentInUserDefaults(key: "checkedBoxes") && getCheckedBoxes() > 0) {
            let val = Int(getCheckedBoxes())
            UserDefaults.standard.set(val - 1, forKey: "checkedBoxes")
        }
    }

    func firstTimeLaunching() -> Bool {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "hasBeenLaunched") {
            return false
        } else {
            defaults.set(true, forKey: "hasBeenLaunched")
            return true
        }
    }
    
    func reload() {
        delegate?.reloadViewData(from: self)
    }
    
    func highlightIndex() -> Int {
//        var waterIntake = Float(getWeight()) * (2/3)
//        let ouncesPerHour = waterIntake / 12
//        if waterIntake == 0 {
//            waterIntake = 1
//        }
//        let hoursPerBottle = self.getBottleSize() / Int(ouncesPerHour)
//        return time / hoursPerBottle
        return 4
    }
}
