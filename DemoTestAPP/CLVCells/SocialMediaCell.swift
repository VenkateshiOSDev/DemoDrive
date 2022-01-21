//
//  SocialMediaCell.swift
//  DemoTestAPP
//
//  Created by Venkatesh Savarala on 21/01/22.
//

import UIKit

class SocialMediaCell: UICollectionViewCell {
    @IBOutlet weak var imagIcon: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupdata(fature :Features?){
        if let urlStr = URL(string: fature?.imageUrl ?? "") {
            imagIcon.sd_setImage(with: urlStr, completed: nil)
        }
        lblName.text = fature?.screenName ?? ""
        
    }

}
