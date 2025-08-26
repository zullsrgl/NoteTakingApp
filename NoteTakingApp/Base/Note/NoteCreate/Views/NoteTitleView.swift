//
//  NoteTitleView.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 29.07.2025.
//


import PureLayout

class NoteTitleView: UIView {
    
    private let bgView: UIView = {
        var view = UIView()
        return view
    }()
    
    private let noteTitle: UILabel = {
        var lbl = UILabel()
        lbl.text = "Title"
        lbl.textColor = .label
        lbl.textAlignment = .left
        lbl.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        return lbl
    }()
    
    private let noteTextField: UITextField = {
        var paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        var txtField = UITextField()
        txtField.placeholder = "Enter title"
        txtField.leftView = paddingView
        txtField.leftViewMode = .always
        txtField.font = .systemFont(ofSize: 14, weight: .medium)
        txtField.textAlignment = .left
        txtField.textColor = .label
        txtField.layer.borderWidth = 1
        txtField.layer.cornerRadius = 16
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpUI()
    }
    
    private func setUpUI() {
        addSubview(bgView)
        bgView.autoPinEdgesToSuperviewEdges()
        
        bgView.addSubview(noteTitle)
        noteTitle.autoPinEdge(.left, to: .left, of: bgView)
        noteTitle.autoPinEdge(.top, to: .top, of: bgView)
        
        bgView.addSubview(noteTextField)
        noteTextField.autoPinEdge(.top, to: .bottom, of: noteTitle, withOffset: 8)
        noteTextField.autoPinEdge(.left, to: .left, of: bgView)
        noteTextField.autoPinEdge(.right, to: .right, of: bgView)
        noteTextField.autoSetDimension(.height, toSize: 40)
    }
    
    func getNoteTitle() -> String?  {
        guard let title = noteTextField.text, !title.isEmpty else {
            return nil
        }
        return title
    }
    
    func loadNoteTitle(title: String?){
        noteTextField.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
