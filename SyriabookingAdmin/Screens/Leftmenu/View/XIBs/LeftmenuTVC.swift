//
//  LeftmenuTVC.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 14/07/26.
//

import UIKit

class LeftmenuTVC: UITableViewCell {
    @IBOutlet weak var backVIew: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backViewLeadingConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        backVIew.layer.cornerRadius = 12
        backVIew.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backVIew.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        backVIew.backgroundColor = .systemBackground
        backViewLeadingConstraint.constant = 10
        
        let normalColor = UIColor(hex: "#575757")
        titleLabel.textColor = normalColor
        iconImgView.tintColor = normalColor
    }
    
    func setSubmenuStyle(_ isSubmenu: Bool) {
        backViewLeadingConstraint.constant = isSubmenu ? 40 : 10
    }

    func configure(with menu: SidebarMenuItem, isSelected: Bool) {
        iconImgView.image = UIImage(systemName: menu.icon)
        titleLabel.text = menu.title
        
        backVIew.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        backVIew.backgroundColor = .systemBackground
        let normalColor = UIColor(hex: "#575757")
        titleLabel.textColor = normalColor
        iconImgView.tintColor = normalColor
        
        if isSelected {
            backVIew.applyOverviewGradient(color: ThemeManager.shared.currentColor)
            titleLabel.textColor = .white
            iconImgView.tintColor = .white
        }
    }
}
