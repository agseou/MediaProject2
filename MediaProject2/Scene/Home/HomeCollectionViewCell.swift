//
//  HomeCollectionViewCell.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/01/30.
//

import UIKit
import SnapKit

class HomeCollectionViewCell: BaseCollectionViewCell {
    
    let posterCard = PosterCardView(frame: .zero)
    
    override func configureHierarchy() {
        contentView.addSubview(posterCard)
    }
    
    override func configureLayout() {
        posterCard.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(5)
            $0.verticalEdges.equalTo(safeAreaLayoutGuide).inset(5)
        }
    }
}
