//
//  FirstViewController.swift
//  joscout ipad
//
//  Created by Daniele Lanzetta on 25.09.17.
//  Copyright © 2017 Daniele Lanzetta. All rights reserved.
//

import UIKit
import Firebase


class FirstViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
/// VAR & LET
    
    let ref = Database.database().reference()
    var countOfMatches = [DataSnapshot]()
    
    let db = Firestore.firestore()
    var fsRef: DocumentReference? = nil
    
    
    
    //Outlets
    
    
    
    
    
    
    @IBAction func addNewMatchBtn(_ sender: Any) {
 
    }
    
    
    var matches : [Match] = []
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.myOrientation = .landscape
        var match = Match(teamA: "Team A", teamB: "Team B", scoreA: 0,scoreB: 0)
        
        
        matches.append(match)

        }
        
    
    
    
    
    
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard

    
    
    // MARK: Create collection View cell with title, image, and rounded border
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        
        
        
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 8
        cell.teamAName.text? = "Team Name"
        //objects.append("cellName")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        collectionView.reloadData()
        return matches.count
        
    }
    
    // MARK: - Prepare for segue
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showSecondViewController" {
//            let newMatchVC = segue.destination as! NewMatchVC
//           // newMatchVC.match = 1
//            newMatchVC.delegate = self
//        }
//    }
    
    
  
    
    
//    // MARK: - UICollectionViewDataSource protocol
//
//    // tell the collection view how many cells to make
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.items.count
//    }
//
//    // make a cell for each cell index path
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        // get a reference to our storyboard cell
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
//
//        // Use the outlet in our custom class to get a reference to the UILabel in the cell
//
//        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
//
//        return cell
//    }
//
//    // MARK: - UICollectionViewDelegate protocol
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // handle tap events
//        print("You selected cell #\(indexPath.item)!")
//    }
//
//
//    // MARK: - Alert Function When Button Pressed
//
//
//
    
    
}
    
    
    



