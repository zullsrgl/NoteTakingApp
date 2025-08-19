//
//  Extansion.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 14.07.2025.
//
import UIKit

//MARK: -Color
extension UIColor {
    
    func encode() -> Data? {
        try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
    }
}

//MARK: -Data
extension Data {
    func decodeColor() -> UIColor? {
        try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(self) as? UIColor
    }
}

//MARK: -ViewController
extension UIViewController {
    func showToast(message: String, duration: TimeInterval = 1.0){
        let toastLabel: UILabel = {
            let lbl = UILabel()
            lbl.text = message
            lbl.font = .systemFont(ofSize: 18)
            lbl.textColor = .white
            lbl.textAlignment = .center
            lbl.backgroundColor = .systemGreen
            lbl.layer.cornerRadius = 10
            lbl.clipsToBounds = true
            lbl.alpha = 1.0
            return lbl
        }()
        
        self.view.addSubview(toastLabel)
        toastLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        toastLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        toastLabel.autoSetDimension(.height, toSize: 40)
        
        UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }){ _ in
            toastLabel.removeFromSuperview()
        }
    }
    
    func showError(message: String, duration: TimeInterval = 1.0){
        let errorLabel: UILabel = {
            let lbl = UILabel()
            lbl.text = message
            lbl.font = .systemFont(ofSize: 18)
            lbl.textColor = .white
            lbl.textAlignment = .center
            lbl.backgroundColor = .systemRed
            lbl.layer.cornerRadius = 10
            lbl.numberOfLines = 0
            lbl.clipsToBounds = true
            lbl.alpha = 1.0
            return lbl
        }()
        
        self.view.addSubview(errorLabel)
        errorLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        errorLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        errorLabel.autoSetDimension(.height, toSize: 40)
        
        UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
            errorLabel.alpha = 0.0
        }){ _ in
            errorLabel.removeFromSuperview()
        }
    }
    func createBottomSheet(vc: UIViewController, animated: Bool = true) {
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(vc, animated: true)
    }
}

//MARK: -Notication
extension Notification.Name {
    static let contextSavedSuccessfully = Notification.Name("contextSavedSuccessfully")
}

//MARK: -UIView
extension UIView {
    func showError(message: String, duration: TimeInterval = 1.0){
        let errorLabel: UILabel = {
            let lbl = UILabel()
            lbl.text = message
            lbl.font = .systemFont(ofSize: 18)
            lbl.textColor = .white
            lbl.textAlignment = .center
            lbl.backgroundColor = .systemRed
            lbl.layer.cornerRadius = 10
            lbl.numberOfLines = 0
            lbl.clipsToBounds = true
            lbl.alpha = 1.0
            return lbl
        }()
        
        self.addSubview(errorLabel)
        errorLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        errorLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        errorLabel.autoSetDimension(.height, toSize: 40)
        
        UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
            errorLabel.alpha = 0.0
        }){ _ in
            errorLabel.removeFromSuperview()
        }
    }
}
