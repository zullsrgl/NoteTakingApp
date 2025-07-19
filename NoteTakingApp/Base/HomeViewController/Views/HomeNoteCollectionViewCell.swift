//
//  HomeNoteCollectionViewCell.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 13.07.2025.
//

import PureLayout

class HomeNoteCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "homeNoteCollectionViewCell"
    
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
        lbl.text = "Note Başlığı"
        lbl.numberOfLines = 1
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        contentView.addSubview(bgView)
        bgView.autoPinEdgesToSuperviewEdges()
        
        bgView.addSubview(titleLabel)
        titleLabel.autoPinEdge(.left, to: .left, of: bgView, withOffset: 8)
        titleLabel.autoPinEdge(.top, to: .top, of: bgView, withOffset: 8)
        
    }
}
