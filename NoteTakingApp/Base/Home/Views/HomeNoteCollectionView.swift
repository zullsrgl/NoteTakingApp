//
//  HomeNoteCollectionView.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 13.07.2025.
//

import PureLayout

protocol HomeNoteCollectionViewDelegate: AnyObject {
    func createNoteTapped()
    func noteDetailTapped()
}

class HomeNoteCollectionView: UIView {
    
    weak var delegate: HomeNoteCollectionViewDelegate?
    var noteItem: [Note]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        
        var view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.allowsMultipleSelection = false
        view.alwaysBounceHorizontal = false
        view.alwaysBounceVertical = true
        view.bounces = true
        view.contentInsetAdjustmentBehavior = .never
        view.scrollsToTop = false
        view.decelerationRate = .fast
        view.translatesAutoresizingMaskIntoConstraints = false
        view.allowsSelection = true
        return view
    }()
    
    private let notesTitle: UILabel = {
        var lbl = UILabel()
        lbl.text = "Notes"
        lbl.textColor = .label
        lbl.textAlignment = .left
        lbl.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(HomeNoteCollectionViewCell.self, forCellWithReuseIdentifier: HomeNoteCollectionViewCell.identifire)
        setUpUI()
    }
    
    private func setUpUI(){
        
        addSubview(notesTitle)
        notesTitle.autoPinEdge(.left, to: .left, of: self)
        notesTitle.autoPinEdge(.top, to: .top, of: self)
        
        addSubview(collectionView)
        collectionView.autoPinEdge(.top, to: .bottom, of: notesTitle, withOffset: 16)
        collectionView.autoPinEdge(.left, to: .left, of: self)
        collectionView.autoPinEdge(.right, to: .right, of: self)
        collectionView.autoPinEdge(.bottom, to: .bottom, of: self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeNoteCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (noteItem?.count ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeNoteCollectionViewCell.identifire, for: indexPath) as! HomeNoteCollectionViewCell
        
        if indexPath.item == 0 {
            cell.createNote()
        } else {
            let noteIndex = indexPath.item - 1
            cell.setCell(note: noteItem?[noteIndex])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let numberOfItemsPerRow: CGFloat = 2
        let width = (collectionView.bounds.width - 16) / numberOfItemsPerRow
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            delegate?.createNoteTapped()
        }else {
            delegate?.noteDetailTapped()
        
        }
    }
}
