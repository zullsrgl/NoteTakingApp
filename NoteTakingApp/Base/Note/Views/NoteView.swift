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
    
    private var typingStyles: Set<TextStyle> = []
    
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
        view.textContainerInset = UIEdgeInsets(top: 60, left: 0, bottom: 24, right: 0)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray2.cgColor
        view.autocapitalizationType = .none
        view.becomeFirstResponder()
        return view
    }()
    
    private let saveButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.backgroundColor = Color.primary
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        btn.isUserInteractionEnabled = true
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true
        return btn
    }()
    
    private let categoryLabel: PaddingLabel = {
        var lbl = PaddingLabel()
        lbl.layer.cornerRadius = 16
        lbl.text = "General"
        lbl.layer.borderColor = UIColor.systemGray2.cgColor
        lbl.layer.borderWidth = 1
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints  = false
        lbl.font = .systemFont(ofSize: 14)
        return lbl
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        noteTextEditorView.delegate = self
        textView.delegate = self
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        addSubview(categoryLabel)
        categoryLabel.autoSetDimension(.height, toSize: 42)
        categoryLabel.autoPinEdge(.top, to: .top, of: textView, withOffset: 12)
        categoryLabel.autoPinEdge(.right, to: .right, of: textView, withOffset: -16)
    }
    
    func selectedCategory(catgoryName: String){
        categoryLabel.text = catgoryName
    }
    
    func applyStyle(_ style: TextStyle) {
        let selectedRange = textView.selectedRange
        
        if selectedRange.length > 0 {
            toggleStyle(style, for: selectedRange)
        } else {
            if typingStyles.contains(style) {
                typingStyles.remove(style)
            } else {
                typingStyles.insert(style)
            }
        }
        
        func toggleStyle(_ style: TextStyle, for range: NSRange) {
            let mutableText = NSMutableAttributedString(attributedString: textView.attributedText)
            
            mutableText.enumerateAttributes(in: range, options: []) { attrs, subRange, _ in
                var newAttributes = attrs
                
                switch style {
                case .bold:
                    if let font = attrs[.font] as? UIFont {
                        let isBold = font.fontDescriptor.symbolicTraits.contains(.traitBold)
                        let newFont = isBold
                        ? UIFont.systemFont(ofSize: font.pointSize)
                        : UIFont.boldSystemFont(ofSize: font.pointSize)
                        newAttributes[.font] = newFont
                    }
                    
                case .italic:
                    if let font = attrs[.font] as? UIFont {
                        let isItalic = font.fontDescriptor.symbolicTraits.contains(.traitItalic)
                        let descriptor = font.fontDescriptor.withSymbolicTraits(
                            isItalic ? [] : [.traitItalic]
                        ) ?? font.fontDescriptor
                        newAttributes[.font] = UIFont(descriptor: descriptor, size: font.pointSize)
                    }
                    
                case .underline:
                    let current = (attrs[.underlineStyle] as? Int) ?? 0
                    if current == NSUnderlineStyle.single.rawValue {
                        newAttributes[.underlineStyle] = nil
                    } else {
                        newAttributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
                    }
                }
                
                mutableText.setAttributes(newAttributes, range: subRange)
            }
            
            textView.attributedText = mutableText
            textView.selectedRange = range
        }
    }
}

extension NoteView: NoteTextEditorViewDelegate{
    
    func didTapBoldButton() {
        applyStyle(.bold)
        
    }
    
    func didTapItalicButton() {
        applyStyle(.italic)
    }
    
    func didTapUnderlineButton() {
        applyStyle(.underline)
    }
    
    func didTapJustifyButton() {
        print("")
    }
    
    func didTapJustifyLeftButton() {
        print("")
    }
    
    func didTapJustifyRightButton() {
        print("")
    }
    
}

extension NoteView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard !text.isEmpty else { return true }
        
        let baseFont = UIFont.systemFont(ofSize: textView.font?.pointSize ?? 16)
        var descriptor = baseFont.fontDescriptor
        
        if typingStyles.contains(.bold) {
            descriptor = descriptor.withSymbolicTraits([.traitBold]) ?? descriptor
        }
        if typingStyles.contains(.italic) {
            descriptor = descriptor.withSymbolicTraits([.traitItalic]) ?? descriptor
        }
        
        let font = UIFont(descriptor: descriptor, size: baseFont.pointSize)
        var attributes: [NSAttributedString.Key: Any] = [.font: font]
        
        if typingStyles.contains(.underline) {
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        
        let newAttr = NSAttributedString(string: text, attributes: attributes)
        
        let mutableText = NSMutableAttributedString(attributedString: textView.attributedText)
        mutableText.replaceCharacters(in: range, with: newAttr)
        textView.attributedText = mutableText
        textView.selectedRange = NSRange(location: range.location + text.count, length: 0)
        
        return false
    }
}


