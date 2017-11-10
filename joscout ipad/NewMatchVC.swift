//
//  NewMatchVC.swift
//  joscout ipad
//
//  Created by Daniele Lanzetta on 26.09.17.
//  Copyright © 2017 Daniele Lanzetta. All rights reserved.
//

import UIKit
import CoreData






class NewMatchVC: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
  
    
    
    
    // VIEW DID LOAD - VIEW WILL APPEAR
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presentAlert()
        
    }
    
    
  
    
    //var player1 = PlayerClass()
    
    var cell = CollectionViewCell()
    
    var teamA = Team()
    
    var teamB = Team()
    
    var match = Match()

    var context = (UIApplication.shared.delegate as! AppDelegate!).persistentContainer.viewContext
    
    
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
    
        if (textFieldLeft?.text != ""){
        
        insertNewPlayerInLeftTeam()
        } else {
            print ("Please Insert a valid name inside the field")
            
        }
        
        
        
    }
    
    @IBAction func addNewPlayerBtnRight(_ sender: UIButton) {
      
        if (textFieldRight?.text != ""){
            
            
            
            insertNewPlayerInRightTeam()
            
            
            
        } else {
            print ("Please Insert a valid name inside the field")
            
        }
        
        
        
    }
    // MARK - Func Alert
    
    func presentAlert() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Settings", message: "Enter game details", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            let teamA = alertController.textFields?[0].text
            let teamB = alertController.textFields?[1].text
            let date = alertController.textFields?[2].text
            let stadium = alertController.textFields?[3].text
            
            //setting the values to the labels
            self.teamLeft.text = teamA
            self.teamRight.text = teamB
            self.dateAndTime.text = date
            self.stadiumLabel.text = stadium
            
            
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
        }
        
        var player : PlayerClass = PlayerClass()
        player.name = textFieldLeft.text!
        player.age = 28

        teamA.players.append(player)
        
        let indexPath = IndexPath(row: teamA.players.count - 1, section: 0)
        
        tableViewLeft.beginUpdates()
        tableViewLeft.insertRows(at: [indexPath], with: .automatic)
        tableViewLeft.endUpdates()
        
        textFieldLeft.text = ""
        view.endEditing(true)
    }
    
    func insertNewPlayerInRightTeam() {
        
        if textFieldRight.text!.isEmpty {
            print("Add Text Before!")
        }
        
        var player : PlayerClass = PlayerClass()
        player.name = textFieldRight.text!
        player.age = 28
        
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
        match.teamA = teamA
        match.teamB = teamB
        
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



