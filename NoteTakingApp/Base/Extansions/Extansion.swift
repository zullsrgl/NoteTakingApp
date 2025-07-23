//
//  Extansion.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 14.07.2025.
//
import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: CGFloat.random(in: 0.3...1),
            green: CGFloat.random(in: 0.3...1),
            blue: CGFloat.random(in: 0.3...1),
            alpha: 1.0
        )
    }
    
    func encode() -> Data? {
        try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
    }
}

extension Data {
    func decodeColor() -> UIColor? {
        try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(self) as? UIColor
    }
}

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
        toastLabel.autoPinEdge(.left, to: .left, of: view, withOffset: 32)
        toastLabel.autoPinEdge(.right, to: .right, of: view, withOffset: -32)
        toastLabel.autoPinEdge(.bottom, to: .bottom, of: view, withOffset: -100)
        
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
        errorLabel.autoPinEdge(.left, to: .left, of: view, withOffset: 32)
        errorLabel.autoPinEdge(.right, to: .right, of: view, withOffset: -32)
        errorLabel.autoPinEdge(.bottom, to: .bottom, of: view, withOffset: -100)
        
        errorLabel.autoSetDimension(.height, toSize: 40)
        
        UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
            errorLabel.alpha = 0.0
        }){ _ in
            errorLabel.removeFromSuperview()
        }
    }
}


extension Notification.Name {
    static let didTapSaveButton = Notification.Name("didTapSaveButton")
}
