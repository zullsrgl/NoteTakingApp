//
//  CategoryViewController.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 20.07.2025.
//

import PureLayout
import CoreData


class CategoryViewController: UIViewController {
    
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
    
    var categoryItems: [Category]?
    
    private let categoryView = CategoryView()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        
        guard let inputText = categoryView.categoryTextField.text, !inputText.isEmpty else  {
            self.showError(message: "Please enter category name ")
            return
        }
        
        if isCategoryExist(with: inputText){
            
            self.showError(message: "This category already exists")
            return
        }
        
        let newCategory = Category(context: context)
        newCategory.categoryName = inputText
        newCategory.categoryColor = categoryView.selectedColorView.backgroundColor?.encode()
        
        do {
            try self.context.save()
            self.showToast(message: "Successfully saved")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                
                self.dismiss(animated: true)
                self.categoryView.categoryTextField.placeholder = "Enter category name"
                self.categoryView.categoryTextField.text = ""
            }
            NotificationCenter.default.post(name: .didTapSaveButton, object: nil)
            
        } catch {
            print("fail: when client sadeved the category")
        }
    }
    
    private func isCategoryExist(with name: String) -> Bool {
        
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "categoryName ==[c] %@", name)
        
        do {
            let result = try context.fetch(fetchRequest)
            return !result.isEmpty
            
        }catch {
            return false
        }
    }
}

extension CategoryViewController: UIColorPickerViewControllerDelegate {
    func colorButtonClicked() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true)
        
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController){
        let color = viewController.selectedColor
        categoryView.selectedColor = color
        categoryView.selectedColorView.backgroundColor = color
    }
}

extension CategoryViewController: CategoryViewDelegate {
    func savedButton() {
        saveCategory()
    }
}
