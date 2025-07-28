//
//  HomeCollectionView.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 13.07.2025.
//

import PureLayout

protocol HomeCategoryCollectionViewDelegate: AnyObject {
    func tappedAddNewCategoryButton()
    func categoryDeleted(item: Category)
}

class HomeCategoryCollectionView: UIView {
    
    weak var delegate: HomeCategoryCollectionViewDelegate?
    
    var categoryItems: [Category]?
    
    private let categoryTitle: UILabel = {
        var lbl = UILabel()
        lbl.text = "Categories"
        lbl.textColor = .label
        lbl.textAlignment = .left
        lbl.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        return lbl
    }()
    
    private var collectionView: UICollectionView = {
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
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGreen.cgColor
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
        addSubview(categoryTitle)
        categoryTitle.autoPinEdge(.left, to: .left, of: self)
        categoryTitle.autoPinEdge(.top, to: .top, of: self)
        
        addSubview(collectionView)
        collectionView.autoPinEdge(.left, to: .left, of: self)
        collectionView.autoPinEdge(.top, to: .bottom, of: categoryTitle, withOffset: 8)
        collectionView.autoPinEdge(.bottom, to: .bottom, of: self)
        
        addSubview(addCategoryButton)
        addCategoryButton.autoPinEdge(.left, to: .right, of: collectionView, withOffset: 8)
        addCategoryButton.autoPinEdge(.right, to: .right, of: self, withOffset: -4)
        addCategoryButton.autoAlignAxis(.horizontal, toSameAxisOf: collectionView)
    }
    
    @objc func crateNewCategory() {
        delegate?.tappedAddNewCategoryButton()
    }
    
    func reloadData(categoryItems: [Category]) {
        self.categoryItems = categoryItems
        collectionView.reloadData()
    }
    
}

extension HomeCategoryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCollectionViewCell.identifier, for: indexPath) as! HomeCategoryCollectionViewCell
        
        cell.delegate = self
        
        let color = categoryItems?[indexPath.item].categoryColor?.decodeColor()
        cell.setUpButton(categoryName: categoryItems?[indexPath.row].categoryName, categoryColor: color)
        return cell
    }
}

extension HomeCategoryCollectionView: HomeCategoryCollectionViewCellDelegate {
    func homeCategoryCellDidTapDelete(cell: HomeCategoryCollectionViewCell) {
        
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        guard let categoryToRemove = categoryItems?[indexPath.row] else { return }
        
        if indexPath.item == 0 {
            self.showError(message: "This category cannot be deleted")
            return
        }
        
        delegate?.categoryDeleted(item: categoryToRemove)
        collectionView.reloadData()
    }
}

