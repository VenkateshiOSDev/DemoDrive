//
//  CarDetailsClvCell.swift
//  DemoTestAPP
//
//  Created by Venkatesh Savarala on 21/01/22.
//

import UIKit
import SDWebImage
class CarDetailsClvCell: UICollectionViewCell {
    @IBOutlet weak var imagCar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLicNumber: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupdata(car :Car?){
        if let urlStr = URL(string: car?.image ?? "") {
            imagCar.sd_setImage(with: urlStr, completed: nil)
        }
        lblName.text = car?.make ?? ""
        lblInfo.text = (car?.transmission ?? "").capitalized + " " +  (car?.fuelType ?? "").capitalized
        
    }

}
