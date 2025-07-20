//
//  HomeCollectionView.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 13.07.2025.
//

import PureLayout

protocol HomeCategoryCollectionViewDelegate: AnyObject {
    func tappedAddNewCategoryButton()
}


class HomeCategoryCollectionView: UIView {
    
    weak var delegate: HomeCategoryCollectionViewDelegate?
    
    private let collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        
        var view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.allowsMultipleSelection = false
        view.alwaysBounceHorizontal = true
        view.alwaysBounceVertical = false
        view.bounces = true
        view.contentInsetAdjustmentBehavior = .never
        view.scrollsToTop = false
        view.decelerationRate = .fast
        return view
    }()
    
    private let addCategoryButton: UIButton  = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .systemGreen
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCategoryCollectionViewCell.self, forCellWithReuseIdentifier: HomeCategoryCollectionViewCell.identifier)
        addCategoryButton.addTarget(self, action: #selector(crateNewCategory), for: .touchUpInside)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(collectionView)
        collectionView.autoPinEdge(.left, to: .left, of: self)
        collectionView.autoPinEdge(.top, to: .top, of: self)
        collectionView.autoPinEdge(.bottom, to: .bottom, of: self)
        
        addSubview(addCategoryButton)
        addCategoryButton.autoPinEdge(.left, to: .right, of: collectionView, withOffset: 8)
        addCategoryButton.autoPinEdge(.right, to: .right, of: self, withOffset: -8)
        addCategoryButton.autoPinEdge(.top, to: .top, of: self, withOffset: 8)
        addCategoryButton.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -8)
    }
    
    @objc func crateNewCategory() {
        delegate?.tappedAddNewCategoryButton()
    }
}

extension HomeCategoryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCollectionViewCell.identifier, for: indexPath) as! HomeCategoryCollectionViewCell
        return cell
    }
}
