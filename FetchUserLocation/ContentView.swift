//
//  ContentView.swift
//  FetchUserLocation
//
//  Created by DONG SHENG on 2022/8/11.
//

import CoreLocation
import CoreLocationUI
import SwiftUI
import UIKit

class LocationManager: NSObject, CLLocationManagerDelegate , ObservableObject{
    
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    
    override init(){
        super.init()
        manager.delegate = self
        manager.requestLocation()
    }
    
    func requestLocation(){
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location1 = locations.last?.coordinate else { return }
        print(location1)
        location = locations.last?.coordinate
        print(location)
    }
    
    // 必加
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
//            if let location = locationManager.location{
                VStack{
                    Text("Your 緯度: \(locationManager.location?.latitude ?? 0)")
                    Text("Your 經度: \(locationManager.location?.longitude ?? 0)")
                }
//            }
            LocationButton{
                locationManager.requestLocation()
            }
        }
        .onAppear{
            locationManager.requestLocation()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
