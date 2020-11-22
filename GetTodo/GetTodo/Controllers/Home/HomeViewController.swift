//
//  ViewController.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: 2,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10 ,right: 10)
    )
    
    var categoryList : [CategoryItem] = []{
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Home"
        
        startObservingCategories()
        configureCollectionView()
        getUsersCategories()
    }
    
    deinit {
        stopObservingCategories()
    }
}

//MARK: - Helper methods
extension HomeViewController {
    func getUsersCategories(){
        self.categoryList = CategoryProvider.categories()
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView?.register(UINib.init(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        collectionView.collectionViewLayout = columnLayout
    }
    
    func navigateToCategoryDetail(item:CategoryItem){
        guard let navigationController =  self.navigationController else{
            return
        }
        let storyBoard = UIStoryboard(name: "Category", bundle: nil)
        let categoryDetailViewController = storyBoard.instantiateViewController(withIdentifier: "CategoryDetailViewController") as CategoryDetailViewController
        categoryDetailViewController.selectedCategory = item
        navigationController.pushViewController(categoryDetailViewController, animated: true)
    }
}

extension HomeViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoriesCollectionViewCell = collectionView.dequeueReusableCell(at: indexPath)
        let item = categoryList[indexPath.row]
        let totalTaskCount = CategoryProvider.getCategoryTaskCount(categoryId: item.identifier)
        cell.configure(item: item,totalTask: totalTaskCount)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigateToCategoryDetail(item: self.categoryList[indexPath.row])
    }
}

extension HomeViewController:CategoryObserver{
    func onDidChange(categories: [CategoryItem]) {
        self.categoryList = categories
    }
}
