//
//  NoteViewController.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 19.07.2025.
//

import PureLayout

class CreateNoteViewController: UIViewController {
    
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
    private let noteTitleView = NoteTitleView()
    private let homeCategoryCollectionView = HomeCategoryCollectionView()
    private let noteView = NoteView()
    private let viewModel = CreateNoteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Take a note"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(goBack))
        NotificationCenter.default.addObserver(self, selector: #selector(handleButtonTap), name: .didTapSaveButton, object: nil)
        
        homeCategoryCollectionView.delegate = self
        viewModel.delegate = self
        viewModel.fetchAllCategories()
        
        setUpUI()
    }
    
    private func setUpUI(){
        view.addSubview(stackContainerView)
        stackContainerView.autoPinEdgesToSuperviewEdges()
        
        stackContainerView.addArrangedSubview(noteTitleView)
        noteTitleView.autoSetDimension(.height, toSize: 64)
        
        stackContainerView.addArrangedSubview(homeCategoryCollectionView)
        homeCategoryCollectionView.autoSetDimension(.height, toSize: 72)
        
        stackContainerView.addArrangedSubview(noteView)
    }
    
    @objc private func handleButtonTap() {
        viewModel.fetchAllCategories()
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension CreateNoteViewController: NoteViewModelDelegate {
    func fectedAllCategories(categories: [Category]) {
        homeCategoryCollectionView.reloadData(categoryItems: categories)
    }
}


extension CreateNoteViewController: HomeCategoryCollectionViewDelegate {
    
    func tappedAddNewCategoryButton() {
        let vc = CategoryViewController()
        createBottomSheet(vc: vc)
    }
    
    func categoryDeleted(item: Category) {
        viewModel.deleteCategory(category: item)
        viewModel.fetchAllCategories()
        
    }
    
    func didSelectCategory(categoryName: String) {
        noteView.selectedCategory(catgoryName: categoryName)
    }
}
