//
//  WeatherView.swift
//  sample-app
//
//  Created by Steven Chipman on 3/17/22.
//

import UIKit

class WeatherView: UIView {
    private var weather: Weather?

    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [locationLabel, conditionsStackView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillProportionally
        return view
    }()

    private lazy var conditionsStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [conditionImage, tempFLabel, UIView()])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillProportionally
        return view
    }()

    private let conditionImage: UIImageView = {
        let view = UIImageView()
        view.widthAnchor.constraint(equalToConstant: 64).isActive = true
        view.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return view
    }()

    private let tempFLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()

    init(coordinates: Coordinates) {
        super.init(frame: .zero)

        addSubview(mainStackView)
        mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true

        Task {
            self.weather = await WeatherService.shared.fetchWeather(coordinates: coordinates)
            render()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        guard
            let tempF = weather?.forecast?.tempF,
            let icon = weather?.forecast?.condition?.icon,
            let locationName = weather?.location?.name,
            let region = weather?.location?.region,
            let condition = weather?.forecast?.condition?.text,
            let localTime = weather?.location?.localtime
        else {
            // TODO: error view
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        tempFLabel.text = "\(Int(tempF)) ℉"
        locationLabel.text = "\(condition) in \(locationName), \(region) at \(formatter.string(from: localTime))"
        if let url = URL(string: "https:\(icon)"), let data = try? Data(contentsOf: url) {
            conditionImage.image = UIImage(data: data)
        }
    }

}
