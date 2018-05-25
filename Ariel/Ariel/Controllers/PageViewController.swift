//
//  PageViewController.swift
//  Ariel
//
//  Created by Alina Zaitseva on 5/17/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    let identifierR = "WeatherViewController"
    var pageControl = UIPageControl()
    var cityManager = CityModel()

    lazy var orderedController: [UIViewController] = {
       var pages = [self.getViewController(withLocationString: nil),
                    self.getViewController(withLocationString: "Lviv")]
        for city in cityManager.cities {
            pages.append(self.getViewController(withLocationString: city))
        }
        return pages
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let firstVC = orderedController.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        configurePagecontrol()
    }
    
    @IBAction func addCity(_ sender: UIBarButtonItem) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityViewController") as? CityViewController else { return }
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
    }
    func addPage() -> [UIViewController] {
        let data = self.cityManager
        if cityManager.isDoingOperation || cityManager.addedCity {
            cityManager.isDoingOperation = false
            cityManager.previousCity = cityManager.cityAmount
            for index in 0..<data.cityAmount {
                orderedController.append(self.getViewController(withLocationString: data.cities[index]))
            }
        }
        return orderedController
    }
    
    fileprivate func getViewController(withLocationString locationString: String?) -> UIViewController{
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifierR)
        guard let weatherController = controller as? WeatherViewController else { return controller }
        weatherController.cityName = locationString
        return weatherController
    }
    
    func configurePagecontrol() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = orderedController.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedController.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0  else { return nil }
        guard orderedController.count > previousIndex else { return nil}
        return orderedController[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedController.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex != orderedController.count else { return nil }
        guard orderedController.count > nextIndex else { return nil }
        return orderedController[nextIndex]
    }
}
