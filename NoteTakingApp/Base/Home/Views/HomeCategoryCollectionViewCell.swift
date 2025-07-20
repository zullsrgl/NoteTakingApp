//
//  HomeCollectionViewCell.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 13.07.2025.
//
import PureLayout

class HomeCategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "homeCollectionViewCell"
    
    private let categoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("all", for: .normal)
        button.tintColor = UIColor.label
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        self.addSubview(categoryButton)
        categoryButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        categoryButton.autoSetDimension(.height, toSize: 24)
    }
}
