//
//  File.swift
//  DemoTestAPP
//
//  Created by Venkatesh Savarala on 21/01/22.
//

import Foundation
enum HomeViewModel{
    case details(car : Car?,title:String)
    case social(features : [Features]?,title:String)
    case offers(offers : [Offers]?,title:String)
}

class HomePageViewModel {
    var updateUI : (()->()) = { }
    var handleError : ((String)->()) = {_ in}
    var homeList = [HomeViewModel]()
    var dataSource : HomeModel?
    let requestType : RequestRouter
    
    init(requestType : RequestRouter){
        self.requestType = requestType
    }
    
    func viewDidLoad(){
        fetchList()
    }
    
    func fetchList(){
        makeApicall()
    }
    
    func makeApicall(){
        if let url = URL(string: requestType.urlStr) {
            var request = URLRequest(url: url)
            request.httpMethod = request.httpMethod
            let session = URLSession.shared.dataTask(with: request) { [weak self] data, responce, error in
                guard let self = self else { return }
                if let error = error {
                    self.handleError(error.localizedDescription)
                }else if let data = data{
                    do{
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(HomeModel.self, from: data)
                        if responseModel.status == "success" {
                            self.dataSource = responseModel
                            self.convertIntoViewModel()
                        }else{
                            self.handleError("Error data Responce")
                        }
                        
                    }catch(let error){
                        self.handleError(error.localizedDescription)
                    }
                   
                }else{
                    self.handleError("Empty data Responce")
                }
            }
            session.resume()
        }else{
            handleError("Invalid URL")
        }
        
    }
    
    func convertIntoViewModel(){
        for feed in dataSource?.feeds ?? [] {
            if feed.screen == "carDetails"{
                homeList.append(.details(car: feed.car, title: feed.screen ?? ""))
            }else if feed.screen == "Social Apps"{
                homeList.append(.social(features: feed.features, title: feed.screen ?? ""))
            }else if feed.screen == "offers"{
                homeList.append(.offers(offers: feed.offers, title: feed.screen ?? ""))
            }
        }
        self.updateUI()
    }
}


// Module
enum RequestRouter {
    case HomeAPi
    var baseUrl : String {
        return "https://jsonkeeper.com/"
    }
    
    var urlStr : String {
        return baseUrl + "b/TMAP"
    }
    
    var httpMethd : String {
        "GET"
    }
    
}
