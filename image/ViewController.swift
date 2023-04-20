//
//  ViewController.swift
//  image
//
//  Created by 김기훈 on 2023/04/19.
//

import UIKit

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
    
    func fetchImage(_ url: URL) {
        Task {
            let (data, _) = try await URLSession.shared.data(from: url)
            image.image = UIImage(data: data)
        }
    }
}

class ViewController: UIViewController {
    
    var data = 0
    var images: [URL] = []

    var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .blue
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(collectionView)
        loadImages()
    }
    
    func loadImages() {
        var newURL: [URL] = [URL]()
        
        for number in data..<(data+10) {
            let urlString = "https://picsum.photos/id/\(number)/200/200"
            let url = URL(string: urlString)!
            if !images.contains(url) {
                newURL.append(url)
            }
        }
        data += 10
        images += newURL
        var i = [IndexPath]()
        for index in 0..<10 {
            let indexPath = IndexPath(item: images.count - 10 + index, section: 0)
            i.append(indexPath)
            
        }
        self.collectionView.performBatchUpdates({
            collectionView.insertItems(at: i)
        }, completion: nil)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item >= data - 1 {
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

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ImageCell else { return ImageCell() }
    
        cell.backgroundColor = .brown
        cell.index.text = String(indexPath.item)
        cell.fetchImage(images[indexPath.row])
        
        return cell
    }
}

