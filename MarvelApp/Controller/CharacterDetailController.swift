//
//  CharacterDetailController.swift
//  MarvelApp
//
//  Created by Octavio on 12/05/24.
//

import UIKit

class CharacterDetailController: UIViewController {

    var character : Character!
    var favChar: FavCharacter!
    var favoritos : FavManager!
    var favFlag = false
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var urlLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(favFlag){
            let url = URL(string: (favChar.thumbnail!))
            thumbnailImage.sd_setImage(with: url)
            nameLabel.text = favChar.name
            descriptionLabel.text = favChar.description
            urlLabel.text = favChar.url
        }// Do any additional setup after loading the view.        }
        else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            favoritos = FavManager(context: context)
            let url = URL(string: (character.thumbnail.url))
            thumbnailImage.sd_setImage(with: url)
            nameLabel.text = character.name
            descriptionLabel.text = character.description
            urlLabel.text = character.resourceURI       // Do any additional setup after loading the view.
        }
    }
    

    @IBAction func returnView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func btnFav(_ sender: Any) {
        if(favFlag){
            print("Este personaje ya esta en favoritos")
        }
        else{
        favoritos.createFav(name: character.name,
                            thumbnail: character.thumbnail.url,
                            descr: character.description,
                            url: character.resourceURI)
        }    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
