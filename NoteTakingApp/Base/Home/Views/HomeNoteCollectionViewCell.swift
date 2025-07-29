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
        view.backgroundColor = .random
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        contentView.addSubview(bgView)
        bgView.autoPinEdgesToSuperviewEdges()
        
        bgView.addSubview(noteButton)
        noteButton.autoPinEdgesToSuperviewEdges()
        
        bgView.addSubview(titleLabel)
        titleLabel.autoPinEdge(.left, to: .left, of: bgView, withOffset: 8)
        titleLabel.autoPinEdge(.top, to: .top, of: bgView, withOffset: 8)
        
    }
    
    func createNote() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)
        let image = UIImage(systemName: "plus.square.fill", withConfiguration: largeConfig)
        
        titleLabel.text = ""
        
        noteButton.setImage(image, for: .normal)
        noteButton.layer.borderWidth = 1
        noteButton.backgroundColor = .white
        noteButton.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    private func resetCell() {
        noteButton.setImage(nil, for: .normal)
        noteButton.layer.borderWidth = 0
        noteButton.backgroundColor = .clear
        noteButton.layer.borderColor = nil
    }
}
