//
//  ViewController.swift
//  WaterApp
//
//  Created by Ahmad Ibrahim on 7/8/19.
//  Copyright © 2019 WW. All rights reserved.
//

import UIKit

class WaterViewController: UIViewController {

    let mainView: WaterMainView
    let viewModel: WaterViewModel
    
    let navBar = UINavigationBar()
    
    init(view: WaterMainView, viewModel: WaterViewModel) {
        self.mainView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel.firstTimeLaunching() {
            showModal()
        }
        setupView()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadView()
    }

    //setup
    func setupView() {
        view = mainView
        mainView.delegate = self
        mainView.dataSource = self
        reloadView()
        setupNavBar()
    }
    
    func setupViewModel() {
        viewModel.delegate = self
    }
    
    func setupNavBar() {
        title = "Water Watchers"
        let titleFont = UIFont(name: "MarkerFelt-Wide", size: 30)!
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: titleFont, NSAttributedString.Key.strokeColor: UIColor.red]
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setTitleVerticalPositionAdjustment(CGFloat(20), for: UIBarMetrics.default)
        
        let editProfileButton = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(didTapEditProfile))
        navigationItem.rightBarButtonItem = editProfileButton
    }
    
    func reloadView() {
        mainView.checkBoxCollectionView.reloadData()
    }
    
    @objc func didTapEditProfile() {
        let editProfileController = EditProfileController(view: EditProfileView(), viewModel: viewModel)
        self.navigationController?.pushViewController(editProfileController, animated: true)
    }
    
    func showModal() {
        let modalViewController = ModalEditController(view: ModalEditView(), viewModel: viewModel)
        modalViewController.modalPresentationStyle = .overCurrentContext
        present(modalViewController, animated: true, completion: nil)
    }
    
    func celebrate() {
        self.mainView.confettiView.startConfetti()
        self.mainView.confettiView2.startConfetti()
        let alert = UIAlertController(title: "Good Job!", message: "You drank your recommended water for the day! You are on the road to a healthier lifestyle, GREAT JOB!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "WOOOOOOOOOOO!", style: .default, handler: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.mainView.confettiView.stopConfetti()
                self.mainView.confettiView2.stopConfetti()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension WaterViewController: WaterMainViewDelegate {
    func didTapDrankWaterButton() {
        let path = IndexPath(item: viewModel.getCheckedBoxes(), section: 0)
        let currCell = mainView.checkBoxCollectionView.cellForItem(at: path) as? CheckedBoxCell
        currCell?.checkOffBox()
        viewModel.checkedBoxesUPDATE()
    }
    
    func didTapReset() {
        viewModel.resetCheckedBoxes()
        reloadView()
    }
    
    func didTapUndo() {
        
        let path = IndexPath(item: viewModel.getCheckedBoxes() - 1, section: 0)
        let currCell = mainView.checkBoxCollectionView.cellForItem(at: path) as? CheckedBoxCell
        currCell?.uncheckOffBox()
        
        viewModel.undoCheckedBox()
//        reloadView()
    }
}

extension WaterViewController: WaterMainViewDataSource {
    func numberOfBoxes() -> Int {
        return viewModel.getNumberOfCups()
    }
    
    func indexOfTappedButton() -> Int {
        return viewModel.getCheckedBoxes()
    }
    
    func highlightedIndex() -> Int {
        return viewModel.highlightIndex()
    }
}

extension WaterViewController: WaterViewModelDelegate {
    func completedAllCheckboxes(from viewModel: WaterViewModel) {
        self.celebrate()
    }
    
    func reloadViewData(from: WaterViewModel) {
        self.reloadView()
    }
}
