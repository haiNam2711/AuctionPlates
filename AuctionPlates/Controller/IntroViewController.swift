//
//  IntroViewController.swift
//  AuctionPlates
//
//  Created by Hai Nam on 20/4/24.
//

import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet private var steppers: [UIView]!
    @IBOutlet weak var introCollectionView: UICollectionView!
    private var photos: [UIImage]! = {
        var res : [UIImage] = []
        for str in K.IntroVC.PhotoArray {
            res.append(UIImage(named: str)!)
        }
        return res
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        introCollectionView.dataSource = self
        introCollectionView.delegate = self
        introCollectionView.isPagingEnabled = true
        introCollectionView.showsHorizontalScrollIndicator = false
        let nib = UINib(nibName: K.IntroVC.CustomCell, bundle: nil)
        introCollectionView.register(nib, forCellWithReuseIdentifier: K.IntroVC.CustomCell)
    }
    
    func setNewStepper(withIndex num: Int) {
        steppers.forEach { stepper in
            stepper.backgroundColor = (stepper.tag == num) ? UIColor(named: K.Color.darkGreen) : UIColor(named: K.Color.lightGreen)
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
    }
}

//MARK: - Set up Intro Collection View Data and Delegate
extension IntroViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.IntroVC.CustomCell, for: indexPath) as! IntroCollectionViewCell
        cell.imageView.image = photos![indexPath.row]
        return cell
    }
    
}

//MARK: - Collection Delegate FlowLayout
extension IntroViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - Completion Handler of CollectionView when complete scroll to new image
extension IntroViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: introCollectionView.contentOffset, size: introCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let indexPath = introCollectionView.indexPathForItem(at: visiblePoint) {
            let currentIndex = indexPath.row
            setNewStepper(withIndex: currentIndex)
        }
    }
    
}
