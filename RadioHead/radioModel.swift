//
//  radioModel.swift
//  RadioHead
//
//  Created by Mac on 02/01/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import Foundation


struct TopArtists  {
    var artists : [Artist] = []
    
    init()
    {
        self.artists = []
    }
    
    init(listArtists : [Dictionary<String,Any>])  {
        for (index, artist) in listArtists.enumerated() {
            self.artists.append(Artist(json : artist)!)
        }
        
        print(artists)
        
    }
}
    

struct Artist  {
    var name : String?
    var imageURL : URL?
    var albums : [album]?
    var mbid: String?
    var url: URL?
    

    init( name : String,imageURL : URL , mbid : String, url : URL)  {
        self.name = name
        self.mbid = mbid
        self.url = url
        self.imageURL = imageURL
        self.albums = nil
    
    }
    
     init?(json : Dictionary<String,Any> )
    {
        let images = json["image"] as? [Dictionary<String,Any>]
        
        guard let name = json["name"] as? String else {
            return nil
        }
        guard let mbid = json["mbid"] as? String else {
            return nil
        }
        
        guard let url : URL = URL(string : json["url"] as! String)  else {
            return nil
        }
        
        guard let imageURL : URL = URL(string: ((images![0])["#text"] as? String)!) else {
            return nil
        }
        
        self.init(name: name,  imageURL: imageURL,mbid: mbid, url: url)
    }
}


struct album {
    
    
    
    
}






