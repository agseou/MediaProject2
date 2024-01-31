//
//  HomeCollectionViewCell.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/01/30.
//

import UIKit
import SnapKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    let posterCard = PosterImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureView()
        configureContsraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeCollectionViewCell: ConfigurableProtocol {
    func configureHierarchy() {
        contentView.addSubview(posterCard)
    }
    
    func configureView() {
        
    }
    
    func configureContsraints() {
        posterCard.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(5)
            $0.verticalEdges.equalTo(safeAreaLayoutGuide).inset(5)
        }
    }
}
