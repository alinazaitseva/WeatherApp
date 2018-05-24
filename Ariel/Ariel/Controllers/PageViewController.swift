//
//  PageViewController.swift
//  Ariel
//
//  Created by Alina Zaitseva on 5/17/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var cityManager = CityModel()
    let identifier = "WeatherViewController"
    var pageControl = UIPageControl()

    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "WeatherViewController", locationString: nil),
            self.getViewController(withIdentifier: "WeatherViewController", locationString: "Kyiv")
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        configurePagecontrol()
    }
    
    fileprivate func getViewController(withIdentifier identifier: String, locationString: String?) -> UIViewController{
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
        guard let weatherController = controller as? WeatherViewController else { return controller }
        weatherController.cityName = locationString
        return weatherController
    }
    
    func configurePagecontrol() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0  else { return pages.first }
//        guard pages.count > previousIndex else { return nil}
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex != pages.count else { return pages.first }
//        guard pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }
}
