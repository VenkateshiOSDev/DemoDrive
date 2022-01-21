//
//  OfferClvCell.swift
//  DemoTestAPP
//
//  Created by Venkatesh Savarala on 21/01/22.
//

import UIKit

class OfferClvCell: UICollectionViewCell {
    @IBOutlet weak var imagOffer: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupdata(offer :Offers?){
        if let urlStr = URL(string: offer?.image ?? "") {
            imagOffer.sd_setImage(with: urlStr, completed: nil)
        }
    }
}
