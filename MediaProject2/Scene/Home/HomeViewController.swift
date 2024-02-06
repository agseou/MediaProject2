//
//  HomeViewController.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/01/30.
//

import UIKit
import SnapKit
import Kingfisher

class HomeViewController: BaseViewController {
    
    let tableView = UITableView()
    let titleList = ["Top Rating", "Popular", "Trend"]
    var imageList: [TVModel] = [TVModel(results: []),
                                TVModel(results: []),
                                TVModel(results: [])] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let group = DispatchGroup()
//        
//        group.enter()
//        TMDBAPIManager.shared.request(type: TVModel.self, api: .topLating) { type in
//            self.imageList[0] = type
//            group.leave()
//        }
//        group.enter()
//        TMDBAPIManager.shared.request(type: TVModel.self, api: .popular) { type in
//            self.imageList[1] = type
//            group.leave()
//        }
//        group.enter()
//        TMDBAPIManager.shared.request(type: TVModel.self, api: .trend) { type in
//            self.imageList[2] = type
//            group.leave()
//        }
        group.enter()
        TMDBSessionManager.shared.request(type: TVModel.self, api: .topLating) { type, error  in
            if error == nil { // error가 nil이면 네트워크 통신 성공
                guard let type = type else { return }
                self.imageList[0] = type
            } else {
                // error 분기처리
            }
            group.leave()
        }
        group.enter()
        TMDBSessionManager.shared.request(type: TVModel.self, api: .popular) { type, error  in
            if error == nil { // error가 nil이면 네트워크 통신 성공
                print("123")
                guard let type = type else { return }
                print("456")
                self.imageList[1] = type
            } else {
                // error 분기처리
            }
            group.leave()
        }
        group.enter()
        TMDBSessionManager.shared.request(type: TVModel.self, api: .trend) { type, error  in
            if error == nil { // error가 nil이면 네트워크 통신 성공
                guard let type = type else { return }
                self.imageList[2] = type
            } else {
                // error 분기처리
            }
            group.leave()
        }
        group.notify(queue: .main){
            self.tableView.reloadData()
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
        navigationItem.title = "TV"
    }
    
    override func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        tableView.rowHeight =  UIScreen.main.bounds.width * 0.5
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}


// MARK: - TableVIew
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        
        cell.collectionView.tag = indexPath.row
        cell.selectionStyle = .none
        cell.titleLabel.text = titleList[indexPath.row]
        cell.collectionView.reloadData()
        
        return cell
    }
    
}

// MARK: - CollectionView
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList[collectionView.tag].results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        let item = imageList[collectionView.tag].results[indexPath.item]
        if let poster = item.poster {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster)")
            cell.posterCard.kf.setImage(with: url, placeholder: UIImage(systemName: "heart"))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = TVDetailViewController()
        nextVC.id = imageList[collectionView.tag].results[indexPath.item].id
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
