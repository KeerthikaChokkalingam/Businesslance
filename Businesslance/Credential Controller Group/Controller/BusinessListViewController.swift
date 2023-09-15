//
//  BusinessListViewController.swift
//  Businesslance
//
//  Created by Keerthika Chokkalingam on 15/09/23.
//

import UIKit

class BusinessListViewController: UIViewController {

    @IBOutlet weak var businessListTableView: UITableView!
    @IBOutlet weak var titlelabel: UILabel!
    
    var requestJson = [String:Any]()
    var indicator = UIActivityIndicatorView()
    var viewModal: CredentialsViewModel?
    var responsevalue: CredentialResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    @IBAction func backToCredetials(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension BusinessListViewController {
    func setUpUI() {
        indicator = Utils().setUpLoader(sender: view)
        businessListTableView.register(UINib(nibName: "BsinessListTableViewCell", bundle: nil), forCellReuseIdentifier: "BsinessListTableViewCell")
        viewModal = CredentialsViewModel()
        viewModal?.delegateInitVar = self
        if NetworkHandler().checkReachable() {
            Utils().startLoading(sender: indicator, wholeView: view)
            viewModal?.getBusinessDetails(param: requestJson, type: CredentialResponse.self)
        } else {
            errorHandling(title: "No Internet Detected", message: "This app requires an Internet connection")
        }
    }
    func errorHandling(title: String, message: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
            controller.dismiss(animated: true)
            }
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
}

extension BusinessListViewController: ResponseParserDelegate {
    func passSuccesResponse(responseResult: CredentialResponse) {
        viewModal = CredentialsViewModel()
        responsevalue = responseResult
        DispatchQueue.main.async {
            Utils().endLoading(sender: self.indicator, wholeView: self.view)
            self.titlelabel.text = (self.responsevalue?.message?.data?.environment ?? "") + " Environment"
            self.businessListTableView.reloadData()
        }
    }
    
    func passError(errorResult: Int) {
        DispatchQueue.main.async {
            Utils().endLoading(sender: self.indicator, wholeView: self.view)
            if errorResult == 300 {
                // decode error
                self.errorHandling(title: "SomeThing Went Wrong", message: "Client Side Error")
            } else if errorResult == 400 {
                // hhtp error
                self.errorHandling(title: "SomeThing Went Wrong", message: "Authendication Error")
            } else {
                // 500 local error
                self.errorHandling(title: "SomeThing Went Wrong", message: "Server Error")
            }
        }
    }
    
}

extension BusinessListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responsevalue?.message?.data?.business?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BsinessListTableViewCell", for: indexPath)as? BsinessListTableViewCell else {return UITableViewCell()}
        cell.bgView.layer.cornerRadius = 20
        cell.bgView.backgroundColor = indexPath.row % 2 == 0 ? UIColor().hexStringToUIColor(hex: "#003b4a") : UIColor().hexStringToUIColor(hex: "#C8FFE0")
        cell.noPreviewView.backgroundColor = indexPath.row % 2 == 0 ? UIColor().hexStringToUIColor(hex: "#C8FFE0") : UIColor().hexStringToUIColor(hex: "#003b4a")
        cell.rewardsLabel.textColor = indexPath.row % 2 == 0 ? UIColor().hexStringToUIColor(hex: "#ffffff") : UIColor().hexStringToUIColor(hex: "#003b4a")
        cell.promotionsLabel.textColor = indexPath.row % 2 == 0 ? UIColor().hexStringToUIColor(hex: "#ffffff") : UIColor().hexStringToUIColor(hex: "#003b4a")
        cell.bayServices.textColor = indexPath.row % 2 == 0 ? UIColor().hexStringToUIColor(hex: "#ffffff") : UIColor().hexStringToUIColor(hex: "#003b4a")
        cell.bayName.textColor = indexPath.row % 2 == 0 ? UIColor().hexStringToUIColor(hex: "#ffffff") : UIColor().hexStringToUIColor(hex: "#003b4a")
        cell.serviceName.textColor = indexPath.row % 2 == 0 ? UIColor().hexStringToUIColor(hex: "#ffffff") : UIColor().hexStringToUIColor(hex: "#003b4a")
        cell.businessPhoneNumber.textColor = indexPath.row % 2 == 0 ? UIColor().hexStringToUIColor(hex: "#ffffff") : UIColor().hexStringToUIColor(hex: "#003b4a")
        cell.businessAddressLbale.textColor = indexPath.row % 2 == 0 ? UIColor().hexStringToUIColor(hex: "#ffffff") : UIColor().hexStringToUIColor(hex: "#003b4a")
        cell.businessNamelabel.textColor = indexPath.row % 2 == 0 ? UIColor().hexStringToUIColor(hex: "#ffffff") : UIColor().hexStringToUIColor(hex: "#003b4a")
        cell.paymentMethod.textColor = indexPath.row % 2 == 0 ? UIColor().hexStringToUIColor(hex: "#ffffff") : UIColor().hexStringToUIColor(hex: "#003b4a")
        cell.noPreviewLabel.textColor = indexPath.row % 2 == 0 ? UIColor().hexStringToUIColor(hex: "#003b4a") : UIColor().hexStringToUIColor(hex: "#003b4a")
        let currentData = responsevalue?.message?.data?.business?[indexPath.row]
        cell.logoImageView.loadImage(urlString: currentData?.logo ?? "")
        cell.noPreviewView.isHidden = true
        cell.noPreviewLabel.isHidden = true
        if currentData?.logo == "" {
            cell.logoImageView.image = UIImage(named: "No_Preview_image_2")
            cell.noPreviewView.layer.cornerRadius = 15
            cell.noPreviewView.isHidden = false
            cell.noPreviewLabel.isHidden = false
        }
        cell.rewardsLabel.text = "POINTS " + "\(currentData?.rewards?[0].availablePoint ?? 0)"
        cell.promotionsLabel.text = "PROMOTIONS: " + (currentData?.promotions?.promotionDesc ?? "")
        cell.bayServices.text = "SERVICES: " + "\(currentData?.bayNode[0].bayServices?.count ?? 0)"
        cell.bayName.text = "BAY NAME: " + (currentData?.bayNode[0].bayName ?? "")
        cell.serviceName.text = "SERVICE NAME: " + (currentData?.providedServices?[0].serviceName ?? "")
        cell.businessPhoneNumber.text = "MOBILE: " + (currentData?.phone ?? "")
        cell.businessAddressLbale.text = "ADDRESS: " + (currentData?.businessAddress ?? "")
        cell.businessNamelabel.text = "BUSINESS NAME: " + (currentData?.businessName ?? "")
        cell.paymentMethod.text =  "PAYMENT METHOD: " + (responsevalue?.message?.data?.paymentDetails?.details?[indexPath.row].method ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 520
    }
    
}
