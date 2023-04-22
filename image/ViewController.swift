//
//  ViewController.swift
//  image
//
//  Created by 김기훈 on 2023/04/19.
//

import UIKit

var cache: [Int: UIImage] = [:]

class ImageCell: UICollectionViewCell {
    var image: UIImageView = UIImageView(image: UIImage(named: "placeholder"))
    var index: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        image.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(image)
        addSubview(index)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchImage(_ index: Int, _ url: URL) {
        Task {
            let (data, _) = try await URLSession.shared.data(from: url)
            let imageFromData = UIImage(data: data)
            image.image = imageFromData
            cache[index] = imageFromData
        }
    }
}

class ViewController: UIViewController {
    
    var images: [URL] = []
    var index: Int = 0
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, URL>!
    
    var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        dataSource = UICollectionViewDiffableDataSource<Section, URL>(collectionView: self.collectionView) { collectionView, indexPath, itemIdentifier -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ImageCell else { return ImageCell() }
        
            cell.backgroundColor = .brown
            cell.index.text = String(indexPath.item)
            
            if let image = cache[indexPath.row] {
                cell.image.image = image
            } else {
                cell.fetchImage(indexPath.row, itemIdentifier)
            }
            
            return cell
        }
        collectionView.dataSource = dataSource
        collectionView.backgroundColor = .blue
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(collectionView)
        loadImages()
    }
    
    func loadImages() {
        var newURL: [URL] = [URL]()
        
        for number in index..<(index+20) {
            let urlString = "https://picsum.photos/id/\(number)/1000/1000"
            let url = URL(string: urlString)!
            
            newURL.append(url)
        }
        index += 20
        
        images += newURL
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, URL>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(images)
        
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item >= images.count - 1 {
            loadImages()
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20) / 3
        return CGSize(width: width, height: width)
    }
}
