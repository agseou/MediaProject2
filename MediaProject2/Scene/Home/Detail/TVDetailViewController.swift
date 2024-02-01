//
//  TVDetailViewController.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/01/31.
//

import UIKit
import SnapKit
import Kingfisher

class TVDetailViewController: BaseViewController {

    
    var TVDetails: TVDetailModel = TVDetailModel(backdropPath: nil, id: nil, name: nil, numberOfSeasons: nil, originalLanguage: nil, originalName: nil, overview: nil, posterPath: nil, seasons: nil, status: nil)
    
    var id: String = ""
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
    let tavleView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TVAPIManager.shared.fetchDetailTV(id: self.id) { TVDetailModel in
            self.TVDetails = TVDetailModel
            self.configureView()
        }
    }
   
    override func configureHierarchy() {
        view.addSubview(backDrop)
        backDrop.layer.addSublayer(gradientLayer)
        backDrop.addSubview(posterCard)
        backDrop.addSubview(titleLabel)
        

    }
    
    override func configureView() {
        backDrop.backgroundColor = .orange
        
        gradientLayer.frame = backDrop.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        posterCard.backgroundColor = .blue
        
        let backdropURL = URL(string: "https://image.tmdb.org/t/p/w500\(TVDetails.backdropPath ?? "")")
        self.backDrop.kf.setImage(with: backdropURL)
        let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(TVDetails.posterPath ?? "")")
        self.posterCard.kf.setImage(with: posterURL)
        titleLabel.text = TVDetails.name
        
        
    }
    
    override func configureLayout() {
        backDrop.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.3)
        }
        posterCard.snp.makeConstraints {
            $0.height.equalTo(backDrop.snp.height).multipliedBy(0.7)
            $0.leading.equalTo(backDrop.snp.leading).offset(20)
            $0.centerY.equalTo(backDrop)
            $0.width.equalTo(backDrop.snp.height).multipliedBy(0.46)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(posterCard.snp.trailing).offset(20)
            $0.top.equalTo(backDrop).offset(30)
            $0.trailing.equalTo(backDrop).offset(20)
        }
    }
}

extension TVDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVDetailTableViewCell", for: indexPath) as! TVDetailTableViewCell
        
        
        return cell
    }
    
    
}
