//
//  ImageCell.swift
//  ImageViewer
//
//  Created by wzxjiang on 2017/6/26.
//  Copyright © 2017年 wzxjiang. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet var imageButtons: [UIButton]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
