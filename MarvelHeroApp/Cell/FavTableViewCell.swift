//
//  FavTableViewCell.swift
//  MarvelHeroApp
//
//  Created by Altay Kırlı on 3.02.2022.
//

import UIKit

class FavTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
