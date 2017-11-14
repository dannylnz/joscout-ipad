//
//  NewMatchVC.swift
//  joscout ipad
//
//  Created by Daniele Lanzetta on 26.09.17.
//  Copyright © 2017 Daniele Lanzetta. All rights reserved.
//

import UIKit
import CoreData
import Firebase





class NewMatchVC: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    // VIEW DID LOAD - VIEW WILL APPEAR
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        ref = Database.database().reference()

        print(ref)
        
    }
    
    //END OF VIEW DID LOAD
    
    override func viewWillAppear(_ animated: Bool) {
        presentAlert()
        
    }
    // END OF VIEW WILL APPEAR
    
    //VAR AND LET
    

    var ref: DatabaseReference!
    
    var matchesRef: DatabaseReference! = nil
    var teamARef:DatabaseReference! = nil
    var teamBRef:DatabaseReference! = nil
    var cell = CollectionViewCell()
    var teamA = Team()
    var teamB = Team()
    var match = Match(teamA: "teamA",teamB:"teamB", scoreA: 0, scoreB: 0)
    var nameOfTeamA = ""
    var nameOfTeamB = ""
    
    //END OF VAR AND LET
    
    
    // OUTLETS
    
    @IBOutlet weak var tableViewLeft: UITableView!
    @IBOutlet weak var tableViewRight: UITableView!
    @IBOutlet weak var teamLeft: UILabel!
    @IBOutlet weak var teamRight: UILabel!
    @IBOutlet weak var dateAndTime: UILabel!
    @IBOutlet weak var scoreHomeTeam: UILabel!
    @IBOutlet weak var scoreAwayTeam: UILabel!
    @IBOutlet weak var stadiumLabel: UILabel!
    @IBOutlet weak var textFieldLeft: UITextField!
    @IBOutlet weak var textFieldRight: UITextField!
    
    //END OF OUTLETS
    
    // MARK - Action Buttons
    
    @IBAction func editResultBtn(_ sender: Any) {
        //TODO: Edit Result
        presentAlertResult()
    }
    
    @IBAction func editSettingBtn(_ sender: Any) {
        presentAlert()
        //TODO: Show settings again
    }
    
    @IBAction func addNewPlayerBtnLeft(_ sender: Any) {
        
        //TODO: Add new player in Table view of Team A and Add data to firebase
        
        if (textFieldLeft?.text != ""){
            
            insertNewPlayerInLeftTeam()
        } else {
            print ("Please Insert a valid name inside the field")
            
        }
        
        
        
    }
    
    @IBAction func addNewPlayerBtnRight(_ sender: UIButton) {
        
        
        //TODO: Add new player in Table view of Team B and Add data to firebase
        if (textFieldRight?.text != ""){
            
            
            
            insertNewPlayerInRightTeam()
            
            
            
        } else {
            print ("Please Insert a valid name inside the field")
            
        }
        
        
        
    }
    // MARK - Func Alert - To set the initial data of the match
    
    func presentAlert() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Settings", message: "Enter game details", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            let teamAName = alertController.textFields?[0].text
            let teamBName = alertController.textFields?[1].text
            let date = alertController.textFields?[2].text
            let stadium = alertController.textFields?[3].text
            
            //setting the values to the labels
            self.teamLeft.text = teamAName
            self.teamRight.text = teamBName
            self.dateAndTime.text = date
            self.stadiumLabel.text = stadium
            
            self.nameOfTeamA = teamAName!
            self.nameOfTeamB = teamBName!
            
            let key = self.ref.childByAutoId().key
            
            let newMatch = [
            "team A Name": teamAName ,
            "team B Name": teamBName,
                    "date":date,
                    "stadium": stadium
            ] as [String : Any]
            
            
             self.ref.child("matches").child("match1").setValue(newMatch)
            
            
            
            
            
            
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
        }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Home Team"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Away Team"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Date"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Location"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    // Shows the result alert box where user can update
    func presentAlertResult() {
        
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Result", message: "Change the final result", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            let scoreTeamA = alertController.textFields?[0].text
            let scoreTeamB = alertController.textFields?[1].text
            
            self.scoreHomeTeam.text = scoreTeamA
            self.scoreAwayTeam.text = scoreTeamB
            
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.dismiss(animated: true, completion: nil)
            
        }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Home Team Score"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Away Team Score"
        }
        
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    // MARK - Insert Players Functions
    
    func insertNewPlayerInLeftTeam() {
        
        if textFieldLeft.text!.isEmpty {
            print("Add Text Before!")
        } else {
        
        ref = Database.database().reference()
            
        let key = ref.childByAutoId().key
            
        var player : PlayerClass = PlayerClass(name: textFieldLeft.text! as String, age: 20 , height: 100, nationality: "italian",position:"CEN")
            
        
            let newPlayer = ["id": key,
                             "playerName": textFieldLeft.text! as String,
                             "age":player.age as! Int,
                             "height": player.height as! Int,
                             "nationality": player.nationality as! String,
                             "position":player.position as! String
                ] as [String : Any]
            
            
            
            ref.child("matches").child("match1").child("\(nameOfTeamA)").childByAutoId().setValue(newPlayer)
            
        
            teamA.players.append(player)
        
        let indexPath = IndexPath(row: teamA.players.count - 1, section: 0)
        
        tableViewLeft.beginUpdates()
        tableViewLeft.insertRows(at: [indexPath], with: .automatic)
        tableViewLeft.endUpdates()
        
        textFieldLeft.text = ""
        view.endEditing(true)
    }
        
    }
    
    func insertNewPlayerInRightTeam() {
        
        if textFieldRight.text!.isEmpty {
            print("Add Text Before!")
        }
        
        var player : PlayerClass = PlayerClass(name: "Pall1", age: 18 , height: 180, nationality: "slovenian",position:"ATT")
        player.name = textFieldRight.text!

        
        teamB.players.append(player)
        
        let indexPath = IndexPath(row: teamB.players.count - 1, section: 0)
        
        tableViewRight.beginUpdates()
        tableViewRight.insertRows(at: [indexPath], with: .automatic)
        tableViewRight.endUpdates()
        
        textFieldRight.text = ""
        view.endEditing(true)
        print(teamB)
        
        
    }
    
    
    // MARK - Table views protocols
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "playerDetails" {
//                if let indexPath = self.tableViewLeft.indexPathForSelectedRow {
//                    let name = posts[indexPath.row] as! [String: AnyObject]
//                    let postDetails = post["postID"] as? String
//                    let controller = segue.destination as! PlayerDetails
//                    controller.playerName = textFieldLeft.text
//                    controller.playerAge = PlayerClass.
//                }
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == tableViewLeft){
            
            return teamA.players.count
            
        }else if (tableView == tableViewRight){
            return teamB.players.count
            
            
        }else {
            
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == tableViewLeft) {
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "cellLeft", for: indexPath) as! TableViewCellLeft
            cell.TableViewLeftName.text = teamA.players[indexPath.row].name
            return cell
            
            
        }else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cellRight", for: indexPath) as! TableViewCellRight
            cell.TableViewRightName.text = teamB.players[indexPath.row].name
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView (_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (tableView == tableViewLeft)
        {
            if (editingStyle == .delete){
                
                teamA.players.remove(at: indexPath.row)
                tableViewLeft.beginUpdates()
                tableViewLeft.deleteRows(at: [indexPath], with: .automatic)
                tableViewLeft.endUpdates()
            }
            
        } else if (tableView == tableViewRight)
        {
            if (editingStyle == .delete){
                
                teamB.players.remove(at: indexPath.row)
                tableViewRight.beginUpdates()
                tableViewRight.deleteRows(at: [indexPath], with: .automatic)
                tableViewRight.endUpdates()
            }
            
            
        } else {
            
            return
        }
        
        
    }
    
    @IBAction func save () {
        match.teamA = teamA.name
        match.teamB = teamB.name
        
    }
    
}




/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */



