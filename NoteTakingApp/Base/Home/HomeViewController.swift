//
//  ViewController.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 13.07.2025.
//

import PureLayout

class HomeViewController: UIViewController{
    
    private let viewModel = HomeViewModel()
    
    private let stackContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let searchBar: UISearchBar = {
        let searchView = UISearchBar()
        searchView.layer.cornerRadius = 16
        searchView.placeholder = "Search anything"
        searchView.backgroundImage = UIImage()
        return searchView
    }()
    
    private let collectionView = HomeCategoryCollectionView()
    private let noteCollectionView = HomeNoteCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Home"
        collectionView.delegate = self
        
        collectionView.categoryItems = viewModel.getCategories()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleButtonTap), name: .didTapSaveButton, object: nil)
        
        setUpUI()
    }
    
    private func setUpUI() {
        
        view.addSubview(stackContainerView)
        stackContainerView.autoPinEdgesToSuperviewEdges()
        
        stackContainerView.addArrangedSubview(searchBar)
        searchBar.autoSetDimension(.height, toSize: 32)
        searchBar.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        
        stackContainerView.addArrangedSubview(collectionView)
        collectionView.autoSetDimension(.height, toSize: 64)
        collectionView.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        
        stackContainerView.addArrangedSubview(noteCollectionView)
    }
    
    @objc private func handleButtonTap() {
        let items = viewModel.getCategories()
        collectionView.reloadData(categoryItems: items)
    }
}

extension HomeViewController: HomeCategoryCollectionViewDelegate {
    
    func tappedAddNewCategoryButton() {
        let vc = CategoryViewController()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(vc, animated: true)
    }
    
    func categoryDeleted(item: Category) {
        viewModel.deleteCategories(category: item)
        collectionView.categoryItems = viewModel.getCategories()
    }
    
}
