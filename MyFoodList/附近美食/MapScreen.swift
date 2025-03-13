//
//  LocationScreen.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/24.
//

import UIKit
import GoogleMaps
import CoreLocation
import FirebaseCore
import FirebaseFirestore

class MapScreen: MyViewController {

    private var mapView: GMSMapView!
    private let myLocationMgr = CLLocationManager()
    
    private let locationButton = MyPackageButton()
    
    private let db = Firestore.firestore()
    
    private var latitude = String()
    private var longitude = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myLocationMgr.distanceFilter = kCLLocationAccuracyNearestTenMeters
        myLocationMgr.desiredAccuracy = kCLLocationAccuracyBest
        myLocationMgr.delegate = self
        
        DispatchQueue.main.async {
            self.checkLocationAuthorization() // 確保在主線程檢查授權
        }
    }
}

//MARK: - UI
extension MapScreen {
    private func setupUI() {
    
        let width = UIScreen.main.bounds.width
        
        mapView = GMSMapView() // 初始化 mapView

        locationButton.buttonText = ""
        locationButton.buttonBackground = .clear
        locationButton.buttonBackgroundImage = .location
        locationButton.viewPadding()
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.buttonAction = { [weak self] in self?.setupInitialMapView() }
        
        self.view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        mapView.addSubview(locationButton)
        NSLayoutConstraint.activate([
            locationButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -width * 0.05),
            locationButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -width * 0.025),
            locationButton.widthAnchor.constraint(equalToConstant: width * 0.15),
            locationButton.heightAnchor.constraint(equalToConstant: width * 0.15),
        ])
        
        setupInitialMapView()
    }
    
    private func setupInitialMapView() {
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        
        if let location = myLocationMgr.location {
            latitude = String(describing: location.coordinate.latitude)
            longitude = String(describing: location.coordinate.longitude)
            
            updateMapToUserLocation(location)
        } else {
            print("zhan: location is nil")
        }
    }
    
    private func updateMapToUserLocation(_ location: CLLocation) {
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15)
        mapView.animate(to: camera)
    }
    
    private func setMarker(title: String, lat: String, lng: String, link: String) {
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(Double(lat)!, Double(lng)!)
        marker.map = mapView
        marker.title = title
        marker.userData = link
    }
}

// MARK: - CLLocationManager
extension MapScreen: CLLocationManagerDelegate {
    
    func checkLocationAuthorization() {
        print("檢查定位授權狀態：\(myLocationMgr.authorizationStatus)")
        
        switch myLocationMgr.authorizationStatus {
        case .notDetermined:
            myLocationMgr.requestWhenInUseAuthorization() // 請求授權
        case .restricted, .denied:
            showPermissionAlert()
        case .authorizedWhenInUse, .authorizedAlways:
            myLocationMgr.startUpdatingLocation() // 開始更新位置
        @unknown default:
            break
        }
    }
    
    private func showPermissionAlert() {
        let alert = UIAlertController(title: "定位權限已關閉",
                                      message: "請到 設定 > 隱私權 > 定位服務 開啟權限。",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "前往設定", style: .default, handler: { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            setupUI()

            updateMapToUserLocation(location)
            Task { await FoodDetail_FireStore() }
            myLocationMgr.stopUpdatingLocation() // 停止更新，避免不必要的呼叫
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("定位失敗: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

// MARK: - GoogleMap
extension MapScreen: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
                
        if let link = marker.userData {
            if let url = URL(string: link as! String) {
                UIApplication.shared.open(url)
            }
        }
    }
}

//MARK: - FireStore
extension MapScreen {
    private func FoodDetail_FireStore() async {
        
        showLoading()
        
        let memberID = UserDefaults.standard.string(forKey: UserDefaultsKey.user_id.rawValue) ?? ""

        do {
            let data = db.collection(FireStoreKey.Member.rawValue).document(memberID)
            let dataResponse = try await data.getDocument()
            
            let foodList_ID: [String] = dataResponse["FoodList_ID"] as! [String]
            
            for foodID in foodList_ID {
                let data_food = db.collection(FireStoreKey.FoodList.rawValue).document(foodID)
                let dataResponse_food = try await data_food.getDocument()
                
                let food = dataResponse_food["Food"] as! String
                let link = dataResponse_food["Link"] as! String
                let coordinate = dataResponse_food["Coordinate"] as! String
                
                let coordinates = coordinate
                    .trimmingCharacters(in: CharacterSet(charactersIn: "()")) // 去除括號
                    .split(separator: ",") // 以逗號切割
                    .map { $0.trimmingCharacters(in: .whitespaces) } // 去除空白

                let lat = coordinates[0]
                let lng = coordinates[1]
                
                setMarker(title: food, lat: lat, lng: lng, link: link)
            }
            
        } catch {
            MyPrint("Firestore 獲取座標失敗: \(error.localizedDescription)")
        }
        
        dismissLoading()
    }
}
