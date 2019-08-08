//
//  FirstTimeOpenModal.swift
//  WaterApp
//
//  Created by Ahmad Ibrahim on 8/2/19.
//  Copyright © 2019 WW. All rights reserved.
//

import Foundation
import UIKit


class ModalEditController: UIViewController {
    
    let mainView: ModalEditView
    let viewModel: WaterViewModel
    
    init(view: ModalEditView, viewModel: WaterViewModel) {
        self.mainView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.weightField.becomeFirstResponder()
    }

    func setupViews() {
        view = mainView
        mainView.delegate = self
    }
}

extension ModalEditController: ModalViewDelegate {
    func saveWasClicked(in view: ModalEditView) {
        viewModel.weightUPDATE()
        viewModel.bottleSizeUPDATE()
        viewModel.reload()
        self.dismiss(animated: true, completion: nil)
    }
    
    func weightWasChanged(in view: ModalEditView, newWeight: String) {
        let newWeightInt = Int(newWeight)
        viewModel.setWeight(weight: newWeightInt ?? 0)
    }
    
    func bottleSizeWasChanged(in view: ModalEditView, newSize: String) {
        let newSizeInt = Int(newSize)
        viewModel.setBottleSize(size: newSizeInt ?? 1)
    }
}
