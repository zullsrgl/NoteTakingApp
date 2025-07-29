//
//  NoteView.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 29.07.2025.
//

import PureLayout

class NoteView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    private let bgView: UIView = {
        var view = UIView()
        return view
    }()
    private let noteTextEditorView = NoteTextEditor()
    
    private let noteTitle: UILabel = {
        var lbl = UILabel()
        lbl.text = "Note"
        lbl.textColor = .label
        lbl.textAlignment = .left
        lbl.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        return lbl
    }()
    
    private let textView: UITextView = {
        let view = UITextView()
        view.layer.cornerRadius = 16
        view.font = UIFont.systemFont(ofSize: 16)
        view.textContainerInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray2.cgColor
        view.becomeFirstResponder()
        return view
    }()
    
    private let saveButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.backgroundColor = .systemGreen
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        btn.isUserInteractionEnabled = true
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true
        return btn
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpUI()
    }
    
    private func setUpUI() {
        
        addSubview(stackView)
        stackView.autoPinEdgesToSuperviewEdges()
        
        stackView.addArrangedSubview(noteTitle)
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(bgView)
        
        bgView.addSubview(saveButton)
        saveButton.autoPinEdge(.top, to: .top, of: bgView)
        saveButton.autoPinEdge(.right, to: .right, of: bgView)
        saveButton.autoPinEdge(.bottom, to: .bottom, of: bgView)
        saveButton.autoSetDimension(.height, toSize: 48)
        saveButton.autoSetDimension(.width, toSize: 100)
        
        bgView.addSubview(noteTextEditorView)
        noteTextEditorView.autoPinEdge(.right, to: .left, of: saveButton, withOffset: -4)
        noteTextEditorView.autoPinEdge(.top, to: .top, of: bgView)
        noteTextEditorView.autoPinEdge(.left, to: .left, of: bgView)
        noteTextEditorView.autoPinEdge(.bottom, to: .bottom, of: bgView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
