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
        
        print("Number of rows: \(tableView.numberOfRows(inSection: 0))")
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

}
