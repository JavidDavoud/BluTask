//
//  ViewController.swift
//  BluTask
//
//  Created by Javid on 4/19/23.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var refresher:UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionLayout()
    }

    func setupCollectionLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, enviroment in
            switch sectionIndex {
            case 0 :
                return self?.favoritesSection()
            default:
                return self?.allCaseSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.blue
        self.refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
        collectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: "FavoritsSectionHeadeID",
                                withReuseIdentifier: "FavoritsHeaderID")
    }

    func favoritesSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                              , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100)
                                               , heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                     , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                      , bottom: 0, trailing: 15)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [.init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                       heightDimension: .absolute(30)),
                                                    elementKind: "FavoritsSectionHeadeID",
                                                    alignment: .topLeading)]

        return section
    }

    func allCaseSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.boundarySupplementaryItems = [.init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                       heightDimension: .absolute(30)),
                                                    elementKind: "FavoritsSectionHeadeID",
                                                    alignment: .topLeading)]
        return section
    }

    @objc func refreshData() {
        print("refresh")
    }
}

extension MainViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCell", for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: "FavoritsHeaderID",
                                                                     for: indexPath)
        let label = UILabel(frame: header.bounds)
        if indexPath.section == 0 {
            label.text = "Favorites"
        } else {
            label.text = "All"
        }
        label.font = UIFont.boldSystemFont(ofSize: 20)
        header.addSubview(label)
        return header
    }

}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.section) \(indexPath.row)")
    }
}
