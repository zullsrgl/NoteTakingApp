//
//  NoteTextEditor.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 19.07.2025.
//

import PureLayout

class NoteTextEditor: UIView {
    
    private let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.backgroundColor = .label
        stackView.layer.cornerRadius = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let boldButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "bold"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let italicButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "italic"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let underlineButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "underline"), for: .normal)
        button.tintColor = .white
        return button
    }()
    

    private let justifyButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "text.justify"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let justifyRightButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "text.justify.right"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let justifyLeftButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "text.justify.left"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        addSubview(stackView)
        stackView.autoPinEdge(.left, to: .left, of: self, withOffset: 16)
        stackView.autoPinEdge(.right, to: .right, of: self, withOffset: -16)
        stackView.autoSetDimension(.height, toSize: 56)
        
        stackView.addArrangedSubview(boldButton)
        stackView.addArrangedSubview(italicButton)
        stackView.addArrangedSubview(underlineButton)
        stackView.addArrangedSubview(justifyButton)
        stackView.addArrangedSubview(justifyRightButton)
        stackView.addArrangedSubview(justifyLeftButton)
        
    }
    
    //TODO: -cratate objc func for editor button
    
}
