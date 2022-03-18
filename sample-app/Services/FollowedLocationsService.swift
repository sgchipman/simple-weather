//
//  FollowedLocationsService.swift
//  sample-app


import Foundation

class FollowedLocationsService {

    // Have this talk to the backend and retrieve locations the user has added.
    func fetchLocations(completion: @escaping ([Coordinates?]) -> Void) {
        completion([
            Coordinates(lat: 40.7128, lon: -74.0060),
            Coordinates(lat: 34.0522, lon: -118.2437),
            Coordinates(lat: 42.4963, lon: -96.4049),
            Coordinates(lat: 45.5152, lon: -122.6784)
        ]);
    }
}
