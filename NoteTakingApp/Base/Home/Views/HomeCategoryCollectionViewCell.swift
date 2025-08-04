//
//  HomeCollectionViewCell.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 13.07.2025.
//
import PureLayout

protocol HomeCategoryCollectionViewCellDelegate: AnyObject {
    func homeCategoryCellDidTapDelete(cell: HomeCategoryCollectionViewCell)
}

class HomeCategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "homeCollectionViewCell"
    weak var delegate: HomeCategoryCollectionViewCellDelegate?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        return stackView
    }()
    
    private let categoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.label
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        button.isUserInteractionEnabled = false

        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let interaction = UIContextMenuInteraction(delegate: self)
        self.addInteraction(interaction)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        self.addSubview(stackView)
        stackView.autoPinEdgesToSuperviewEdges()
        
        stackView.addArrangedSubview(categoryButton)
    }
    
    func setUpButton(categoryName: String?, categoryColor: UIColor?){
        categoryButton.setTitle(categoryName, for: .normal)
        categoryButton.layer.borderColor = categoryColor?.cgColor
    }
}

extension HomeCategoryCollectionViewCell: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil){ _ in
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash")){ _ in
                self.delegate?.homeCategoryCellDidTapDelete(cell: self)
                
            }
            return UIMenu(title: "", children: [delete])
        }
    }
}
