//
//  HeoreViewCell.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 20/10/23.
//

import UIKit
import Kingfisher

class HeoreViewCell: UITableViewCell {
    static let identifier = "Cell"
    static let height = 256
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var descriptionHero: UILabel!
    @IBOutlet weak var nameHero: UILabel!
    @IBOutlet weak var imageHero: UIImageView!
    @IBOutlet weak var loadingView: UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameHero.text = nil
        descriptionHero.text = nil
        imageHero.image = nil
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        
        loadingView.layer.cornerRadius = 8
        loadingView.layer.shadowColor = UIColor.blue.cgColor
        loadingView.layer.shadowOffset = .zero
        loadingView.layer.shadowRadius = 8
        loadingView.layer.shadowOpacity = 0.4
        
        imageHero.layer.cornerRadius = 8
        imageHero.layer.maskedCorners = [.layerMinXMaxYCorner]
        
        selectionStyle = .none // No hacer efecto seleccionado de celda
    }
    
    func updateView(
        name: String? = nil,
        image: String? = nil,
        description: String? = nil)
    {
        self.nameHero.text = name
        self.descriptionHero.text = description
        self.imageHero.kf.setImage(with: URL(string: image ?? ""))
    }
}
