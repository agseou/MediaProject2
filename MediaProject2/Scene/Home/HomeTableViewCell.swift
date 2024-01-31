//
//  HomeTableViewCell.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/01/30.
//

import UIKit
import SnapKit

class HomeTableViewCell: UITableViewCell {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureView()
        configureContsraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeTableViewCell: ConfigurableProtocol {
    func configureHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    func configureView() {
        collectionView.backgroundColor = .brown
    }
    
    func configureContsraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 3.2
        let height = UIScreen.main.bounds.height / 5
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    
}
