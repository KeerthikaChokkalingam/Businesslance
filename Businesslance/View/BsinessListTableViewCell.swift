//
//  BsinessListTableViewCell.swift
//  Businesslance
//
//  Created by Keerthika Chokkalingam on 15/09/23.
//

import UIKit

class BsinessListTableViewCell: UITableViewCell {

    @IBOutlet weak var paymentMethod: UILabel!
    @IBOutlet weak var noPreviewLabel: UILabel!
    @IBOutlet weak var noPreviewView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var logoImageView: CustomImageView!
    @IBOutlet weak var rewardsLabel: UILabel!
    @IBOutlet weak var promotionsLabel: UILabel!
    @IBOutlet weak var bayServices: UILabel!
    @IBOutlet weak var bayName: UILabel!
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var businessPhoneNumber: UILabel!
    @IBOutlet weak var businessAddressLbale: UILabel!
    @IBOutlet weak var businessNamelabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        logoImageView.layer.cornerRadius = 15
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
