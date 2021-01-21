//
//  NewsCollectionViewCell.swift
//  NewsApp
//
//  Created by DIAKO on 1/20/21.
//

import UIKit
import Kingfisher

class NewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSource: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 6
        self.contentView.layer.masksToBounds = true
    }
    
    func set(news: News) {
        if let imageURL = news.urlToImage {
            image.kf.setImage(with: URL(string: imageURL))
            image.contentMode = .scaleAspectFill
        } else {
            image.image = R.image.noPhoto()
            image.contentMode = .scaleAspectFit
        }
        
        labelTitle.text = news.title!
        labelSource.text = news.source?.name
        labelDate.text = news.publishedAt?.isoDateToDate()
    }
}
