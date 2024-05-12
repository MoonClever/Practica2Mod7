//
//  ViewController.swift
//  MarvelApp
//
//  Created by Rafael González on 30/04/24.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    var keyLoader = KeyLoader.shared
    var characterManager : CharacterServiceManager?
    var favCharacters : FavManager?
    var selectedCharacter : Character!
    var selectedFavChar : FavCharacter!
    
    var favFlag = false

    @IBOutlet weak var characterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //print(keyLoader.getAPIParams())
        //print(keyLoader.getQueryString())
        
        characterCollectionView.delegate = self
        characterCollectionView.dataSource = self
        
        
        if (favFlag){
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            favCharacters = FavManager(context: context)
            
            
        }
        else{
            characterManager = CharacterServiceManager()
            
            characterManager?.loadCharacterData(queryString: keyLoader.getQueryString(limit: Constants.numberOfItemsRequested, offset: 0) ){
                DispatchQueue.main.async {
                    print("Completion executed!!")
                    self.characterCollectionView.reloadData()
                    //move offset param to retieve next block of character
                    self.characterManager?.offset = (self.characterManager?.countCharacter())!
                }
            }
        }
    }
    
    
    @IBAction func returnView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(favFlag){
            return (favCharacters?.countFav())!
        }else{
            return (characterManager?.countCharacter())!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(favFlag){
            let favList = favCharacters?.getAllSongs()
            selectedFavChar = favList![indexPath.item]
        }else{
            selectedCharacter = characterManager?.getCharacter(at: indexPath.item)
        }
        
        
        self.performSegue(withIdentifier: "detail", sender: Self.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let destination = segue.destination as! CharacterDetailController
        if(favFlag){
            destination.favChar = selectedFavChar
            destination.favFlag = true
        }else{
            destination.character = selectedCharacter
            destination.favFlag = false
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(favFlag){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharacterCell
            cell.characterName.text = favCharacters?.getAllSongs()[indexPath.row].name
            let url = URL(string: (favCharacters?.getAllSongs()[indexPath.row].thumbnail)!)
            cell.characterImage.sd_setImage(with: url)
            
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharacterCell
            cell.characterName.text = characterManager?.getCharacter(at: indexPath.row).name
            let url = URL(string: (characterManager?.getCharacter(at: indexPath.row).thumbnail.url)!)
            cell.characterImage.sd_setImage(with: url)
            
            return cell
        }
        
    }
}

extension ViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        ////        size of scrollview content
        //                print("contentSize.height", scrollView.contentSize.height)
        ////        screen's available space for scrollview element
        //                print("bounds.height:", scrollView.bounds.height)
        ////        contentOffset y = contentSize.height - bounds.height
        //                print("contentOffset y:", scrollView.contentOffset.y)
        if(!favFlag){
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let scrollviewHeight = scrollView.bounds.height
            
            if (offsetY > (contentHeight - scrollviewHeight)) && (!characterManager!.maxItemsLoaded && !characterManager!.isLoading ){
                print("calling API...")
                self.characterManager!.isLoading = true
                let queryString = keyLoader.getQueryString(limit: Constants.numberOfItemsRequested, offset: self.characterManager!.offset)
                print("qs:",queryString)
                
                self.characterManager!.loadCharacterData(queryString: queryString){
                    DispatchQueue.main.async {
                        self.characterCollectionView.reloadData()
                        print("char com:",self.characterManager!.countCharacter())
                        print("actual offset: ", self.characterManager!.offset)
                        self.characterManager!.offset = self.characterManager!.countCharacter()
                        print("new offset: ", self.characterManager!.offset)
                        self.characterManager!.isLoading = false
                    }
                }
            }
            else{
                print("Don't call API...")
            }
        }
    }
}


