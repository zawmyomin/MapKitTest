//
//  SearchCell.swift
//  Test
//
//  Created by Justin Zaw on 14/07/2020.
//  Copyright © 2020 Justin Zaw. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    var lblResult : UILabel = {
        let lbl = UILabel()
        lbl.text = "Jurong East"
        lbl.textColor = .darkGray
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
       
        return lbl
    }()
    
    
    var imgSearch : UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "search")
        img.contentMode = .scaleAspectFit
        return img
    }()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = .white
        // Configure the view for the selected state
        contentView.addSubview(lblResult)
        lblResult.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 40, paddingBottom: 0, paddingRight: 10, width: 0, height: 20)

        contentView.addSubview(imgSearch)
        imgSearch.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
    }

}
