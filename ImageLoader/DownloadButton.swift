//
//  DownloadButton.swift
//  ImageLoader
//
//  Created by Rohit Pal on 13/08/16.
//  Copyright © 2016 Rohit Pal. All rights reserved.
//

import UIKit

class DownloadButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.grayColor().CGColor
        
        layer.cornerRadius = 4.0
        
        setTitleColor(UIColor.grayColor(), forState: .Normal)
        setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
    }
    

}
