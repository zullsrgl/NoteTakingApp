//
//  ViewController.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 13.07.2025.
//

import PureLayout
import CoreData

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
        searchView.layer.cornerRadius = 20
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
        searchBar.delegate = self
        viewModel.delegate = self
        viewModel.getCategories()
        viewModel.getAllNotes()
        
        NotificationCenter.default.addObserver(self, selector: #selector(tappedCategorySaveButton), name: .contextSavedSuccessfully, object: nil)
        
        setUpUI()
    }
    
    private func setUpUI() {
        
        view.addSubview(stackContainerView)
        stackContainerView.autoPinEdgesToSuperviewEdges()
        
        stackContainerView.addArrangedSubview(searchBar)
        searchBar.autoSetDimension(.height, toSize: 40)
        searchBar.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        
        stackContainerView.addArrangedSubview(homeCategorieCollectionView)
        homeCategorieCollectionView.autoSetDimension(.height, toSize: 64)
        homeCategorieCollectionView.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        
        stackContainerView.addArrangedSubview(homeNoteCollectionView)
    }
    
    @objc private func tappedCategorySaveButton() {
        viewModel.getCategories()
        viewModel.getAllNotes()
        
    }
}

extension HomeViewController: HomeCategoryCollectionViewDelegate {
    func didSelectCategory(category: Category) {
        if category.categoryName == "Genaral" {
            viewModel.getAllNotes()
        } else {
            let filteredNotes = viewModel.getNotes(category: category)
            homeNoteCollectionView.reloadCollectionView(notes: filteredNotes)
        }
    }
    
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
    func notesFetched(notes: [Note]) {
        homeNoteCollectionView.reloadCollectionView(notes: notes)
    }
    
    func categoriesFetched(categories: [Category]) {
        homeCategorieCollectionView.reloadData(categoryItems: categories)
    }
}

extension HomeViewController: HomeNoteCollectionViewDelegate{
    
    func createNoteTapped() {
        let vc =  CreateNoteViewController()
        vc.source = .homeVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func noteDetailTapped(noteID: NSManagedObjectID) {
        let vc = NoteDetailViewController()
        vc.noteID = noteID
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        let categories =  viewModel.getSearchText(keyword: searchText)
        if !categories.isEmpty {
            homeCategorieCollectionView.reloadData(categoryItems: categories)
        } else if searchText.isEmpty {
            viewModel.getCategories()
        //    viewModel.getAllNotes()

        } else{
            homeCategorieCollectionView.reloadData(categoryItems: [])
        }
    }
}
