//
//  CategoryViewController.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 20.07.2025.
//

import PureLayout

class CategoryViewController: UIViewController, CategoryViewDelegate {
    
    private let stackContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let categoryView = CategoryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Create Category"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(goBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveNote))
        categoryView.delegate = self
        setUpUI()
    }
    
    private func setUpUI(){
        view.addSubview(stackContainerView)
        stackContainerView.autoPinEdgesToSuperviewEdges()
        
        stackContainerView.addArrangedSubview(categoryView)
        categoryView.autoSetDimension(.height, toSize: 56.0)
        categoryView.autoPinEdge(.left, to: .left, of: stackContainerView)
        categoryView.autoPinEdge(.right, to: .right, of: stackContainerView)
    }
    
    @objc func goBack() {
        //TODO: alert box for if client don't save the text
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveNote() {
        //TODO: when client clik the save button i will save in local db -> (core data) and show success or error message
        print("category save button clicked")
    }
}

extension CategoryViewController: UIColorPickerViewControllerDelegate {
    func clickedButton() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true)
        
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController){
        let color = viewController.selectedColor
        categoryView.selectedColor = color
        categoryView.colorButton.backgroundColor = color
    }
}
