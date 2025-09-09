//
//  NoteDetailViewController.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 18.08.2025.
//

import PureLayout
import CoreData

class NoteDetailViewController: UIViewController       {
    
    private let viewModel = NoteDetailViewModel()
    var noteID: NSManagedObjectID!
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isScrollEnabled = true
        sv.layer.cornerRadius = 16
        sv.layer.borderWidth = 1
        sv.layer.borderColor = UIColor.systemGray.cgColor
        return sv
    }()
    
    private let noteTitle: UILabel = {
        var lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = .label
        lbl.text = "Note"
        lbl.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        return lbl
    }()
    
    private let noteLabel: PaddingLabel = {
        var lbl = PaddingLabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let editButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("Edit", for: .normal)
        btn.backgroundColor = Color.primary
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        btn.isUserInteractionEnabled = true
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true
        return btn
    }()
    
    private let categoryLabel: CategoryPaddingLabel = {
        var lbl = CategoryPaddingLabel()
        lbl.layer.cornerRadius = 8
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints  = false
        lbl.clipsToBounds = true
        return lbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteNote))
        editButton.addTarget(self, action: #selector(tappedNoteEditButton), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(noteIsUpdated), name: .contextSavedSuccessfully, object: nil)
        
        viewModel.delegate = self
        viewModel.getNote(noteID: noteID)
       
        
        setUpUI()
    }
    
    @objc func noteIsUpdated(){
        viewModel.getNote(noteID: noteID)
    }
    
    @objc func deleteNote() {
        let alert = UIAlertController(title: "warning", message: "Are you sure for delete", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default){ _ in
            self.viewModel.deleteNote(note: self.noteID)
            self.navigationController?.popViewController(animated: true)
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true)
    }
    
    private func setUpUI() {
        view.addSubview(noteTitle)
        noteTitle.autoPinEdge(.left, to: .left, of: view, withOffset: 16)
        noteTitle.autoPinEdge(.right, to: .right, of: view, withOffset: -16)
        noteTitle.autoPinEdge(.top, to: .top, of: view, withOffset: 100)
        noteTitle.autoSetDimension(.height, toSize: 40)
        
        view.addSubview(editButton)
        editButton.autoPinEdge(.left, to: .left, of: view, withOffset: 16)
        editButton.autoPinEdge(.right, to: .right, of: view, withOffset: -16)
        editButton.autoPinEdge(.bottom, to: .bottom, of: view, withOffset: -40)
        editButton.autoSetDimension(.height, toSize: 40)
        
        view.addSubview(scrollView)
        scrollView.autoPinEdge(.left, to: .left, of: view, withOffset: 16)
        scrollView.autoPinEdge(.right, to: .right, of: view, withOffset: -16)
        scrollView.autoPinEdge(.top, to: .bottom, of: noteTitle, withOffset: 16)
        scrollView.autoPinEdge(.bottom, to: .top, of: editButton, withOffset: -16)
        
        scrollView.addSubview(noteLabel)
        noteLabel.autoPinEdge(toSuperviewEdge: .top)
        noteLabel.autoPinEdge(toSuperviewEdge: .left)
        noteLabel.autoPinEdge(toSuperviewEdge: .right)
        noteLabel.autoPinEdge(toSuperviewEdge: .bottom)
        noteLabel.autoMatch(.width, to: .width, of: scrollView)
        
        view.addSubview(categoryLabel)
        categoryLabel.autoPinEdge(.right, to: .right, of: view, withOffset: -24)
        categoryLabel.autoPinEdge(.top, to: .top, of: view, withOffset: 164)
        categoryLabel.autoSetDimension(.height, toSize: 32)
            
        if let bg = categoryLabel.backgroundColor {
            let resolved = bg.resolvedColor(with: traitCollection)
            categoryLabel.textColor = resolved.isLight ? .black : .white
        }
    }
    
    @objc func tappedNoteEditButton(){
        let vc = CreateNoteViewController()
        vc.source = .noteDetailVC
        vc.noteID = noteID
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension NoteDetailViewController: NoteDetailViewModelDelegate {
    func noteArried(note: Note?) {
        if let styled = note?.styledText {
            noteLabel.attributedText = styled as? NSAttributedString
        } else if let text = note?.note {
            noteLabel.text = text
        } else {
            noteLabel.text = ""
        }
        categoryLabel.text = note?.category?.categoryName
        categoryLabel.backgroundColor = note?.category?.categoryColor?.decodeColor()
        navigationItem.title = note?.noteTitle
    }
}
