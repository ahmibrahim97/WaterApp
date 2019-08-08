//
//  checkedBoxes.swift
//  WaterApp
//
//  Created by Ahmad Ibrahim on 7/17/19.
//  Copyright © 2019 WW. All rights reserved.
//

import Foundation
import UIKit

class CheckedBoxCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: CheckedBoxCell.self)
    let imageView: UIImageView = UIImageView()
    let fullCup = #imageLiteral(resourceName: "waterFull")
    let emptyCup = #imageLiteral(resourceName: "waterEmpty")
    let highlightedCup = #imageLiteral(resourceName: "highlightedFull")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .white
        imageView.image = emptyCup
        self.contentView.addSubview(imageView)
        }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    func checkOffBox() {
        imageView.loadGif(asset: "waterFilling")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            self.imageView.image = self.fullCup
        }
    }
    
    func uncheckOffBox() {
        imageView.loadGif(asset: "waterReverse")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.15) {
            self.imageView.image = self.emptyCup
        }
    }
    
    func highlightBox() {
        self.imageView.image = self.highlightedCup
    }
}

