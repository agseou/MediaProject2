//
//  BaseCollectionViewCell.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/01/31.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureCell()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() { }
    func configureCell()  { }
    func configureLayout() { }
}
