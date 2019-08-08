//
//  EditProfileView.swift
//  WaterApp
//
//  Created by Ahmad Ibrahim on 7/25/19.
//  Copyright © 2019 WW. All rights reserved.
//

import Foundation
import UIKit

protocol EditProfileViewDelegate: class {
    func weightWasChanged(in view: EditProfileView, newWeight: String)
    func sizeOfBottleWasChanged(in view: EditProfileView, newSize: String)
}

protocol EditProfileViewDataSource: class {
    func getUserWeight(in view: EditProfileView) -> Int
    func getBottleSize(in view: EditProfileView) -> Int
}

class EditProfileView: UIView {
    weak var delegate: EditProfileViewDelegate?
    weak var dataSource: EditProfileViewDataSource?
    let weightInput = UITextField()
    let weightUnit = UILabel()
    let sizeOfBottle = UITextField()
    let bottleUnit = UILabel()
    
    let weightBackgroundView = UIView()
    let bottleSizeBackgroundView = UIView()
    
    let waterBlue = UIColor.init(red: 112/255, green: 211/255, blue: 236/255, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    func setupViews() {
        backgroundColor = .white
        
        setupWeightBackgroundView()
        setupBottleSizeBackgroundView()
        
        setupWeightLabelView()
        setupWeightUnit()
        setupSizeOfBottle()
        setupBottleUnit()
    }
    
    func setupWeightBackgroundView() {
        weightBackgroundView.backgroundColor = waterBlue
        weightBackgroundView.layer.cornerRadius = 10
        weightBackgroundView.clipsToBounds = true
        weightBackgroundView.layer.masksToBounds = true
        addSubview(weightBackgroundView)
    }
    
    func setupWeightLabelView() {
        weightInput.font = .systemFont(ofSize: 40)
        weightInput.textColor = .white
        weightInput.textAlignment = .left
        weightInput.keyboardType = .numberPad
        weightInput.delegate = self
        weightInput.addTarget(self, action: #selector(weightWasChanged), for: .editingChanged)
        weightBackgroundView.addSubview(weightInput)
    }
    
    @objc func weightWasChanged() {
        delegate?.weightWasChanged(in: self, newWeight: weightInput.text ?? "0")
    }
    
    func setupWeightUnit() {
        weightUnit.attributedText =  NSAttributedString(string: "lbs")
        weightUnit.textColor = .white
        weightUnit.font = .systemFont(ofSize: 30)
        weightBackgroundView.addSubview(weightUnit)
    }
    
    func setupBottleSizeBackgroundView() {
        bottleSizeBackgroundView.backgroundColor = waterBlue
        bottleSizeBackgroundView.layer.cornerRadius = 10
        bottleSizeBackgroundView.clipsToBounds = true
        bottleSizeBackgroundView.layer.masksToBounds = true
        addSubview(bottleSizeBackgroundView)
    }
    
    func setupSizeOfBottle() {
        sizeOfBottle.font = .systemFont(ofSize: 40)
        sizeOfBottle.textAlignment = .left
        sizeOfBottle.textColor = .white
        sizeOfBottle.keyboardType = .numberPad
        sizeOfBottle.delegate = self
        sizeOfBottle.addTarget(self, action: #selector(bottleSizeWasChanged), for: .editingChanged)
        bottleSizeBackgroundView.addSubview(sizeOfBottle)
    }
    
    @objc func bottleSizeWasChanged() {
        delegate?.sizeOfBottleWasChanged(in: self, newSize: sizeOfBottle.text ?? "1")
    }
    
    func setupBottleUnit() {
        bottleUnit.attributedText = NSAttributedString(string: "oz")
        bottleUnit.textColor = .white
        bottleUnit.font = .systemFont(ofSize: 30)
        bottleSizeBackgroundView.addSubview(bottleUnit)
    }
    
    // MARK: Setup Constraints
    
    func setupConstraints() {
        setupWeightBackgroundConstraints()
        setupBottleSizeBackgroundConstraints()
        
        setupWeightLabelConstraints()
        setupUnitConstraints()
        setupBottleUnitConstraints()
        setupSizeOfBottleConstraints()
    }
    
    func setupWeightBackgroundConstraints() {
        weightBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        weightBackgroundView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        weightBackgroundView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        weightBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 130).isActive = true
        weightBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    func setupWeightLabelConstraints() {
        weightInput.translatesAutoresizingMaskIntoConstraints = false
        weightInput.widthAnchor.constraint(equalToConstant: 100).isActive = true
        weightInput.heightAnchor.constraint(equalToConstant: 90).isActive = true
        weightInput.leftAnchor.constraint(equalTo: weightBackgroundView.leftAnchor, constant: 13).isActive = true
        weightInput.centerYAnchor.constraint(equalTo: weightBackgroundView.centerYAnchor).isActive = true
    }
    
    func setupUnitConstraints() {
        weightUnit.translatesAutoresizingMaskIntoConstraints = false
        weightUnit.heightAnchor.constraint(equalTo: weightBackgroundView.heightAnchor, constant: 2).isActive = true
        weightUnit.bottomAnchor.constraint(equalTo: weightBackgroundView.bottomAnchor, constant: 2).isActive = true
        weightUnit.widthAnchor.constraint(equalToConstant: 40).isActive = true
        weightUnit.rightAnchor.constraint(equalTo: weightBackgroundView.rightAnchor, constant: -18).isActive = true
    }
    
    func setupBottleSizeBackgroundConstraints() {
        bottleSizeBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        bottleSizeBackgroundView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        bottleSizeBackgroundView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        bottleSizeBackgroundView.topAnchor.constraint(equalTo: weightBackgroundView.bottomAnchor, constant: 60).isActive = true
        bottleSizeBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupBottleUnitConstraints() {
        bottleUnit.translatesAutoresizingMaskIntoConstraints = false
        bottleUnit.heightAnchor.constraint(equalTo: bottleSizeBackgroundView.heightAnchor, constant: 2).isActive = true
        bottleUnit.bottomAnchor.constraint(equalTo: bottleSizeBackgroundView.bottomAnchor, constant: 2).isActive = true
        bottleUnit.widthAnchor.constraint(equalToConstant: 40).isActive = true
        bottleUnit.rightAnchor.constraint(equalTo: bottleSizeBackgroundView.rightAnchor, constant: -18).isActive = true
    }
    
    func setupSizeOfBottleConstraints() {
        sizeOfBottle.translatesAutoresizingMaskIntoConstraints = false
        sizeOfBottle.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sizeOfBottle.heightAnchor.constraint(equalToConstant: 90).isActive = true
        sizeOfBottle.leftAnchor.constraint(equalTo: bottleSizeBackgroundView.leftAnchor, constant: 13).isActive = true
        sizeOfBottle.centerYAnchor.constraint(equalTo: bottleSizeBackgroundView.centerYAnchor).isActive = true
    }
    
    func setWeight(weight: Int) {
        weightInput.text = String(dataSource?.getUserWeight(in: self) ?? 0)
    }
    
    func setBottleSize(size: Int) {
        sizeOfBottle.text = String(dataSource?.getBottleSize(in: self) ?? 1)
    }
}

extension EditProfileView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        }
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        let allowedCharacters = CharacterSet(charactersIn:"0123456789")
        let characterSet = CharacterSet(charactersIn: string)
        
        return updatedText.count <= 3 && allowedCharacters.isSuperset(of: characterSet)
    }
}
