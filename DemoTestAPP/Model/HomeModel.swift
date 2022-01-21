//
//  Model.swift
//  DemoTestAPP
//
//  Created by Venkatesh Savarala on 21/01/22.
//

import Foundation
struct HomeModel : Codable {
    let status : String?
    let feeds : [Feeds]?
    let greetingMessage : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case feeds = "feeds"
        case greetingMessage = "greetingMessage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        feeds = try values.decodeIfPresent([Feeds].self, forKey: .feeds)
        greetingMessage = try values.decodeIfPresent(String.self, forKey: .greetingMessage)
    }

}
struct Feeds : Codable {
    let car : Car?
    let screen : String?
    let features : [Features]?
    let offers : [Offers]?
    enum CodingKeys: String, CodingKey {
        case features = "features"
        case car = "car"
        case screen = "screen"
        case offers = "offers"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        car = try values.decodeIfPresent(Car.self, forKey: .car)
        screen = try values.decodeIfPresent(String.self, forKey: .screen)
        features = try values.decodeIfPresent([Features].self, forKey: .features)
        offers = try values.decodeIfPresent([Offers].self, forKey: .offers)
    }

}
struct Car : Codable {
    let image : String?
    let regNo : String?
    let fuelType : String?
    let transmission : String?
    let model : String?
    let car_id : Int?
    let make : String?

    enum CodingKeys: String, CodingKey {

        case image = "image"
        case regNo = "regNo"
        case fuelType = "fuelType"
        case transmission = "transmission"
        case model = "model"
        case car_id = "car_id"
        case make = "make"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        regNo = try values.decodeIfPresent(String.self, forKey: .regNo)
        fuelType = try values.decodeIfPresent(String.self, forKey: .fuelType)
        transmission = try values.decodeIfPresent(String.self, forKey: .transmission)
        model = try values.decodeIfPresent(String.self, forKey: .model)
        car_id = try values.decodeIfPresent(Int.self, forKey: .car_id)
        make = try values.decodeIfPresent(String.self, forKey: .make)
    }

}
struct Features : Codable {
    let imageUrl : String?
    let screenName : String?
    let redirectUrl : String?

    enum CodingKeys: String, CodingKey {

        case imageUrl = "imageUrl"
        case screenName = "screenName"
        case redirectUrl = "redirectUrl"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        screenName = try values.decodeIfPresent(String.self, forKey: .screenName)
        redirectUrl = try values.decodeIfPresent(String.self, forKey: .redirectUrl)
    }

}
struct Offers : Codable {
    let image : String?
    let screen_name : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case image = "image"
        case screen_name = "screen_name"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        screen_name = try values.decodeIfPresent(String.self, forKey: .screen_name)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
