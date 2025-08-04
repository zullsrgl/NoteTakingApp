//
//  Views.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 31.07.2025.
//


import PureLayout

class PaddingLabel: UILabel {
    var textInsets = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6){
        didSet{
            setNeedsDisplay()
            invalidateIntrinsicContentSize()
        }
    }
    
    override func drawText(in rect: CGRect){
        super.drawText(in: rect)
        
    }
    
    override var intrinsicContentSize: CGSize {
           let size = super.intrinsicContentSize
           return CGSize(
               width: size.width + textInsets.left + textInsets.right,
               height: size.height + textInsets.top + textInsets.bottom
           )
       }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let sizeThatFits = super.sizeThatFits(size)
        return CGSize(
            width: sizeThatFits.width + textInsets.left + textInsets.right,
            height: sizeThatFits.height + textInsets.top + textInsets.bottom
        )
    }
}

enum TextStyle {
    case bold
    case italic
    case underline
}
