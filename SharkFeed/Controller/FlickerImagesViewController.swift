//
//  FlickerImagesViewController.swift
//  SharkFeed
//
//  Created by Raxit Cholera on 2/12/18.
//  Copyright © 2018 Raxit Cholera. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "sharkImages"
private let refreshControl = UIRefreshControl()

class FlickerImagesViewController: UIViewController, CoreDataManagerDelegate {

    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var customView: UIView!
    var selectedKeyword:Keyword!
    private var imagesArray: [Image]!
    private var deleteImagesArray:[Image]!
    private var downloadImagesArray = [[String:Any]]()
    var pageNo:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTheKeyword()
        self.title = "Test"
        imagesArray = selectedKeyword.images?.allObjects as? [Image] ?? [Image]()
        
        CoreDataManager.sharedManager.delegate = self
        
        if(selectedKeyword.images?.allObjects.count == 0 ||  selectedKeyword.images?.allObjects.count == nil)
        {
            getImagefromFlicker()
        }
        setupRefresh()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchTheKeyword()
    }
    func setupRefresh(){
        if #available(iOS 10.0, *) {
            imageCollectionView.refreshControl = refreshControl
        } else {
            imageCollectionView.addSubview(refreshControl)
        }
        let refreshContents = Bundle.main.loadNibNamed("RefreshContents", owner: self, options: nil)
        customView = refreshContents![0] as! UIView
        customView.frame = refreshControl.bounds
        refreshControl.addTarget(self, action: #selector(resetimages), for: .valueChanged)
        refreshControl.addSubview(customView)

    }
    @objc func resetimages(){
        pageNo += 1
        
        deleteImagesArray = selectedKeyword.images?.allObjects as? [Image]
        for i in 0 ..< deleteImagesArray.count
        {
            //            selectedLocation.removeFromImages(deleteImagesArray[i])
            dbStack.context.delete(deleteImagesArray[i])
            dbStack.save()
        }
        refreshView()
        refreshControl.endRefreshing()
        getImagefromFlicker()
    }
    func fetchTheKeyword(){
        let request: NSFetchRequest<Keyword>
        if #available(iOS 10.0, *) {
            request = Keyword.fetchRequest()
        } else {
            request = NSFetchRequest(entityName: "Keyword")
        }
        do {
            let results = try dbStack.context.fetch(request)
            selectedKeyword = results[0]
        } catch let error {
            print(error.localizedDescription)
        }

    }
    
    func refreshView()
    {
        imagesArray = selectedKeyword.images?.allObjects as! [Image]
        performOnMainthread {
            self.imageCollectionView.reloadData()
        }
    }
    
    func getImagefromFlicker(){
        
        client.sharedInstance.fetchImagesFromFlicker(keyword: selectedKeyword.text!, ofPage: pageNo) { (result, error) in
            
            if error != nil {
                showAlertwith(title: "Error Fetching Images", message: "Flicker may have responded unexpectely", vc: self)
            } else {
                self.downloadImagesArray = result as! [[String:Any]]
                
                self.refreshView()
                self.downloadPhotos()
            }
        }
    }
    private func downloadPhotos()
    {
        CoreDataManager.sharedManager.keyword = selectedKeyword
        client.sharedInstance.downloadPhotos(forList: downloadImagesArray,resolution: Constants.FlickrResponseKeys.ThumbURL)
    }
    
    

}
extension FlickerImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return downloadImagesArray.count > 0 ? downloadImagesArray.count : selectedKeyword.images?.allObjects.count ?? 0
        return 10000000

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SharkCollectionViewCell
        
        if(imagesArray.count > indexPath.row){
            let image = UIImage(data: imagesArray[indexPath.row % imagesArray.count].image_t! as Data)
            cell.bindCell(image: image)
        } else {
            cell.bindCell(image: nil)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imagesVC = storyboard?.instantiateViewController(withIdentifier: "imageDetailed") as! ImageDetailViewController
        imagesVC.selectedImage = imagesArray[indexPath.row]
        navigationController?.pushViewController(imagesVC, animated: true)
    }
}
