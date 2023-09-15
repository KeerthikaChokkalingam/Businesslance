//
//  CredentialsViewController.swift
//  Businesslance
//
//  Created by Keerthika Chokkalingam on 15/09/23.
//

import UIKit

class CredentialsViewController: UIViewController {

    @IBOutlet var credentialsField: [PaddingTextField]!
    @IBOutlet weak var goToBusinessbutton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        for item in credentialsField {
            item.text = ""
        }
    }
    @IBAction func goToBusinessAction(_ sender: UIButton) {
        view.endEditing(true)
        var userID: String = ""
        var latt: String = ""
        var long: String = ""
        var address: String = ""
        var location: String = ""
        for item in credentialsField {
            if item.text == "" {
                item.layer.borderColor = UIColor.systemRed.cgColor
            } else {
                item.layer.borderColor = UIColor().hexStringToUIColor(hex: "003b4a").cgColor
                if item.tag == 1 {
                    userID = item.text ?? "1"
                }
                if item.tag == 2 {
                    latt = item.text ?? "38.5579125"
                }
                if item.tag == 3 {
                    long = item.text ?? "-121.4980481"
                }
                if item.tag == 4 {
                    address = item.text ?? "flase"
                }
                location = latt + "," + long
            }
        }
        if userID != "" && latt != "" && long != "" && address != "" {
            guard let businessListVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BusinessListViewController") as? BusinessListViewController else {return}
            businessListVc.requestJson = ["UserId": userID,"Location": location, "Address": address ]
            self.navigationController?.pushViewController(businessListVc, animated: true)
        }
    }
    
}

extension CredentialsViewController {
    func setUpUI() {
        contentView.layer.cornerRadius = 15
        goToBusinessbutton.layer.cornerRadius = 15
        for item in credentialsField {
            item.layer.cornerRadius = 15
            item.placeholder =  item.tag == 1 ? "Enter User ID" : item.tag == 2 ? "Enter Lattitude" : item.tag == 3 ? "Enter Longtitude" : "Enter Address"
            item.delegate = self
            item.layer.borderColor = UIColor().hexStringToUIColor(hex: "003b4a").cgColor
            item.layer.borderWidth = 1
        }
    }
}

extension CredentialsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            textField.layer.borderColor = UIColor.red.cgColor
        } else {
            textField.layer.borderColor = UIColor().hexStringToUIColor(hex: "003b4a").cgColor
        }

    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor().hexStringToUIColor(hex: "003b4a").cgColor
    }
}
