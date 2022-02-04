//
//  FavoritesVC.swift
//  MarvelHeroApp
//
//  Created by Altay Kırlı on 3.02.2022.
//
import UIKit
import SDWebImage
import RealmSwift

class FavoritesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    var favorites: Results<Favorite>!
    override func viewDidLoad() {
        super.viewDidLoad()
        favorites = realm.objects(Favorite.self)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
}

extension FavoritesVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(110)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FavTableViewCell
        let row = favorites[indexPath.row]
        cell.thumbnail.layer.cornerRadius = 7
        cell.thumbnail.sd_setImage(with: URL(string: row.thumbnail))
        cell.name.text = row.name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = favorites[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailVC
        navigationController!.pushViewController(detailVC, animated: true)
        detailVC.characterID = String(row.id)
        detailVC.detailName = row.name
        detailVC.detailDescrp = row.detail
        detailVC.detailThumbnail = row.thumbnail
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Remove") { [self] UIContextualAction, view, Boolvalue in
            let row = self.favorites[indexPath.row]
            let favorite = Favorite()
            favorite.id = row.id
                     do {
                        try self.realm.write{
                        let character = realm.objects(Favorite.self).filter("id = %@", favorite.id)
                        realm.delete(character)
                        print("Removed")
                        tableView.reloadData()
                         }
                     } catch{
                         print("(error)")
                     }
                 
    }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
}
    
}
