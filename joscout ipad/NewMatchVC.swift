//
//  NewMatchVC.swift
//  joscout ipad
//
//  Created by Daniele Lanzetta on 26.09.17.
//  Copyright © 2017 Daniele Lanzetta. All rights reserved.
//

import UIKit


// protocol used for sending data back
protocol DataEnteredDelegate: class {
    func userDidEnterInformation(info: String)
}


class NewMatchVC: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    
    // VIEW DID LOAD - VIEW WILL APPEAR
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presentAlert()
    }
    
    
    // VAR - ARRAY - DATA
      weak var delegate: DataEnteredDelegate? = nil
    
    
    var teamA = ["Marc-Andre ter Stegen",
                 "Nelson Semedo",
                 "Gerard Pique",
                 "Samuel Umtiti",
                 "Jordi Alba",
                 "Ivan Rakitic",
                 "Sergio Busquets",
                 "Andres Iniesta",
                 "Lionel Messi",
                 "Luis Suarez",
                 "Francisco Alcacer"]
    var teamB = ["Francisco Casilla",
                 "Nacho Fernandez",
                 "Jesus Vallejo",
                 "Sergio Ramos",
                 "Marcelo",
                 "Toni Kroos",
                 "Casemiro",
                 "Isco",
                 "Marco Asensio",
                 "Karim Benzema",
                 "Cristiano Ronaldo"]

    
    
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
    insertNewPlayerInLeftTeam()
    
    }
    
    @IBAction func addNewPlayerBtnRight(_ sender: UIButton) {
      insertNewPlayerInRightTeam()
        
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
            
            //setting the values to the previous controller cell
            self.delegate?.userDidEnterInformation(info: self.teamLeft.text!)
            
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
    
    
    // MARK - Func List
    
    func insertNewPlayerInLeftTeam() {
        
        if textFieldLeft.text!.isEmpty {
            print("Add Text Before!")
        }
        
        
        
        teamA.append(textFieldLeft.text!)
        
        let indexPath = IndexPath(row: teamA.count - 1, section: 0)
        
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
        
        
        
        teamB.append(textFieldRight.text!)
        
        let indexPath = IndexPath(row: teamB.count - 1, section: 0)
        
        tableViewRight.beginUpdates()
        tableViewRight.insertRows(at: [indexPath], with: .automatic)
        tableViewRight.endUpdates()
        
        textFieldRight.text = ""
        view.endEditing(true)
    }
    
    
    // MARK - Table views protocols
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == tableViewLeft){
            
            return teamA.count
            
        }else if (tableView == tableViewRight){
            return teamB.count
            
            
        }else {
            
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == tableViewLeft) {
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "cellLeft", for: indexPath) as! TableViewCellLeft
            cell.TableViewLeftName.text = teamA[indexPath.row]
            return cell
            
            
        }else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cellRight", for: indexPath) as! TableViewCellRight
            cell.TableViewRightName.text = teamB[indexPath.row]
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
                
                teamA.remove(at: indexPath.row)
                tableViewLeft.beginUpdates()
                tableViewLeft.deleteRows(at: [indexPath], with: .automatic)
                tableViewLeft.endUpdates()
            }
            
        } else if (tableView == tableViewRight)
        {
            if (editingStyle == .delete){
                
                teamB.remove(at: indexPath.row)
                tableViewRight.beginUpdates()
                tableViewRight.deleteRows(at: [indexPath], with: .automatic)
                tableViewRight.endUpdates()
            }
        
        
        } else {
            
            return
        }
    
    
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



