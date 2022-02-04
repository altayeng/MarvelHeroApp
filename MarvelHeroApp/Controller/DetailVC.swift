//
//  DetailVC.swift
//  MarvelHeroApp
//
//  Created by Altay Kırlı on 3.02.2022.
//

import Foundation

import UIKit
import SDWebImage
import Alamofire
import CryptoSwift
import RealmSwift

class DetailVC: UIViewController {
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var detail: UILabel!

    var detailName = ""
    var detailDescrp = ""
    var detailThumbnail = ""
    var characterID = ""
    var ComicList = [ComicResult]()
    private let realm = try! Realm()
    private var favorites: Results<Favorite>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favorites = realm.objects(Favorite.self)
        if (favorites?.contains(where: { $0.id == characterID  }))! {saveButton.setImage(UIImage(named: "favSelected"), for: .normal)
        } else {
        saveButton.setImage(UIImage(named: "favNotSelected"), for: .normal) }
        name.text = detailName
        detail.text = detailDescrp
        thumbnail.sd_setImage(with: URL(string: detailThumbnail))
        getComics()
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout { layout.scrollDirection = .horizontal }
         
    }
    
    @IBAction func saveCharacter(_ sender: Any) {
        
        let favorite = Favorite()
        favorite.id = characterID
        favorite.name = detailName
        favorite.thumbnail = detailThumbnail
        favorite.detail = detailDescrp

        if (favorites?.contains(where: { $0.id == favorite.id }))! {
            do {
                try realm.write {
                let character = realm.objects(Favorite.self).filter("name = %@", favorite.name)
                realm.delete(character)
                    
                saveButton.setImage(UIImage(named: "favNotSelected"), for: .normal)
                print("Remove Succes")
                }
            } catch {
                print((error))
            }
        } else {

            do {
                try realm.write {
                realm.add(favorite)
                saveButton.setImage(UIImage(named: "favSelected"), for: .normal)
                print("Added to Favorities.")
                }
            } catch {
                print((error))
            }
        }
}
    
}
extension DetailVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ComicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DetailViewCell
        let row = ComicList[indexPath.row]
        cell.comicsThumbnail.layer.cornerRadius = 8
        cell.comicsThumbnail.sd_setImage(with: URL(string: row.thumbnail!.path+".\(row.thumbnail!.thumbnailExtension)"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rows = ComicList[indexPath.row]
        print("Name:\(rows.title!)")
        let comic = rows.title
        let alert = UIAlertController(title: "Comics", message: comic, preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Got It!", style: .default, handler: { (action: UIAlertAction!) in
                  self.navigationController?.popViewController(animated: true)
              }))
              self.present(alert, animated: true)
              
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.frame.size.height - 50)
        let size = (collectionView.frame.size.width / 2)
        return CGSize(width: size, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(10)
    }
}

//2005'ten sonra son 10 kayıt
extension DetailVC {
    func getComics() {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let now = df.string(from: Date())
        let parameters: Parameters = ["apikey": "\(App.publickey)","hash": "\(App.hash)","ts": "\(App.ts)","limit": 10,"dateRange": "2005-01-01,\(now)","orderBy": "-focDate"]
        
        NewWebService().requestUrl(url:URL(string:App.serviceurl + "characters/"+"\(characterID)"+"/comics"), parameters: parameters,
                expecting: ComicsServerModel.self)
                { Result in
                    switch Result {
                    case.success(let datas):
                        DispatchQueue.main.async{
                            self.ComicList = datas.data.results!
                            self.collectionView.reloadData()
                        }
                    case.failure(let error):
                        print(error)
                    }
            }
    }
}
