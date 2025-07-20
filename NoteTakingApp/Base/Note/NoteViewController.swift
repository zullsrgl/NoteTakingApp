//
//  NoteViewController.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 19.07.2025.
//

import PureLayout

class NoteViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Take a note"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(goBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveNote))
        
        setUpUI()
    }
    
    private func setUpUI(){
        view.addSubview(stackContainerView)
        stackContainerView.autoPinEdgesToSuperviewEdges()
    }
    
    @objc func goBack() {
        //TODO: alert box for if client don't save the text
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveNote() {
        //TODO: when client clik the save button i will save in local db -> (core data) and show success or error message
        print("save button clicked")
    }
}
