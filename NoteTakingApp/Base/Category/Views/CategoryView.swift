//
//  CategoryView.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 20.07.2025.
//

import PureLayout

protocol CategoryViewDelegate: AnyObject {
    func clickedButton()
}

class CategoryView: UIView {
    
    weak var delegate: CategoryViewDelegate?
    var selectedColor: UIColor = UIColor.white
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return stackView
    }()
    
    private var categoryTextField: UITextField = {
        var txt = UITextField()
        txt.placeholder = "Enter category name"
        txt.font = .systemFont(ofSize: 18, weight: .medium)
        txt.textAlignment = .center
        txt.layer.borderColor = UIColor.systemGray.cgColor
        txt.textColor = .label
        txt.layer.borderWidth = 1
        txt.layer.cornerRadius = 4
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
     let colorButton: UIButton = {
        var button = UIButton()
        button.setTitle("Click me", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.isUserInteractionEnabled = true
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        colorButton.addTarget(self, action: #selector(selectColor), for: .touchUpInside)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(stackView)
        stackView.autoPinEdgesToSuperviewEdges()
        
        stackView.addSubview(categoryTextField)
        categoryTextField.autoPinEdge(.top, to: .top, of: self, withOffset: 40)
        categoryTextField.autoPinEdge(.left, to: .left, of: self, withOffset: 20)
        categoryTextField.autoPinEdge(.right, to: .right, of: self, withOffset: -20)
        categoryTextField.autoSetDimension(.height, toSize: 36)
        
        stackView.addSubview(colorButton)
        colorButton.autoPinEdge(.top, to: .bottom, of: categoryTextField,withOffset: 12)
        colorButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        colorButton.autoAlignAxis(toSuperviewAxis: .vertical)
        colorButton.autoSetDimension(.height, toSize: 124)
        colorButton.autoSetDimension(.width, toSize: UIScreen.main.bounds.width - 40)
    }
    
    @objc private func selectColor() {
        delegate?.clickedButton()
    }
}
