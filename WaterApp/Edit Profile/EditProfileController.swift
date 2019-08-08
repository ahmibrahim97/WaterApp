//
//  EditProfileController.swift
//  WaterApp
//
//  Created by Ahmad Ibrahim on 7/25/19.
//  Copyright © 2019 WW. All rights reserved.
//

import UIKit

class EditProfileController: UIViewController {
    let mainView: EditProfileView
    let viewModel: WaterViewModel
    
    init(view: EditProfileView, viewModel: WaterViewModel) {
        self.mainView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavbar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.weightInput.becomeFirstResponder()
    }
    
    func setupViews() {
        view = mainView
        mainView.delegate = self
        mainView.dataSource = self
        mainView.setWeight(weight: viewModel.getWeight())
        mainView.setBottleSize(size: viewModel.getBottleSize())
    }
    
    func setupNavbar() {
        title = "Edit Your Profile"
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(didTapSaveButton))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func didTapSaveButton() {
        viewModel.weightUPDATE()
        viewModel.bottleSizeUPDATE()
        self.navigationController?.popViewController(animated: true)
    }
}

extension EditProfileController: EditProfileViewDataSource {
    func getBottleSize(in view: EditProfileView) -> Int {
        return viewModel.getBottleSize()
    }

    func getUserWeight(in view: EditProfileView) -> Int {
        return viewModel.getWeight()
    }
}

extension EditProfileController: EditProfileViewDelegate {
    func sizeOfBottleWasChanged(in view: EditProfileView, newSize: String) {
        let newSizeInt = Int(newSize)
        viewModel.setBottleSize(size: newSizeInt ?? 1)
    }
    
    func weightWasChanged(in view: EditProfileView, newWeight: String) {
        let newWeightInt = Int(newWeight)
        viewModel.setWeight(weight: newWeightInt ?? 0)
    }
}
