//
//  MainView.swift
//  WaterApp
//
//  Created by Ahmad Ibrahim on 7/8/19.
//  Copyright © 2019 WW. All rights reserved.
//

import Foundation
import UIKit
import SAConfettiView

protocol WaterMainViewDelegate: class {
    func didTapDrankWaterButton()
    func didTapReset()
    func didTapUndo()
}

protocol WaterMainViewDataSource: class {
    func numberOfBoxes() -> Int
    func indexOfTappedButton() -> Int
    func highlightedIndex() -> Int
}

class WaterMainView: UIView {
    weak var delegate: WaterMainViewDelegate?
    weak var dataSource: WaterMainViewDataSource?
    
    let drankWaterButton = UIButton(type: .custom)
    let resetButton = UIButton(type: .custom)
    let undoButton = UIButton(type: .custom)
    let drankWaterButtonSize: CGFloat = 200
    let checkBoxCollectionView: UICollectionView
    let cellId = "cellid"
    let screenSize = UIScreen.main.bounds
    
    var confettiView = SAConfettiView()
    var confettiView2 = SAConfettiView()
    
    let waterBlue = UIColor.init(red: 112/255, green: 211/255, blue: 236/255, alpha: 1)
    
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        checkBoxCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented for NewGalleryView.swift")
    }
    
    
    
    //MARK: Setup Views
    
    func setupView() {
        setupDrankWaterButton()
        setupCollectionView()
        setupResetButton()
        setupUndoButton()
        setupConfetti()
    }
    
    
    func setupDrankWaterButton() {
        drankWaterButton.setTitle("Drank A Cup", for: .normal)
        drankWaterButton.backgroundColor = waterBlue
        drankWaterButton.layer.cornerRadius = drankWaterButtonSize / 2
        drankWaterButton.layer.masksToBounds = true
        drankWaterButton.clipsToBounds = true
        drankWaterButton.addTarget(self, action: #selector(didTapDrankWaterButton(sender: )), for: .touchUpInside)
        addSubview(drankWaterButton)
    }

    func setupCollectionView() {
        checkBoxCollectionView.dataSource = self
        checkBoxCollectionView.backgroundColor = .white
        checkBoxCollectionView.allowsSelection = false
        
        
        checkBoxCollectionView.register(CheckedBoxCell.self, forCellWithReuseIdentifier: CheckedBoxCell.reuseIdentifier)
        addSubview(checkBoxCollectionView)
    }

    func setupUndoButton() {
        undoButton.setImage(#imageLiteral(resourceName: "backArrow"), for: .normal)
        undoButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        undoButton.backgroundColor = waterBlue
        undoButton.addTarget(self, action: #selector(didTapUndo), for: .touchUpInside)
        addSubview(undoButton)
    }

    func setupResetButton() {
        resetButton.setImage(#imageLiteral(resourceName: "white arrow reload"), for: .normal)
        resetButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        resetButton.backgroundColor = waterBlue
        resetButton.addTarget(self, action: #selector(didTapReset), for: .touchUpInside)
        addSubview(resetButton)
    }
    
    func setupConfetti() {
        self.confettiView = SAConfettiView(frame: self.bounds)
        confettiView.type = .Image(#imageLiteral(resourceName: "ww_logo_58"))
        confettiView.intensity = 0.5
        addSubview(confettiView)
        
        self.confettiView2 = SAConfettiView(frame: self.bounds)
        confettiView2.type = .Star
        confettiView2.intensity = 0.5
        addSubview(confettiView2)
    }

    // MARK: Setup Constraints

    func setupConstraints() {
        setupDrankWaterButtonConstraints()
        setupCollectionViewConstraints()
        setupResetButtonConstraints()
        setupUndoButtonConstraints()
    }
    
    func setupDrankWaterButtonConstraints() {
        drankWaterButton.translatesAutoresizingMaskIntoConstraints = false
        drankWaterButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -20).isActive = true
        drankWaterButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -70).isActive = true
        drankWaterButton.heightAnchor.constraint(equalToConstant: drankWaterButtonSize).isActive = true
        drankWaterButton.widthAnchor.constraint(equalToConstant: drankWaterButtonSize).isActive = true
    }
    
    func setupCollectionViewConstraints() {
        checkBoxCollectionView.translatesAutoresizingMaskIntoConstraints = false
        checkBoxCollectionView.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
        checkBoxCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        checkBoxCollectionView.topAnchor.constraint(equalTo: drankWaterButton.bottomAnchor, constant: 30).isActive = true
        checkBoxCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupResetButtonConstraints() {
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        resetButton.centerYAnchor.constraint(equalTo: drankWaterButton.centerYAnchor, constant: -40).isActive = true
    }
    
    func setupUndoButtonConstraints() {
        undoButton.translatesAutoresizingMaskIntoConstraints = false
        undoButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        undoButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        undoButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        undoButton.centerYAnchor.constraint(equalTo: drankWaterButton.centerYAnchor, constant: 40).isActive = true
    }

    @objc private func didTapDrankWaterButton(sender: UIButton) {
        delegate?.didTapDrankWaterButton()
    }
    
    @objc private func didTapReset(sender: UIButton) {
        delegate?.didTapReset()
    }
    
    @objc private func didTapUndo(sender: UIButton) {
        delegate?.didTapUndo()
    }
}

extension WaterMainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.numberOfBoxes() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CheckedBoxCell.reuseIdentifier, for: indexPath) as? CheckedBoxCell else { return UICollectionViewCell() }
        if (indexPath.item < dataSource?.indexOfTappedButton() ?? 0) {
            cell.imageView.image = cell.fullCup
        } else {
            if indexPath.item < dataSource?.highlightedIndex() ?? 0 {
                cell.imageView.image = cell.highlightedCup
            } else {
                cell.imageView.image = cell.emptyCup
            }
        }
        return cell
    }
}

extension WaterMainView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let leftAndRightPaddings: CGFloat = 10.0
        let numberOfItemsPerRow: CGFloat = 40

        let width = (collectionView.frame.width - leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: width)
    }
}
