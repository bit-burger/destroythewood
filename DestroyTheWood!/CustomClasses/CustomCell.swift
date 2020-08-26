//
//  CustomCell.swift
//  DestroyTheWood!
//
//  Created by Tony Borchert on 07.05.20.
//  Copyright © 2020 Tony Borchert. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    override func awakeFromNib() {
        self.selectedBackgroundView = UIView()
        self.selectedBackgroundView?.backgroundColor = UIColor(red: 0.7373 - 0.05, green: 0.2863 - 0.05, blue: 0.0667 - 0.05, alpha: 1.0)
        selectionStyle = .default
    }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        self.selectedBackgroundView!.backgroundColor = selected ? .red : nil
//    }

}
