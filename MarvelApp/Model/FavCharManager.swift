//
//  FavCharManager.swift
//  MarvelApp
//
//  Created by Octavio on 12/05/24.
//

import Foundation
import CoreData

class FavManager{
    
    private let context : NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    //Create a song
    func createFav(name: String ,thumbnail: String, descr: String, url: String){
                
                let newFav = FavCharacter(context: context)
                newFav.name = name
                newFav.thumbnail = thumbnail
                newFav.descrip = descr
                newFav.url = url
                
                do{
                    try context.save()
                }
                catch let error {
                    print("Error: ", error)
                }
            }
    
    func countFav() -> Int{
        if let fchars = try? self.context.fetch(FavCharacter.fetchRequest()){
            return fchars.count
        }
        else{
            return 0
        }
    }
    
    
    //Get All songs
    //Read all Songs
        func getAllSongs() -> [FavCharacter]{
                if let fchars = try? self.context.fetch(FavCharacter.fetchRequest()){
                    return fchars
                }
                else{
                    return []
                }
        }
    
    
    //Update a song
        func updateSong(fav : FavCharacter, name: String ,thumbnail: String, descr: String, url: String) -> FavCharacter {
            fav.name = name
            fav.thumbnail = thumbnail
            fav.descrip = descr
            fav.url = url
            
            do{
                try context.save()
            }
            catch let error{
                print("Error: ", error)
            }
            return fav
        }
    
    //Delete a song
        func deleteSong(fav : FavCharacter) -> Bool{
            
            self.context.delete(fav)
            
            do {
                try context.save()
                return true
            }
            catch let error {
                print("Error: ", error)
                return false
            }
        }
    

    
}
