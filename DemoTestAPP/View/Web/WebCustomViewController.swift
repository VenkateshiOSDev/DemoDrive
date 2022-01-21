//
//  WebCustomViewController.swift
//  DemoTestAPP
//
//  Created by Venkatesh Savarala on 21/01/22.
//

import UIKit
import WebKit
class WebCustomViewController: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var webView: WKWebView!
    var feature : Features?
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = feature?.screenName ?? ""
        webView.load(URLRequest(url: URL(string: feature?.redirectUrl ?? "")!))
        // Do any additional setup after loading the view.
    }
    @IBAction func btnClickBack(_ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }

}
