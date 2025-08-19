//
//  HomeNoteCollectionViewCell.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 13.07.2025.
//

import PureLayout

class HomeNoteCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "homeNoteCollectionViewCell"
    
    private let noteButton: UIButton = {
        var btn = UIButton()
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 16
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    private let bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12, weight: .bold)
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private let noteContentLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = .label
        lbl.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }
    
    private func setUpUI(){
        contentView.addSubview(bgView)
        bgView.autoPinEdgesToSuperviewEdges()
        
        bgView.addSubview(noteButton)
        noteButton.autoPinEdgesToSuperviewEdges()
        
        bgView.addSubview(titleLabel)
        titleLabel.autoPinEdge(.left, to: .left, of: bgView, withOffset: 8)
        titleLabel.autoPinEdge(.top, to: .top, of: bgView, withOffset: 8)
        titleLabel.autoSetDimension(.height, toSize: 12)
        
        bgView.addSubview(noteContentLabel)
        noteContentLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 4)
        noteContentLabel.autoPinEdge(.bottom, to: .bottom, of: bgView)
        noteContentLabel.autoPinEdge(.right, to: .right, of: bgView)
        noteContentLabel.autoPinEdge(.left, to: .left, of: bgView, withOffset: 8)
        
    }
    
    func createNote() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)
        let image = UIImage(systemName: "plus.square.fill", withConfiguration: largeConfig)
        
        noteButton.setImage(image, for: .normal)
        noteButton.layer.borderWidth = 1
        noteButton.backgroundColor = .white
        noteButton.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    func setCell(note: Note?) {
        guard let noteTitle = note?.noteTitle else {
            return
        }
        guard let color = note?.category?.categoryColor?.decodeColor() else {return}
        
        titleLabel.text = noteTitle
        noteContentLabel.text = note?.note
        bgView.layer.borderColor = color.cgColor
        bgView.layer.borderWidth = 2
        bgView.layer.cornerRadius = 10
    }
    
    private func resetCell() {
        noteButton.setImage(nil, for: .normal)
        noteButton.layer.borderWidth = 0
        noteButton.backgroundColor = .clear
        noteButton.layer.borderColor = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
