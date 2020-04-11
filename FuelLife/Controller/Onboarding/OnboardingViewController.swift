//
//  OnboardingViewController.swift
//  FuelLife
//
//  Created by Arie May Wibowo on 09/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class PreferencesCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        let layer = UIView()
        layer.frame = CGRect(x: 0, y: 0, width: 150, height: 200)
        layer.backgroundColor = .black
        
        
        let imageView = UIImageView.init(image: UIImage.init(named: "travel"))
          imageView.frame = CGRect(x:0,y:0,width:120,height:150)
          imageView.contentMode = .scaleAspectFit
        imageView.center = CGPoint(x:contentView.frame.size.width/2,y: contentView.frame.size.height/2 - 50)
        
        let txt1 = UILabel.init(frame: CGRect(x:32,y:imageView.frame.maxY+71,width:contentView.frame.size.width-64,height:50))
          txt1.textAlignment = .center
          txt1.font = UIFont.boldSystemFont(ofSize: 36.0)
          txt1.text = "test"
        
        layer.addSubview(imageView)
        layer.addSubview(txt1)
        contentView.addSubview(layer)
        
//        contentView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        contentView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
//        contentView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
//        contentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    
    
    var imagePreferences: [UIImage] = [#imageLiteral(resourceName: "popcorn"), #imageLiteral(resourceName: "supermarket"), #imageLiteral(resourceName: "fish"), #imageLiteral(resourceName: "wallet")]
    

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let cellIdentifier = "preferenceCell"

    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    
    var titles: [String] = ["Enjoy Life", "Budget Friendly", "Choose you preference"]
    var descriptions = ["life is short, do something about it", "entertainment that you can do, with your own budget", ""]
//    var imagePreferences = ["popcorn", "supermarket", "fish", "travel"]
    var images = ["theater", "wallet", "theater"]
    
    var collectionView: UICollectionView?
    
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let txt1 = UILabel.init(frame: CGRect(x:32,y:78,width:scrollWidth-64,height:100))
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        self.collectionView = UICollectionView.init(frame: CGRect(x: 0, y: txt1.frame.maxY+20, width: scrollWidth, height: 500), collectionViewLayout: layout)
        
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.register(PreferencesCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView?.backgroundColor = UIColor.blue
        
        for index in 0..<titles.count {
            if index < 2 {
                frame.origin.x = scrollWidth * CGFloat(index)
                  frame.size = CGSize(width: scrollWidth, height: scrollHeight)

                  let slide = UIView(frame: frame)

                  //subviews
                  let imageView = UIImageView.init(image: UIImage.init(named: images[index]))
                  imageView.frame = CGRect(x:0,y:0,width:300,height:300)
                  imageView.contentMode = .scaleAspectFit
                  imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)
                
                  let txt1 = UILabel.init(frame: CGRect(x:32,y:imageView.frame.maxY+71,width:scrollWidth-64,height:50))
                  txt1.textAlignment = .center
                  txt1.font = UIFont.boldSystemFont(ofSize: 36.0)
                  txt1.text = titles[index]

                  let txt2 = UILabel.init(frame: CGRect(x:32,y:txt1.frame.maxY+12,width:scrollWidth-64,height:100))
                  txt2.textAlignment = .center
                  txt2.numberOfLines = 3
                  txt2.font = UIFont.systemFont(ofSize: 24.0)
                  txt2.text = descriptions[index]

                  slide.addSubview(imageView)
                  slide.addSubview(txt1)
                  slide.addSubview(txt2)
                  scrollView.addSubview(slide)
            } else {
                frame.origin.x = scrollWidth * CGFloat(index)
                frame.size = CGSize(width: scrollWidth, height: scrollHeight)
                let slide = UIView(frame: frame)

                  //subviews
                txt1.textAlignment = .center
                txt1.numberOfLines = 3
                txt1.font = UIFont.boldSystemFont(ofSize: 36.0)
                txt1.text = titles[index]

                
                slide.addSubview(txt1)
                slide.addSubview(self.collectionView!)
                scrollView.addSubview(slide)
            }
            

        }

        //set width of scrollview to accomodate all the slides
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)

        //disable vertical scroll/bounce
        self.scrollView.contentSize.height = 1.0

        //initial state
        pageControl.numberOfPages = titles.count
        pageControl.currentPage = 0
        
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }

    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }


}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCellWidth = (collectionView.frame.width/2.5) * 2
        let totalSpacingWidth = 20 * (2 - 1)

        let leftInset = (collectionView.frame.width - CGFloat(totalCellWidth + CGFloat(totalSpacingWidth))) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PreferencesCell
        return cell
    }
    
    
}
