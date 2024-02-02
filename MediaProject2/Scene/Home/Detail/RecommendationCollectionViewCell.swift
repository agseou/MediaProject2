//
//  RecommendationCollectionViewCell.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/02/01.
//

import UIKit
import SnapKit

class RecommendationCollectionViewCell: BaseCollectionViewCell {
    
    let posterCard = PosterCardView(frame: .zero)
    let titleLable = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(posterCard)
        contentView.addSubview(titleLable)
    }
    
    override func configureCell() {
        titleLable.textColor = .white
    }
    
    override func configureLayout() {
        posterCard.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView).inset(5)
            $0.top.equalTo(contentView)
            $0.bottom.equalTo(50)
        }
        titleLable.snp.makeConstraints {
            $0.top.equalTo(posterCard.snp.bottom)
            $0.bottom.equalTo(contentView)
            $0.horizontalEdges.equalTo(contentView)
        }
    }
    
}
