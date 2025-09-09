//
//  NoteTextEditor.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 19.07.2025.
//

import PureLayout

protocol NoteTextEditorViewDelegate: AnyObject {
    func didTapBoldButton()
    func didTapItalicButton()
    func didTapUnderlineButton()
    func didTapJustifyButton()
    func didTapJustifyLeftButton()
    func didTapJustifyRightButton()
}

class NoteTextEditorView: UIView {
    
    weak var delegate: NoteTextEditorViewDelegate?
    private var isSelected: Bool = false
    
    private let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.backgroundColor = Color.secondary
        stackView.layer.cornerRadius = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let boldButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "bold"), for: .normal)
        button.tintColor = Color.white
        return button
    }()
    
    private let italicButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "italic"), for: .normal)
        button.tintColor = Color.white
        return button
    }()
    
    private let underlineButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "underline"), for: .normal)
        button.tintColor = Color.white
        return button
    }()
    
    
    private let justifyButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "text.justify"), for: .normal)
        button.tintColor = Color.white
        return button
    }()
    
    private let justifyRightButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "text.justify.right"), for: .normal)
        button.tintColor = Color.white
        return button
    }()
    
    private let justifyLeftButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "text.justify.left"), for: .normal)
        button.tintColor = Color.white
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        boldButton.addTarget(self, action: #selector(boldText), for: .touchUpInside)
        italicButton.addTarget(self, action: #selector(italicText), for: .touchUpInside)
        underlineButton.addTarget(self, action: #selector(underlineText), for: .touchUpInside)
        justifyRightButton.addTarget(self, action: #selector(textJustifyRightText), for: .touchUpInside)
        justifyLeftButton.addTarget(self, action: #selector(textJustifyLeftText), for: .touchUpInside)
        justifyButton.addTarget(self, action: #selector(textJustifyText), for: .touchUpInside)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        addSubview(stackView)
        stackView.autoPinEdgesToSuperviewEdges()
        
        stackView.addArrangedSubview(boldButton)
        stackView.addArrangedSubview(italicButton)
        stackView.addArrangedSubview(underlineButton)
        stackView.addArrangedSubview(justifyButton)
        stackView.addArrangedSubview(justifyRightButton)
        stackView.addArrangedSubview(justifyLeftButton)
        
    }
    
    @objc func boldText(){
        delegate?.didTapBoldButton()
        boldButton.isSelected.toggle()
        boldButton.tintColor = boldButton.isSelected ? Color.primary : Color.white
    }
    @objc func italicText(){
        delegate?.didTapItalicButton()
        italicButton.isSelected.toggle()
        italicButton.tintColor = italicButton.isSelected ? Color.primary : Color.white
        
    }
    @objc func underlineText(){
        delegate?.didTapUnderlineButton()
        underlineButton.isSelected.toggle()
        underlineButton.tintColor = underlineButton.isSelected ? Color.primary : Color.white
        
    }
    @objc func textJustifyRightText(){
        delegate?.didTapJustifyRightButton()
        justifyRightButton.isSelected.toggle()
        justifyRightButton.tintColor = justifyRightButton.isSelected ? Color.primary : Color.white
    }
    @objc func textJustifyLeftText(){
        delegate?.didTapJustifyLeftButton()
        justifyLeftButton.isSelected.toggle()
        justifyLeftButton.tintColor = justifyLeftButton.isSelected ? Color.primary : Color.white
        
    }
    @objc func textJustifyText(){
        delegate?.didTapJustifyButton()
        justifyButton.isSelected.toggle()
        justifyButton.tintColor = justifyButton.isSelected ? Color.primary : Color.white
        
    }
}
