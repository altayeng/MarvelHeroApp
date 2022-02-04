//
//  HeroTableViewCell.swift
//  MarvelHeroApp
//
//  Created by Altay Kırlı on 3.02.2022.
//

import UIKit
import RealmSwift

protocol saveButtonPath {
    func ButtonPath(indexPath:IndexPath)
}

class HeroTableViewCell: UITableViewCell {
    
    override func layoutSubviews() {
          super.layoutSubviews()
          let margins = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 8
    }

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    private let realm = try! Realm()
    private var favorites: Results<Favorite>?
    var hucreProtocol:saveButtonPath?
    var indexPath:IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        favorites = realm.objects(Favorite.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func saveCharacter(_ sender: Any) {
        hucreProtocol?.ButtonPath(indexPath: indexPath!)
        favorites = realm.objects(Favorite.self)
        if (favorites?.contains(where: { $0.name == name.text!   }))! {saveButton.setImage(UIImage(named: "favSelected"), for: .normal)
        } else {
        saveButton.setImage(UIImage(named: "favNotSelected"), for: .normal) }
    }
}
