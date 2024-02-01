//
//  TVDetailTableViewCell.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/02/01.
//

import UIKit

class TVDetailTableViewCell: BaseTableViewCell {

    let backDrop = UIImageView()
    let gradientLayer = CAGradientLayer()
    let posterCard = PosterCardView(frame: .zero)
    let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont(name: "GmarketSansBold", size: 24)
        view.numberOfLines = 2
        return view
    }()
    let overViewLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 16, weight: .light)
        view.numberOfLines = 3
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(backDrop)
        backDrop.layer.addSublayer(gradientLayer)
        backDrop.addSubview(posterCard)
        backDrop.addSubview(titleLabel)
        backDrop.addSubview(overViewLabel)
    }
    
    override func configureCell() {
        DispatchQueue.main.async {
            self.gradientLayer.frame = self.backDrop.bounds
            self.gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            self.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            self.gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        }
    }
    
    override func configureLayout() {
        backDrop.snp.makeConstraints {
            $0.horizontalEdges.edges.equalTo(contentView)
        }
        posterCard.snp.makeConstraints {
            $0.height.equalTo(backDrop.snp.height).multipliedBy(0.8)
            $0.leading.equalTo(backDrop.snp.leading).offset(20)
            $0.centerY.equalTo(backDrop)
            $0.width.equalTo(backDrop.snp.height).multipliedBy(0.46)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(posterCard.snp.trailing).offset(20)
            $0.top.equalTo(backDrop).offset(30)
            $0.trailing.equalTo(backDrop).offset(-20)
        }
        overViewLabel.snp.makeConstraints {
            $0.leading.equalTo(posterCard.snp.trailing).offset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.trailing.equalTo(backDrop).offset(-20)
        }
        
    }
    
}
