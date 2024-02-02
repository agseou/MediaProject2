//
//  TVDetailTableViewCell.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/02/01.
//

import UIKit

class CastTableViewCell: BaseTableViewCell {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    override func configureCell() {
        titleLabel.text = "Cast"
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.top.equalTo(contentView).inset(10)
            $0.height.equalTo(28)
        }
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(contentView)
            $0.top.equalTo(titleLabel.snp.bottom)
        }
    }

    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 4.1
        layout.itemSize = CGSize(width: width, height: width * 4/3)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
}
