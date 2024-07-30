//
//  ViewController.swift
//  PhotoSearch
//
//  Created by minseo kim on 2021/11/10.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate{
    
    private var collectionView: UICollectionView?
    let searchbar = UISearchBar()
    
    var page: Int = 1
    var totalPage: Int = 1
    var images: [UIImage] = []
    var results: [Result] = [] {
        didSet {
            if results.count == 0 {
                emptyLabel.isHidden = false
            } else {
                emptyLabel.isHidden = true
            }
        }
    }
    var searchBarClicked = false
    
    @IBOutlet weak var emptyLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
   
        searchbar.delegate = self
        searchbar.text = nil
        view.addSubview(searchbar)
            
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.size.width / 2, height: view.frame.size.width / 2)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        self.collectionView = collectionView
        results = []
        self.collectionView?.reloadData()
        
        fetchPhotos(query: "random")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchbar.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.frame.size.width - 20, height: 50)
        collectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 55, width: view.frame.size.width, height: view.frame.size.height - 55)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder()
        searchBarClicked = true
        
        if let text = searchbar.text {
            results = []
            fetchPhotos(query: text)
        }
    }
    
    func fetchPhotos(query: String, page: Int = 1) {
        let urlString = "https://api.unsplash.com/search/photos?page=\(page)&per_page=50&query=\(query)&client_id=xzU3IwhiLLEBRV42ht6eWExW5LfcC7TaU-P-W2b9a0c"
        guard let url = URL(string:urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self?.totalPage = jsonResult.total_pages
                    self?.results += jsonResult.results
                    self?.collectionView?.reloadData()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView (_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let imageURLString = results[indexPath.row].urls.regular
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: imageURLString)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else { return }
        detailVC.modalPresentationStyle = .fullScreen
        self.present(detailVC, animated: true, completion: nil)
        
        let imageURLString = results[indexPath.row].urls.regular
        detailVC.detailImageUrl = imageURLString
    }
}

extension ViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
           if results.count - 1 == indexPath.row {
                if searchBarClicked == false {
                    if page < totalPage {
                        page += 1
                        
                        self.fetchPhotos(query: "random")
                        self.collectionView?.reloadData()
                    }
                } else {
                    if page < totalPage {
                            page += 1
                            
                            if let text = searchbar.text {
                                self.fetchPhotos(query: text, page: page)
                                self.collectionView?.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
