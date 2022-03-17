//
//  NewsItemsViewController.swift
//  sample-app
//


import UIKit

class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let weatherView = WeatherView(coordinates: Coordinates(lat: 40.71, lon: -74.01))
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weatherView)

        weatherView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        weatherView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        weatherView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }


}

