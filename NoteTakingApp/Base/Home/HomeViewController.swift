//
//  ViewController.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 13.07.2025.
//

import PureLayout

class HomeViewController: UIViewController{
    
    private lazy var viewModel = HomeViewModel()
    
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
    
    private let homeCategorieCollectionView = HomeCategoryCollectionView()
    private let homeNoteCollectionView = HomeNoteCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "Home"
        
        homeCategorieCollectionView.delegate = self
        homeNoteCollectionView.delegate = self
        viewModel.delegate = self
        
        viewModel.getCategories()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleButtonTap), name: .didTapSaveButton, object: nil)
        
        setUpUI()
    }
    
    private func setUpUI() {
        
        view.addSubview(stackContainerView)
        stackContainerView.autoPinEdgesToSuperviewEdges()
        
        stackContainerView.addArrangedSubview(searchBar)
        searchBar.autoSetDimension(.height, toSize: 32)
        searchBar.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        
        stackContainerView.addArrangedSubview(homeCategorieCollectionView)
        homeCategorieCollectionView.autoSetDimension(.height, toSize: 64)
        homeCategorieCollectionView.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        
        stackContainerView.addArrangedSubview(homeNoteCollectionView)
    }
    
    @objc private func handleButtonTap() {
        viewModel.getCategories()
     
    }
}

extension HomeViewController: HomeCategoryCollectionViewDelegate {
    
    func tappedAddNewCategoryButton() {
        let vc = CategoryViewController()
        createBottomSheet(vc: vc)
    }
    
    func categoryDeleted(item: Category) {
        viewModel.deleteCategories(category: item)
        viewModel.getCategories()
    }
}

extension HomeViewController: HomeViewModelDelegate{
    func categiresFetched(categories: [Category]) {
        homeCategorieCollectionView.reloadData(categoryItems: categories)
    }
    
    func didSelectCategory(categoryName: String) {
        //TODO: filter
    }
}

extension HomeViewController: HomeNoteCollectionViewDelegate{
    func createNoteTapped() {
        navigationController?.pushViewController(CreateNoteViewController(), animated: true)
    }
}
