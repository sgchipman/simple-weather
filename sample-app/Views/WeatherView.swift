//
//  WeatherView.swift
//  sample-app
//
//  Created by Steven Chipman on 3/17/22.
//

import UIKit

class WeatherView: UIView {
    private var weather: Weather? {
        didSet {
            render()
        }
    }

    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [conditionImage, tempFLabel, tempCLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 10
        view.alignment = .center
        view.distribution = .equalCentering
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

    private let tempCLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    init(coordinates: Coordinates) {
        super.init(frame: .zero)

        addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true

        Task {
            self.weather = await WeatherService.shared.fetchWeather(coordinates: coordinates)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        guard
            let tempF = weather?.forecast?.tempF,
            let tempC = weather?.forecast?.tempC,
            let icon = weather?.forecast?.condition?.icon
        else {
            // TODO: error view
            return
        }

        tempFLabel.text = "\(tempF) ℉"
        tempCLabel.text = "\(tempC) ℃"

        if let url = URL(string: "https:\(icon)"), let data = try? Data(contentsOf: url) {
            conditionImage.image = UIImage(data: data)
        }
    }

}
