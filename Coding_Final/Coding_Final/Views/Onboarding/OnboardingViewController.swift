//
//  OnboardingViewController.swift
//  Coding_Final
//
//  Created by Ethan Muller on 15/1/2022.
//

import UIKit
import SwiftUI

class OnboardingViewController: UIViewController {
    
    //MARK: - Statusbar Setup
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //MARK: - Variables
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = [
        OnboardingSlide(title: "Take a Picture!", discription: "Using the button on the bottom, press it once to take a picture!", image: #imageLiteral(resourceName: "placeholder-image")),
        OnboardingSlide(title: "Let us do the Work.", discription: "Our AI system scans the image that you took and will compare it with the thousands of words that it knows. Don't worry, it only takes a few seconds.", image: #imageLiteral(resourceName: "placeholder-image")),
        OnboardingSlide(title: "Save it to your Phone!", discription: "Once the AI has figured out what you wrote, press the box with an arrow to save it on a document or the clipboard to copy-paste it. ", image: #imageLiteral(resourceName: "placeholder-image"))]
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Take a Pic!", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    //MARK: - Viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: - Functions and Extensions




    @IBAction func NextBtnClicked(_ sender: Any) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(identifier: "HomeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            present(controller, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        }
    }
}

extension OnboardingViewController :
    UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return slides.count
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
            cell.setup(slides[indexPath.row])
            return cell
        }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
        
    }
}
