//
//  CategoryView.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 20.07.2025.
//

import PureLayout

protocol CategoryViewDelegate: AnyObject {
    func colorButtonClicked()
    func saveCategoryButtonClicked()
}

class CategoryView: UIView {
    
    weak var delegate: CategoryViewDelegate?
    
    var selectedColor: UIColor = Color.white{
        didSet{
            selectedColorView.backgroundColor = selectedColor
        }
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.distribution = .fillEqually
        stackView.spacing = 32
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return stackView
    }()
    
    private let categoryTextField: UITextField = {
        var paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        var txt = UITextField()
        txt.placeholder = "Enter category name"
        txt.leftView = paddingView
        txt.leftViewMode = .always
        txt.font = .systemFont(ofSize: 14, weight: .medium)
        txt.textAlignment = .left
        txt.layer.borderColor = UIColor.systemGray.cgColor
        txt.textColor = .label
        txt.layer.borderWidth = 1
        txt.layer.cornerRadius = 16
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private let colorButton: UIButton = {
        var button = UIButton()
        button.setTitle("Pick Color", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.isUserInteractionEnabled = true
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        return button
    }()
    
    private let selectedColorView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 26
        view.backgroundColor = .gray
        return view
    }()
    
    private let saveButton: UIButton = {
        var button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.isUserInteractionEnabled = true
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        colorButton.addTarget(self, action: #selector(colorButtonClicked), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveCategory), for: .touchUpInside)
        
        setupUI()
    }
    
    private func setupUI() {
        
        addSubview(stackView)
        stackView.autoPinEdgesToSuperviewEdges()
        
        stackView.addArrangedSubview(categoryTextField)
        categoryTextField.autoSetDimension(.height, toSize: 40)
        categoryTextField.autoPinEdge(.left, to: .left, of: self)
        categoryTextField.autoPinEdge(.right, to: .right, of: self)
        
        stackView.addArrangedSubview(colorButton)
        colorButton.autoSetDimension(.height, toSize: 64)
        colorButton.autoSetDimension(.width, toSize: 100)
        
        stackView.addSubview(selectedColorView)
        selectedColorView.autoAlignAxis(.horizontal, toSameAxisOf: colorButton)
        selectedColorView.autoSetDimension(.height, toSize: 52)
        selectedColorView.autoSetDimension(.width, toSize: 52)
        selectedColorView.autoPinEdge(.right, to: .right, of: self)
        
        stackView.setCustomSpacing(150, after: colorButton)
        
        stackView.addArrangedSubview(saveButton)
        saveButton.autoSetDimension(.height, toSize: 52)
        saveButton.autoPinEdge(.bottom, to: .bottom, of: stackView)
        saveButton.autoPinEdge(.left, to: .left, of: stackView)
        saveButton.autoPinEdge(.right, to: .right, of: stackView)
    }
    
    func getTextField() -> String? {
        return categoryTextField.text
    }
    
    @objc private func colorButtonClicked() {
        delegate?.colorButtonClicked()
    }
    
    @objc private func saveCategory() {
        delegate?.saveCategoryButtonClicked()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.selectedColorView.backgroundColor = .gray
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
