//
//  MonsterMapViewController.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 15.01.2023.
//

import UIKit
import MapKit

class MonsterMapViewController: UIViewController {
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    private lazy var myTeamButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.tintColor = UIColor(red: 0.31,
                                   green: 0.545,
                                   blue: 0.867,
                                   alpha: 1)
        button.addTarget(self,
                         action: #selector(pushMyTeamButton),
                         for: .touchUpInside)
        button.setTitle("Моя команда",
                        for: .normal)
        button.titleLabel?.font = UIFont(name: "SFUIDisplay-Semibold",
                                         size: 19)
        button.layer.backgroundColor = UIColor(red: 0.044,
                                               green: 0.044,
                                               blue: 0.044,
                                               alpha: 0.9).cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.tintColor = .white
        button.addTarget(self,
                         action: #selector(pressButtonToZoomIn),
                         for: .touchUpInside)
        button.setTitle("+",
                        for: .normal)
        button.titleLabel?.font = UIFont(name: "SFUIDisplay-Regular",
                                         size: 22)
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.tintColor = .white
        button.addTarget(self,
                         action: #selector(pushButtonToZoomOut),
                         for: .touchUpInside)
        button.setTitle("-",
                        for: .normal)
        button.titleLabel?.font = UIFont(name: "SFUIDisplay-Regular",
                                         size: 22)
        return button
    }()
    
    private lazy var zoomStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .center
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(red: 0.102,
                                       green: 0.102,
                                       blue: 0.102,
                                       alpha: 0.85)
        view.addArrangedSubview(plusButton)
        view.addArrangedSubview(minusButton)
        return view
    }()
    
    private let locationManager = CLLocationManager()
    var monsters = [MonsterAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addToView()
        addConstraint()
        loadMap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if monsters.isEmpty {
            generateMonsters()
        }
        zoomMap()
        
        Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { [weak self] _ in
            self?.updateMonsters()
        }
    }
    
    private func addToView() {
        view.addSubview(mapView)
        view.addSubview(myTeamButton)
        view.addSubview(zoomStackView)
    }
    
    private func addConstraint() {
        addConstraintToFullScreen(mapView)
        
        myTeamButton.translatesAutoresizingMaskIntoConstraints = false
        myTeamButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        myTeamButton.widthAnchor.constraint(equalToConstant: 270).isActive = true
        myTeamButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        myTeamButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        
        zoomStackView.translatesAutoresizingMaskIntoConstraints = false
        zoomStackView.heightAnchor.constraint(equalToConstant: 86).isActive = true
        zoomStackView.widthAnchor.constraint(equalToConstant: 38).isActive = true
        zoomStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        zoomStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    func generateMonsters() {
        for _ in 0..<30 {
            let monster = MonsterAnnotation.addMonsterAnnotation(generateRandomLocation())
            monsters.append(monster)
            mapView.addAnnotation(monster)
        }
    }
    
//    func updateMonsters() {
//        for (index, monster) in monsters.enumerated() {
//            if Double.random(in: 0...1) < 0.2 {
//                mapView.removeAnnotation(monster)
//                monsters.remove(at: index)
//            }
//        }
//        for _ in 0..<6 {
//            let monster = MonsterAnnotation.addMonsterAnnotation(generateRandomLocation())
//            monsters.append(monster)
//            mapView.addAnnotation(monster)
//        }
//    }
    
    func updateMonsters() {
        for monster in monsters {
            if Double.random(in: 0...1) < 0.2 {
                mapView.removeAnnotation(monster)
                guard let removeIndex = monsters.firstIndex(of: monster) else { return }
                monsters.remove(at: removeIndex)
            }
        }
        for _ in 0..<6 {
            let monster = MonsterAnnotation.addMonsterAnnotation(generateRandomLocation())
            monsters.append(monster)
            mapView.addAnnotation(monster)
        }
    }
    
    func generateRandomLocation() -> CLLocationCoordinate2D {
        let userLocation = mapView.userLocation.coordinate
        let lat = userLocation.latitude + Double.random(in: -0.01...0.01)
        let long = userLocation.longitude + Double.random(in: -0.01...0.01)
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    func updateDisplayedMonsters() {
        let userLocation = mapView.userLocation.coordinate
        for monster in monsters {
            let distance = CLLocation(latitude:
                                        userLocation.latitude,
                                      longitude:
                                        userLocation.longitude).distance(from:
                                                                            CLLocation(latitude:
                                                                                        monster.coordinate.latitude,
                                                                                       longitude:
                                                                                        monster.coordinate.longitude))
            //MARK: радиус видимости монстров до 1000м
            if distance > 300 {
                mapView.view(for: monster)?.isHidden = true
            } else {
                mapView.view(for: monster)?.isHidden = false
            }
        }
    }
    
    private func loadMap() {
        mapView.showsUserLocation = true
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func zoomMap() {
        guard let location = locationManager.location else {
            return
        }
        mapView.centerToLocation(location)
    }
    
    private func changeMapScale(_ percent: Double) {
        let region = MKCoordinateRegion(center:
                                            mapView.centerCoordinate,
                                        span:
                                            MKCoordinateSpan(latitudeDelta:
                                                                mapView.region.span.latitudeDelta * percent,
                                                             longitudeDelta:
                                                                mapView.region.span.longitudeDelta * percent))
        mapView.setRegion(region, animated: true)
    }
    
    func runTooFarAlert(distance: CLLocationDistance) {
        let alert = UIAlertController(title: nil,
                                      message: "Вы находитесь слишком далеко от монстра – \(lround(distance)) метров",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @IBAction func pressButtonToZoomIn() {
        changeMapScale(0.75)
    }
    
    @IBAction func pushButtonToZoomOut() {
        changeMapScale(1.25)
    }
    
    @IBAction func pushMyTeamButton() {
        let controller = ModelBuilder.createMyTeamModule()
        navigationController?.pushViewController(controller, animated: true)
    }
}

