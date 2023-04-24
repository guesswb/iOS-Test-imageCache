//
//  ViewController.swift
//  image
//
//  Created by 김기훈 on 2023/04/19.
//

import UIKit

//var cache: [Int: UIImage] = [:]
var cache = NSCache<NSString, UIImage>()

class ImageCell: UICollectionViewCell {
    var imageView: UIImageView = UIImageView(image: UIImage(named: "placeholder"))
    var index: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(imageView)
        addSubview(index)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func downSample(at data: Data, to pointSize: CGSize, scale: CGFloat) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else { return nil }
//        let imageSource = CGImageSourceCreateWithURL(url as CFURL, imageSourceOptions)!
        
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else { return nil }
        return UIImage(cgImage: downsampledImage)
    }
    
    func fetchImage(_ index: Int, _ url: URL) {
        
        Task {
            let (data, _) = try await URLSession.shared.data(from: url)
//            guard let imageFromData = UIImage(data: data) else { return }
//
//            let size = CGSize(width: frame.width, height: frame.height)
//            let renderer = UIGraphicsImageRenderer(size: size)
//
//            let image = renderer.image { context in
//                imageFromData.draw(in: CGRect(origin: .zero, size: size))
//            }
            
            guard let image = downSample(at: data, to: CGSize(width: frame.width, height: frame.height), scale: UIScreen.main.scale) else { return }
            imageView.image = image
            cache.setObject(image, forKey: url.absoluteString as NSString)
//            cache[index] = image
        }
    }
}

class ViewController: UIViewController {
    
    var images: [URL] = []
    
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
            
            if let image = cache.object(forKey: itemIdentifier.absoluteString as NSString) {
                cell.imageView.image = image
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
        if images.count >= 100 { return }
        
        var newURL: [URL] = [URL]()
        
        for number in images.count..<(images.count+20) {
            let urlString = "https://picsum.photos/id/\(number)/1000/1000"
            let url = URL(string: urlString)!
            
            newURL.append(url)
        }
        
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
        let width = (collectionView.frame.width - 20) / 2
        return CGSize(width: width, height: width)
    }
}
