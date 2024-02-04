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
    lazy var castList: [Cast] = []
    lazy var recommendList: [TV] = []
    
    var id: Int?
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let group = DispatchGroup()
        group.enter()
        TVAPIManager.shared.request(type: TVDetailModel.self, api: .seriesDetail(id: self.id ?? 12345)) { type in
            self.TVDetails = type
            group.leave()
        }
        group.enter()
        TVAPIManager.shared.request(type: TVCreditModel.self , api: .credits(id: self.id ?? 12345)) { type in
            self.castList = type.cast ?? []
            group.leave()
        }
        group.enter()
        TVAPIManager.shared.request(type: TVModel.self, api: .recommendation(id: self.id ?? 12345)) { type in
            self.recommendList = type.results
            group.leave()
        }
        group.notify(queue: .main){
            self.tableView.reloadData()
        }
    }
   
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UIScreen.main.bounds.width * 0.45
        tableView.register(TVDetailTableViewCell.self, forCellReuseIdentifier: "TVDetailTableViewCell")
        tableView.register(CastTableViewCell.self, forCellReuseIdentifier: "CastTableViewCell")
        tableView.register(RecommendationTableViewCell.self, forCellReuseIdentifier: "RecommendationTableViewCell")
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension TVDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVDetailTableViewCell", for: indexPath) as! TVDetailTableViewCell
            
            let backdropURL = URL(string: "https://image.tmdb.org/t/p/w500\(TVDetails.backdropPath ?? "")")
            cell.backDrop.kf.setImage(with: backdropURL)
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(TVDetails.posterPath ?? "")")
            cell.posterCard.kf.setImage(with: posterURL)
            cell.titleLabel.text = TVDetails.name
            cell.overViewLabel.text = TVDetails.overview
            
            return cell
        } else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as! CastTableViewCell
            
            cell.collectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: "CastCollectionViewCell")
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.reloadData()
            cell.collectionView.tag = 1
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendationTableViewCell", for: indexPath) as! RecommendationTableViewCell
            
            cell.collectionView.register(RecommendationCollectionViewCell.self, forCellWithReuseIdentifier: "RecommendationCollectionViewCell")
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.reloadData()
            cell.collectionView.tag = 2
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UIScreen.main.bounds.width * 0.45
        } else if indexPath.section == 1{
            return UIScreen.main.bounds.width * 0.40
        } else {
            return UIScreen.main.bounds.width * 0.4
        }
    }
    
    
}

extension TVDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       if  collectionView.tag == 1 {
            return castList.count
        } else {
            return recommendList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            return UICollectionViewCell()
        } else if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as! CastCollectionViewCell
            
            let item = castList[indexPath.item]
            let profileURL = URL(string: "https://image.tmdb.org/t/p/w500\(item.profilePath ?? "")")
            cell.castImage.kf.setImage(with: profileURL)
            cell.characterLabel.text = item.character
            cell.nameLabel.text = item.name
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCollectionViewCell", for: indexPath) as! RecommendationCollectionViewCell
            
            let item = recommendList[indexPath.item]
            let profileURL = URL(string: "https://image.tmdb.org/t/p/w500\(item.backdrop ?? "")")
            cell.posterCard.kf.setImage(with: profileURL)
            cell.titleLable.text = item.name
            
            return cell
        }
    }
    
}
