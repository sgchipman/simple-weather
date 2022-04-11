//
//  NewsItemsViewController.swift
//  sample-app
//


import UIKit

class WeatherViewController: UIViewController {

    var locationsService: FollowedLocationsService?

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 10
        view.distribution = .fillProportionally
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        locationsService = FollowedLocationsService()
        locationsService?.fetchLocations { locations in
            for coordinates in locations {
                let weatherView = WeatherView(coordinates: coordinates!)
                weatherView.translatesAutoresizingMaskIntoConstraints = false
                self.stackView.addArrangedSubview(weatherView)
            }
        }
    }
}

