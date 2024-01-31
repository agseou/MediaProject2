//
//  PosterImageView.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/01/30.
//

import UIKit

class PosterImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        backgroundColor = .systemGray5
        contentMode = .scaleAspectFill
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
