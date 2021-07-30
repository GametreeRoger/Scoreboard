//
//  SettingsTableViewController.swift
//  SettingsTableViewController
//
//  Created by 張又壬 on 2021/7/29.
//

import UIKit

protocol SettingDelegate {
    func settingData(data: Settings)
}

class SettingsTableViewController: UITableViewController {
    var selectedRow = 0
    var settings: Settings?
    var delegate: SettingDelegate?
    
    @IBOutlet weak var player1TextField: UITextField!
    @IBOutlet weak var player2TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        if settings == nil {
//            settings = Settings(player1: "", player2: "")
//        }
        
        print("bumber of rows: \(tableView.numberOfRows(inSection: 0))")
//        selectedRow = settings?.theme.rawValue ?? 0
        updateView()
    }
    
    func updateView() {
        if let themeIndex = settings?.theme.rawValue {
            selectedRow = themeIndex
            let indexPath = IndexPath(row: themeIndex, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
            }
        }
        player1TextField.text = settings?.player1
        player2TextField.text = settings?.player2
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == selectedRow {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            selectedRow = indexPath.row
            cell.accessoryType = .checkmark
            settings?.theme = Theme(rawValue: selectedRow) ?? .Default
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        setName(sender: player1TextField, isPlayer1: true)
        setName(sender: player2TextField, isPlayer1: false)
        
        if parent == nil {
            delegate?.settingData(data: settings!)
        }
    }
    
    private func setName(sender: UITextField, isPlayer1: Bool) {
        if let name = sender.text, !name.isEmpty {
            if isPlayer1 {
                settings?.player1 = name
            } else {
                settings?.player2 = name
            }
        }
    }

    @IBAction func player1NameSetting(_ sender: UITextField) {
        print(sender.text!)
        setName(sender: sender, isPlayer1: true)
    }
    
    @IBAction func player2NameSetting(_ sender: UITextField) {
        print(sender.text!)
        setName(sender: sender, isPlayer1: false)
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        // Configure the cell...

        return cell
    }
     */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "SettingData" {
//            let destination = segue.destination as! ScoreboardViewController
//            settings = destination.settings
//        }
//    }


}
