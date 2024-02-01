//
//  CastCollectionViewCell.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/02/01.
//

import UIKit
import SnapKit

class CastCollectionViewCell: BaseCollectionViewCell {
    
    let baseView = UIView()
    let castImage = UIImageView()
    let characterLabel = UILabel()
    let nameLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(baseView)
        baseView.addSubview(castImage)
        baseView.addSubview(characterLabel)
        baseView.addSubview(nameLabel)
    }
    
    override func configureCell() {
        baseView.backgroundColor = .white
        castImage.contentMode = .scaleAspectFill
        castImage.clipsToBounds = true
        
        characterLabel.textColor = .black
        characterLabel.font = .systemFont(ofSize: 13)
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 13)
    }
    
    override func configureLayout() {
        baseView.snp.makeConstraints {
            $0.edges.equalTo(contentView).inset(5)
        }
        castImage.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(baseView)
            $0.height.equalTo(baseView).multipliedBy(0.6)
        }
        characterLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(baseView)
            $0.top.equalTo(castImage.snp.bottom)
        }
        nameLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(baseView)
            $0.top.equalTo(characterLabel.snp.bottom)
        }
    }
}
