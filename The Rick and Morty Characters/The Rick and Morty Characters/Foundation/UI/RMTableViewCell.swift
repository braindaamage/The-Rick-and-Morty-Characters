//
//  RMTableViewCell.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 17-07-21.
//

import UIKit

class RMTableViewCell: UITableViewCell {
    
    var cellImageView: UIImageView = UIImageView()
    var cellTitleLable: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cellImageView)
        addSubview(cellTitleLable)
        
        configureImage()
        configurateTitleLabel()
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(withImageUrlString imageUrl: String, andTitle title: String) {
        cellImageView.imageFromURL(urlString: imageUrl, withDefaultImage: UIImage(named: "RMLogo"))
        cellTitleLable.text = title
    }
    
    private func configureImage() {
        cellImageView.layer.cornerRadius = 10
        cellImageView.clipsToBounds = true
    }
    
    private func configurateTitleLabel() {
        cellTitleLable.numberOfLines = 0
        cellTitleLable.adjustsFontSizeToFitWidth = true
    }
    
    private func setImageConstraints() {
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            cellImageView.heightAnchor.constraint(equalToConstant: 80),
            cellImageView.widthAnchor.constraint(equalTo: cellImageView.heightAnchor)
        ])
    }
    
    private func setTitleLabelConstraints() {
        cellTitleLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellTitleLable.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellTitleLable.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 20),
            cellTitleLable.heightAnchor.constraint(equalToConstant: 80),
            cellTitleLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
    
}
