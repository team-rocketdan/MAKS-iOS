//
//  NaverMapView.swift
//  MAKS
//
//  Created by sole on 2023/09/20.
//
import UIKit
import SwiftUI
import NMapsMap


struct NaverMapView: View {
    let locationManager = CLLocationManager()
    
    var body: some View {
        VStack {
            NaverMap()
                .frame(height: 300)
        }
        
        .onAppear {
            requestUserLocationAuthorization()
        }
    }
    
    //MARK: - requestUserLocationAuthorization
    
    func requestUserLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    

}

struct NaverMap: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some NaverMapViewController {
        let naverMapVC = NaverMapViewController()
        return naverMapVC
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType,
                                context: Context) {
    }
}

class NaverMapViewController: UIViewController,
                              CLLocationManagerDelegate {
    let locationManager: CLLocationManager = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let naverMap = NMFNaverMapView(frame: view.frame)
        naverMap.frame = .init(x: 0,
                               y: 0,
                               width: UIScreen.screenWidth,
                               height: 300)
        
        naverMap.mapView.mapType = .basic
        // 실내 지도 활성화합니다.
        naverMap.mapView.isIndoorMapEnabled = true

        // 카메라의 대상 지점을 한반도 인근으로 제한합니다.
        naverMap.mapView.extent = NMGLatLngBounds(southWestLat: 31.43,
                                                  southWestLng: 122.37,
                                                  northEastLat: 44.35,
                                                  northEastLng: 132)
        naverMap.mapView.minZoomLevel = 7.0
        naverMap.mapView.maxZoomLevel = 20.0

        naverMap.showLocationButton = true
        naverMap.mapView.positionMode = .compass
        
        
        locationManager.delegate = self

        view.addSubview(naverMap)
    }
}



