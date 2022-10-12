//
//  ImageCollectionViewCell.swift
//  collectionViewHomeWork
//
//  Created by Dmytro Gavrylov on 04.10.2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    
    var images: Images? {
        didSet {
            if let image = images?.picture {
                icon.image = UIImage(named: image)
            }
        }
    }
}
