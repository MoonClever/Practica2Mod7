//
//  Character.swift
//  MarvelApp
//
//  Created by Rafael González on 03/05/24.
//

import Foundation

struct Character : Codable {
    let id : Int
    let name : String
    let description : String
    let modified : String
    let resourceURI : String
    let thumbnail : Image //Struct
    let urls : [URLWebSite] //Struct
    let comics : ResourceList<ComicItem>
    let stories : ResourceList<StoryItem>
    let events : ResourceList<EventItem>
    let series : ResourceList<SerieItem>
}
