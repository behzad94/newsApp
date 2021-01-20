//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by DIAKO on 1/20/21.
//

import UIKit
import RxSwift
import Loaf

class NewsListViewController: BaseViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    let disposeBag = DisposeBag()
    let viewModel = NewsListViewModel()
    
    var newsList: NewsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.newsList()
        
    }
    
    override func initUIComponent() {
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(resource: R.nib.newsCollectionViewCell), forCellWithReuseIdentifier: "cell")
        
        if let patternImage = UIImage(named: "background") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        
        collectionView?.backgroundColor = .clear
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        view.contentMode = .scaleAspectFill
    }
    
    override func bindViewModel() {
        viewModel.newsListResponse.asObserver().subscribe(onNext: {[weak self] response in
            self?.newsList = response
            self?.collectionView.reloadData()
            self?.vibrateFeedback()
        }).disposed(by: disposeBag)
        
        viewModel.onShowError.asObserver().subscribe(onNext:{[weak self] response in
            self?.showToast(message: response)
        }).disposed(by: disposeBag)
    }
    
    func vibrateFeedback() {
        UIHelper.notificationVibrateFeedback()
    }
    
    func showToast(message: String){
        Loaf.dismiss(sender: self)
        Loaf(message, state: .custom(.init(backgroundColor: .black, icon: UIImage(named: "moon"))) ,sender: self).show()
    }
    
}

// MARK: CollectionView Data Source
extension NewsListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let list = newsList?.articles {
            return list.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCollectionViewCell
        if let news = newsList?.articles?[indexPath.row] {
            cell.set(news: news)
        }
        return cell
    }
}

// MARK: CollectionView Delegate
extension NewsListViewController: UICollectionViewDelegate {
    
}

// MARK: CollectionView Delegate Flow Layout
extension NewsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}

// MARK: Pinterest Layout Delegate
extension NewsListViewController: PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        if let list = newsList?.articles?[indexPath.row] {
            //            let image = UIImageView()
            //            image.kf.setImage(with: URL(string: list.coverImageURL ?? ""))
            //            return image.image?.size.height ?? 0
            if indexPath.row == 1 {
                return 277
            } else {
                return 296
            }
        } else {
            return 0
        }
    }
}
