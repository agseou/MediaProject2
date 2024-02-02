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

//    enum DetailType {
//        case header
//        case cast
//        
//        var contenst: Any {
//            switch self {
//            case .header:
//                return TVDetails
//            case .cast:
//                return castList
//            }
//        }
//    }
    
    var TVDetails: TVDetailModel = TVDetailModel(backdropPath: nil, id: nil, name: nil, numberOfSeasons: nil, originalLanguage: nil, originalName: nil, overview: nil, posterPath: nil, seasons: nil, status: nil)
    lazy var castList: [Cast] = []
    
    var id: Int?
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TVAPIManager.shared.request(type: TVDetailModel.self, api: .seriesDetail(id: self.id ?? 12345)) { type in
            self.TVDetails = type
            self.tableView.reloadData()
        }
        TVAPIManager.shared.request(type: TVCreditModel.self , api: .credits(id: self.id ?? 12345)) { type in
            self.castList = type.cast ?? []
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
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension TVDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as! CastTableViewCell
            
            cell.collectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: "CastCollectionViewCell")
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.reloadData()
            
            return cell
        }
    }
    
    
}

extension TVDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as! CastCollectionViewCell
        
        let item = castList[indexPath.item]
        let profileURL = URL(string: "https://image.tmdb.org/t/p/w500\(item.profilePath ?? "")")
        cell.castImage.kf.setImage(with: profileURL)
        cell.characterLabel.text = item.character
        cell.nameLabel.text = item.name
        
        return cell
    }
    
}
