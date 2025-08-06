//
//  CategoryViewController.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 20.07.2025.
//

import PureLayout
import CoreData


class CategoryViewController: UIViewController {
    
    private let categoryView = CategoryView()
    private let viewModel = CategoryViewModel()
    
    private let stackContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        var lbl = UILabel()
        lbl.text = "Create Category"
        lbl.textColor = .label
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        categoryView.delegate = self
        setUpUI()
    }
    
    private func setUpUI(){
        view.addSubview(stackContainerView)
        stackContainerView.autoPinEdgesToSuperviewEdges()
        
        stackContainerView.addSubview(titleLabel)
        titleLabel.autoPinEdge(.left, to: .left, of: stackContainerView)
        titleLabel.autoPinEdge(.right, to: .right, of: stackContainerView)
        titleLabel.autoPinEdge(.top, to: .top, of: stackContainerView, withOffset: 40)
        
        stackContainerView.addSubview(categoryView)
        categoryView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 32)
        categoryView.autoSetDimension(.width, toSize: UIScreen.main.bounds.width - 32)
        categoryView.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
    @objc private func saveCategory() {
        
        guard let inputText = categoryView.getTextField(), !inputText.isEmpty else  {
            self.showError(message: "Please enter category name ")
            return
        }
        
        if viewModel.categoryExists(name: inputText){
            self.showError(message: "This category already exists")
            return
        }
        viewModel.createCategory(categoryName: inputText, categoryColor: categoryView.selectedColor)
        self.showToast(message: "Successfully saved")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.dismiss(animated: true)
        }
    }
}

extension CategoryViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController){
        let color = viewController.selectedColor
        categoryView.selectedColor = color
    }
}

extension CategoryViewController: CategoryViewDelegate {
    func colorButtonClicked() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true)
        
    }
    
    func saveCategoryButtonClicked() {
        saveCategory()
    }
}
