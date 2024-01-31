//
//  HomeViewController.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/01/30.
//

import UIKit
import SnapKit
import Kingfisher

class HomeViewController: UIViewController {
    
    let tableView = UITableView()
    var imageList: [TVModel] = [TVModel(results: []),
                                TVModel(results: []),
                                TVModel(results: [])]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureView()
        configureContsraints()
        
        TVAPIManager.shared.fetchTopRatingTV { TVModel in
            self.imageList[0] = TVModel
            DispatchQueue.global().async {
                TVAPIManager.shared.fetchPopularTV { TVModel in
                    self.imageList[1] = TVModel
                    DispatchQueue.global().async {
                        TVAPIManager.shared.fetchTrendingTV { TVModel in
                            self.imageList[2] = TVModel
                        }
                    }
                }
            }
            
        }
    }

}

// MARK: - configureVC
extension HomeViewController: ConfigurableProtocol {
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        
        tableView.rowHeight = UIScreen.main.bounds.height / 5
    }
    
    func configureContsraints() {
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
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(item.poster)")
        cell.posterCard.kf.setImage(with: url, placeholder: UIImage(systemName: "heart"))
        
        return  cell
    }
    
}

#Preview {
    HomeViewController()
}
