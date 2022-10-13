//
//  ViewController.swift
//  collectionViewHomeWork
//
//  Created by Dmytro Gavrylov on 04.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var imageArray = [Images]()
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addImages()
    }
    func addImages() {
        imageArray = [
            Images(picture: "autumn"),
            Images(picture: "pumpkins"),
            Images(picture: "london"),
            Images(picture: "burger")
        ]
    }
}
extension ViewController: UICollectionViewDelegate {
    
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as? ImageCollectionViewCell else {
            return ImageCollectionViewCell()
        }
        cell.images = imageArray[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let images = imageArray[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ShowPictureViewController") as? ShowPictureViewController else {return}
        vc.view.layoutIfNeeded()
        vc.imageView.image = UIImage(named: imageArray[indexPath.row].picture ?? "")
        
        show(vc, sender: images)
    
        
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    /// 1
    func collectionView(_ collectionView: UICollectionView,
                  layout collectionViewLayout: UICollectionViewLayout,
                  insetForSectionAt section: Int) -> UIEdgeInsets {
        /// 2
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }

    /// 3
    func collectionView(_ collectionView: UICollectionView,
                   layout collectionViewLayout: UICollectionViewLayout,
                   sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// 4
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        /// 5
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        /// 6
        return CGSize(width: widthPerItem - 8, height: 350)
    }
}
extension UIImage {
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
  
    func toJpegString(compressionQuality cq: CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: cq)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
