//
//  ImageCollectionViewCell.swift
//  UnsplashApiApp
//
//  Created by Berta Devant on 12/08/2019.
//  Copyright © 2019 Berta Devant. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return "ImageCell"
    }
    
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Fonts.regular
        label.textColor = .white
        label.lineBreakMode = .byTruncatingHead
        label.textAlignment = .right
        return label
    }()
    
    private var hoverView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.alpha = 0.35
        return view
    }()
    
    override var isHighlighted: Bool {
        didSet {
            showDescriptionIfHighlighted(isHighlighted)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This view is not designed to be used with xib or storyboard files")
    }
    
    func update(with image: ImageViewModel) {
        imageView.imageFromServerURL(image.imageSmall, placeHolder: #imageLiteral(resourceName: "placeholder-square"))
        backgroundColor = image.color ?? .white
        descriptionLabel.text = image.description
        hoverView.backgroundColor = image.color ?? .white
        showDescriptionIfHighlighted(isHighlighted)
    }
    
    private func setup() {
        clipsToBounds = true
        addSubview(imageView)
        addSubview(hoverView)
        addSubview(descriptionLabel)
        setupLayout()
        backgroundColor = .white
    }
    
    private func setupLayout() {
        imageView.pinToSuperviewEdges()
        hoverView.pinToSuperviewEdges()
        descriptionLabel.pinToSuperviewBottom(withConstant: 8)
        descriptionLabel.pinToSuperviewRight(withConstant: -8)
        descriptionLabel.pinToSuperviewLeft(withConstant: 16, relatedBy: .greaterThanOrEqual)
    }
    
    private func showDescriptionIfHighlighted(_ isHighlighted: Bool) {
        descriptionLabel.isHidden = !isHighlighted
        hoverView.isHidden = !isHighlighted
    }
}
