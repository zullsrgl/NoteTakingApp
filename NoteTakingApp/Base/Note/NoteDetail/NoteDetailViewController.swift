//
//  NoteDetailViewController.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 18.08.2025.
//

import PureLayout

class NoteDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Note Detail"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteNote))
    }
    
    @objc func deleteNote() {
        print("delete note")
    }
}
