//
//  StartViewController.swift
//  MarvelApp
//
//  Created by Octavio on 12/05/24.
//

import UIKit

class StartViewController: UIViewController {

    
    @IBOutlet weak var hypertext: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTextView()
        // Do any additional setup after loading the view.
    }
    

    func updateTextView(){
        let path = "https://marvel.com"
        let text = hypertext.text ?? ""
        let attributedString = NSAttributedString.makeHyperlink(for: path, in: text, as: "Data provided by Marvel. © 2024 MARVEL")
        hypertext.attributedText = attributedString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         //Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "fav"{
            let destination = segue.destination as! ViewController
            destination.favFlag = true
        }
        
        if segue.identifier == "list"{
            let destination = segue.destination as! ViewController
            destination.favFlag = false
        }
    }

}
