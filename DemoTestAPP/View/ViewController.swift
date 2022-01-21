//
//  ViewController.swift
//  DemoTestAPP
//
//  Created by Venkatesh Savarala on 21/01/22.
//

import UIKit

class ViewController: UIViewController {
    var viewModel : HomePageViewModel!
    @IBOutlet weak var clvHomeList: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomePageViewModel(requestType: .HomeAPi)
        clvHomeList.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        clvHomeList.register(UINib(nibName: "CarDetailsClvCell", bundle: nil), forCellWithReuseIdentifier: "CarDetailsClvCell")
        clvHomeList.register(UINib(nibName: "SocialMediaCell", bundle: nil), forCellWithReuseIdentifier: "SocialMediaCell")
        clvHomeList.register(UINib(nibName: "OfferClvCell", bundle: nil), forCellWithReuseIdentifier: "OfferClvCell")
        viewModel.viewDidLoad()
        viewModel.updateUI = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.clvHomeList.reloadData()
            }
        }
        
        viewModel.handleError = { [weak self] (error) in
            guard let self = self else { return }
            print(error)
        }
        // Do any additional setup after loading the view.
    }

}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.homeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.homeList[section] {
        case .details:
            return 1
        case .social(features: let features,_):
            return features?.count ?? 0
        case .offers(offers: let offers,_):
            return offers?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch viewModel.homeList[indexPath.section] {
        case .details(car: let car, _):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarDetailsClvCell", for: indexPath) as! CarDetailsClvCell
            cell.setupdata(car: car)
            return cell
        case .social(features: let features, _):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SocialMediaCell", for: indexPath) as! SocialMediaCell
            cell.setupdata(fature: features?[indexPath.row])
            return cell
        case .offers(offers: let offers, _):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferClvCell", for: indexPath) as! OfferClvCell
            cell.setupdata(offer: offers?[indexPath.row])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
             let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
            switch viewModel.homeList[indexPath.section] {
            case .details(_ ,let title):
                sectionHeader.label.text = title.capitalized
            case .social(_ ,let title):
                sectionHeader.label.text = title.capitalized
            case .offers(_ ,let title):
                sectionHeader.label.text = title.capitalized
            }
            
             return sectionHeader
        } else { //No footer in this case but can add option for that
             return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel.homeList[indexPath.section] {
        case .details:
            return CGSize(width: collectionView.frame.width, height: 120)
        case .social(features: let features, _):
            let numberOfRows = Double((features?.count ?? 0) / 4).rounded(.up)
            let cellWidth  = collectionView.frame.width / 4
            return CGSize(width: cellWidth, height: (50 * numberOfRows))
        case .offers:
            return CGSize(width: collectionView.frame.width, height: 200)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModel.homeList[indexPath.section] {
        case .details:
            break
        case .social(features: let features, _):
            let vc = WebCustomViewController(nibName: "WebCustomViewController", bundle: nil)
            vc.feature = features?[indexPath.row]
            self.present(vc, animated: true, completion: nil)
            break
        case .offers(let offer, _):
            let vc = UIAlertController(title: "Offer", message: offer?[indexPath.section].name ?? "", preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(vc, animated: true, completion: nil)
        }
    }
}
class SectionHeader: UICollectionReusableView {
    var label: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

