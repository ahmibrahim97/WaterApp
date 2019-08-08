//
//  ModalEditView.swift
//  WaterApp
//
//  Created by Ahmad Ibrahim on 8/2/19.
//  Copyright © 2019 WW. All rights reserved.
//

import Foundation
import UIKit

protocol ModalViewDelegate: class {
    func saveWasClicked(in view: ModalEditView)
    func weightWasChanged(in view: ModalEditView, newWeight: String)
    func bottleSizeWasChanged(in view: ModalEditView, newSize: String)
}

class ModalEditView: UIView {
    weak var delegate: ModalViewDelegate?
    
    let modalBackground = UIView()
    let weightField = UITextField()
    let bottleSizeField = UITextField()
    let saveButton = UIButton(type: .roundedRect)
    let weightBackgroundView = UIView()
    let weightUnit = UILabel()
    let bottleSizeBackgroundView = UIView()
    let bottleUnit = UILabel()
    
    let waterBlue = UIColor.init(red: 108/255, green: 205/255, blue: 229/255, alpha: 1)
    
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
        setupBlurView()
        setupBackgroundView()
        
        setupWeightBackgroundView()
        setupWeightField()
        setupWeightUnit()
        
        setupBottleSizeBackgroundView()
        setupBottleSizeField()
        setupBottleUnit()
        
        setupSaveButton()
    }
    
    func setupBlurView() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
    
    func setupBackgroundView() {
        modalBackground.backgroundColor = waterBlue
        modalBackground.alpha = 0.75
        modalBackground.layer.cornerRadius = 5
        modalBackground.clipsToBounds = true
        addSubview(modalBackground)
    }
    
    // MARK: Setup Weight
    
    func setupWeightBackgroundView() {
        weightBackgroundView.backgroundColor = .white
        weightBackgroundView.layer.cornerRadius = 10
        weightBackgroundView.clipsToBounds = true
        weightBackgroundView.layer.masksToBounds = true
        modalBackground.addSubview(weightBackgroundView)
    }
    
    func setupWeightField() {
        weightField.font = .systemFont(ofSize: 30)
        weightField.textColor = waterBlue
        weightField.textAlignment = .left
        weightField.delegate = self
        weightField.keyboardType = .numberPad
        weightField.addTarget(self, action: #selector(weightWasChanged), for: .editingChanged)
        weightBackgroundView.addSubview(weightField)
    }
    
    func setupWeightUnit() {
        weightUnit.attributedText =  NSAttributedString(string: "lbs")
        weightUnit.textColor = waterBlue
        weightUnit.font = .systemFont(ofSize: 25)
        weightBackgroundView.addSubview(weightUnit)
    }
    
    
    // MARK: Setup Bottle Size
    
    func setupBottleSizeBackgroundView() {
        bottleSizeBackgroundView.backgroundColor = .white
        bottleSizeBackgroundView.layer.cornerRadius = 10
        bottleSizeBackgroundView.clipsToBounds = true
        bottleSizeBackgroundView.layer.masksToBounds = true
        modalBackground.addSubview(bottleSizeBackgroundView)
    }
    
    func setupBottleSizeField() {
        bottleSizeField.font = .systemFont(ofSize: 30)
        bottleSizeField.textColor = waterBlue
        bottleSizeField.textAlignment = .left
        bottleSizeField.delegate = self
        bottleSizeField.keyboardType = .numberPad
        bottleSizeField.addTarget(self, action: #selector(bottleSizeWasChanged), for: .editingChanged)
        bottleSizeBackgroundView.addSubview(bottleSizeField)
    }
    
    func setupBottleUnit() {
        bottleUnit.attributedText = NSAttributedString(string: "oz")
        bottleUnit.textColor = waterBlue
        bottleUnit.font = .systemFont(ofSize: 25)
        bottleSizeBackgroundView.addSubview(bottleUnit)
    }
    
    // MARK: Setup Save Button
    
    func setupSaveButton() {
        saveButton.backgroundColor = .white
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.textColor = waterBlue
        saveButton.layer.cornerRadius = 10
        saveButton.addTarget(self, action: #selector(saveWasClicked), for: .touchUpInside)
        modalBackground.addSubview(saveButton)
    }

    // MARK: Actions
    @objc func weightWasChanged() {
        delegate?.weightWasChanged(in: self, newWeight: weightField.text ?? "0")
    }
    
    @objc func bottleSizeWasChanged() {
        delegate?.bottleSizeWasChanged(in: self, newSize: bottleSizeField.text ?? "0")
    }
    
    @objc func saveWasClicked() {
        delegate?.saveWasClicked(in: self)
    }
    
    // MARK: Setup Constraints
    
    func setupConstraints() {
        setupBackgroundConstraints()
        
        setupWeightBackgroundConstraints()
        setupWeightFieldConstraints()
        setupWeightUnitsConstraints()
        
        setupBottleSizeBackgroundConstraints()
        setupBottleSizeFieldConstraints()
        setupBottleSizeUnitsConstraints()
        
        setupSaveButtonConstraints()
    }
    
    func setupBackgroundConstraints() {
        modalBackground.translatesAutoresizingMaskIntoConstraints = false
        modalBackground.widthAnchor.constraint(equalToConstant: 250).isActive = true
        modalBackground.heightAnchor.constraint(equalToConstant: 200).isActive = true
        modalBackground.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        modalBackground.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    // MARK: Setup Weight Constraints
    
    func setupWeightBackgroundConstraints() {
        weightBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        weightBackgroundView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        weightBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        weightBackgroundView.centerXAnchor.constraint(equalTo: modalBackground.centerXAnchor).isActive = true
        weightBackgroundView.centerYAnchor.constraint(equalTo: modalBackground.centerYAnchor, constant: -50).isActive = true
    }
    
    func setupWeightFieldConstraints() {
        weightField.translatesAutoresizingMaskIntoConstraints = false
        weightField.leftAnchor.constraint(equalTo: weightBackgroundView.leftAnchor, constant: 8).isActive = true
        weightField.rightAnchor.constraint(equalTo: weightBackgroundView.rightAnchor, constant: -15).isActive = true
        weightField.centerYAnchor.constraint(equalTo: weightBackgroundView.centerYAnchor).isActive = true
    }
    
    func setupWeightUnitsConstraints() {
        weightUnit.translatesAutoresizingMaskIntoConstraints = false
        weightUnit.centerYAnchor.constraint(equalTo: weightBackgroundView.centerYAnchor).isActive = true
        weightUnit.leftAnchor.constraint(equalTo: weightBackgroundView.rightAnchor, constant: -50).isActive = true
        weightUnit.rightAnchor.constraint(equalTo: weightBackgroundView.rightAnchor, constant: -2)
    }
    
    
    // MARK: Setup Bottle Size Constraints
    
    func setupBottleSizeBackgroundConstraints() {
        bottleSizeBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        bottleSizeBackgroundView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        bottleSizeBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bottleSizeBackgroundView.centerXAnchor.constraint(equalTo: modalBackground.centerXAnchor).isActive = true
        bottleSizeBackgroundView.centerYAnchor.constraint(equalTo: modalBackground.centerYAnchor, constant: 10).isActive = true
    }
    
    func setupBottleSizeFieldConstraints() {
        bottleSizeField.translatesAutoresizingMaskIntoConstraints = false
        bottleSizeField.leftAnchor.constraint(equalTo: bottleSizeBackgroundView.leftAnchor, constant: 8).isActive = true
        bottleSizeField.rightAnchor.constraint(equalTo: bottleSizeBackgroundView.rightAnchor, constant: -15).isActive = true
        bottleSizeField.centerYAnchor.constraint(equalTo: bottleSizeBackgroundView.centerYAnchor).isActive = true
    }
    
    func setupBottleSizeUnitsConstraints() {
        bottleUnit.translatesAutoresizingMaskIntoConstraints = false
        bottleUnit.centerYAnchor.constraint(equalTo: bottleSizeBackgroundView.centerYAnchor).isActive = true
        bottleUnit.leftAnchor.constraint(equalTo: bottleSizeBackgroundView.rightAnchor, constant: -50).isActive = true
        bottleUnit.rightAnchor.constraint(equalTo: bottleSizeBackgroundView.rightAnchor, constant: -2).isActive = true
    }
    
    //MARK: Setup save button constraints
    
    func setupSaveButtonConstraints() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: bottleSizeBackgroundView.bottomAnchor, constant: 20).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
}


extension ModalEditView: UITextFieldDelegate {
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
