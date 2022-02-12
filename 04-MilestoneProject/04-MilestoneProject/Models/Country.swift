//
//  Country.swift
//  04-MilestoneProject
//
//  Created by Irakli Sokhaneishvili on 12.02.22.
//

import Foundation

/*
 {
     "currencies": [
         {
             "code": "AFN",
             "name": "Afghan afghani",
             "symbol": "؋"
         }
     ],
     "languages": [
         {
             "iso639_1": "ps",
             "iso639_2": "pus",
             "name": "Pashto",
             "nativeName": "پښتو"
         },
         {
             "iso639_1": "uz",
             "iso639_2": "uzb",
             "name": "Uzbek",
             "nativeName": "Oʻzbek"
         },
         {
             "iso639_1": "tk",
             "iso639_2": "tuk",
             "name": "Turkmen",
             "nativeName": "Türkmen"
         }
     ],
     "flag": "https://restcountries.eu/data/afg.svg",
     "name": "Afghanistan",
     "alpha2Code": "AF",
     "capital": "Kabul",
     "population": 27657145,
     "demonym": "Afghan",
     "area": 652230.0,
     "nativeName": "افغانستان"
 }
 */

class Country: Codable {
    //var currencies: [Curency]
    //var languages: [Language]
    //var flag: String
    var name: String
    var capital: String
    var population: Int
    var nativeName: String
}

class Curency: Codable {
    var code, name, symbol: String
}

class Language: Codable {
    var name: String
    var nativeName: String
}
