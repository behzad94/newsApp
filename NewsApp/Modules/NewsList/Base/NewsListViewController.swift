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
    
    var newsList = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.newsList()
    }
    
    override func initUIComponent() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(resource: R.nib.newsCollectionViewCell), forCellWithReuseIdentifier: "cell")
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let numberOfCellInLine = 2
        //
        let viewWidth = view.frame.width - 10
        layout.itemSize = CGSize(width: (Int(viewWidth) / numberOfCellInLine), height: 280)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        collectionView!.collectionViewLayout = layout
        
        if let patternImage = UIImage(named: "background") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        
        collectionView?.backgroundColor = .clear
        //        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        //        view.contentMode = .scaleAspectFill
    }
    
    override func bindViewModel() {
        viewModel.newsListResponse.asObserver().subscribe(onNext: {[weak self] response in
            self?.newsList.append(contentsOf: response)
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
    
    func showBottomSheet() {
        performSegue(withIdentifier: R.segue.newsListViewController.newsListToCategory.identifier, sender: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            print(" you reached end of the table")
            loadMoreNews()
        }
    }
    
    func loadMoreNews() {
        viewModel.loadMoreNews(totalDisplayedNews: newsList.count)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.newsListViewController.newsListToCategory.identifier {
            let destination = segue.destination as? ActionSheetViewController
            destination?.delegate = self
        }
    }
    
    @IBAction func categoryTapped(_ sender: Any) {
        showBottomSheet()
    }
}

// MARK: CollectionView Data Source
extension NewsListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCollectionViewCell
        cell.set(news: newsList[indexPath.row])
        return cell
    }
}

// MARK: CollectionView Delegate
extension NewsListViewController: UICollectionViewDelegate {
    
}


extension NewsListViewController: CategoryDelegate {
    func CategorySelected(category: String) {
        newsList = [News]()
        collectionView.reloadData()
        viewModel.category = category
        viewModel.newsList()
    }
}
