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
    var categoryList : [CategoryItem] = []{
        //Observe for changes in category list
        didSet{
            self.collectionView.reloadData()
        }
    }
    //Initialize column layout with custom values
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: 2,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 15, left: 15, bottom: 15 ,right: 15)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customize navigation style
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Home"
        
        //Style collectionview
        configureCollectionView()
        
        //Call observing functions
        startObservingTasks()
        startObservingCategories()
        
        //Get user's categories
        getUsersCategories()
    }
    
    deinit {
        stopObservingCategories()
    }
}

//MARK: - CategoryObserver
extension HomeViewController:CategoryObserver{
    func onDidChange(categories: [CategoryItem]) {
        self.categoryList = categories
    }
}

//MARK: - TaskObserver
extension HomeViewController:TaskObserver{
    func onDidChange(tasks: [TaskItem]) {
        self.collectionView.reloadData()
    }
}

//MARK: - PROVIDER FUNCTIONS
extension HomeViewController{
    ///Get User's categories and apply to self list
    func getUsersCategories(){
        self.categoryList = CategoryProvider.categories()
    }
}

//MARK: - Helper methods
extension HomeViewController {
    
    /// Applies collectionview settings
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView?.register(UINib.init(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        collectionView.collectionViewLayout = columnLayout
    }
    
    /// Push to CategoryDetailViewController with given categoryItem
    ///
    /// - Parameter item: categoryItem of selected
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

//MARK: - UICollectionViewDataSource,UICollectionViewDelegate
extension HomeViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoriesCollectionViewCell = collectionView.dequeueReusableCell(at: indexPath)
        cell.shadowDecorate()
        
        //Get category at index
        let item = categoryList[indexPath.row]
        
        //Calculate totalTask count by calling Provider function
        let totalTaskCount = CategoryProvider.getCategoryTaskCount(categoryId: item.identifier)
        
        //Send data to cell
        cell.configure(item: item,totalTask: totalTaskCount)
        
        //Returns CategoriesCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigateToCategoryDetail(item: self.categoryList[indexPath.row])
    }
}
