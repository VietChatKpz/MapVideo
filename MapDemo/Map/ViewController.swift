//
//  ViewController.swift
//  MapDemo
//
//  Created by Nguyễn Đình Việt on 20/06/2022.
//


//import GoogleMaps
//import UIKit
//import GooglePlaces
//import CoreLocation
//
//import Alamofire
//import SwiftyJSON
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var mapView: GMSMapView!
//
//    var camera:  GMSCameraPosition!
//    var locationManager: CLLocationManager = {
//        var _locationManager = CLLocationManager()
//        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//        return _locationManager
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        // hàm yêu cầu quyền truy cập
//        locationManager.requestWhenInUseAuthorization()
//        // gán delegate
//        locationManager.delegate = self
//        // bật vị trí trên map
//        mapView.isMyLocationEnabled = true
//        drawGoogleAPI()
//    }
//
//    func drawGoogleAPI() {
//        let origin = "\(21.0368973),\(105.832478)"
//        let destination = "\(21.0148203),\(105.8448225)"
//
//        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyA2ATMV4IlFzMQblvB-PfHq-LYuoudg_QE"
//
//        //        let url = URL(string: urlString)
//        //        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//        //            if error != nil {
//        //                print("error")
//        //            }else {
//        //                DispatchQueue.main.async {
//        //                   // self.mapView.clear()
//        //                    self.addSourceMarket()
//        //                }
//        //                do{
//        //                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : AnyObject]
//        //                    let routes = json["routes"] as! NSArray
//        //
//        //                    OperationQueue.main.addOperation ({
//        //                        for route in routes{
//        //                            let routeOverviewPolyline:NSDictionary = (route as! NSDictionary).value(forKey: "overview_polyline") as! NSDictionary
//        //                            let points = routeOverviewPolyline.object(forKey: "points")
//        //                            let path = GMSPath.init(fromEncodedPath: points as! String)
//        //                            let ponyline = GMSPolyline.init(path: path)
//        //                            ponyline.strokeWidth = 3
//        //                            ponyline.strokeColor = UIColor(red: 50/255, green: 165/255, blue: 102/255, alpha: 1.0)
//        //
//        //                            let bounds = GMSCoordinateBounds(path: path!)
//        //                            self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 30.0))
//        //                        }
//        //                    })
//        //
//        //
//        //                }catch let error as NSError {
//        //                    print("error: \(error)")
//        //                }
//        //            }
//        //        }).resume()
//
//        //MARK: ABC
//        AF.request(urlString).responseJSON { (reseponse) in
//            guard let data = reseponse.data else {
//                return
//            }
//
//            do {
//                let jsonData = try JSON(data: data)
//                let routes = jsonData["routes"].arrayValue
//
//                for route in routes {
//                    let overview_polyline = route["overview_polyline"].dictionary
//                    let points = overview_polyline?["points"]?.string
//                    let path = GMSPath.init(fromEncodedPath: points ?? "")
//                    let polyline = GMSPolyline.init(path: path)
//                    polyline.strokeColor = .systemBlue
//                    polyline.strokeWidth = 5
//                    polyline.map = self.mapView
//                }
//            }
//            catch let error {
//                print(error.localizedDescription)
//            }
//        }
//        let marker1 = GMSMarker(position: CLLocationCoordinate2D(latitude: 21.0368973, longitude: 105.832478))
//        marker1.title = "Lăng Bác"
//        marker1.icon = UIImage(named: "saucer 1")
//        marker1.snippet = "VietNam"
//        marker1.map = mapView
//
//        let marker2 = GMSMarker(position: CLLocationCoordinate2D(latitude: 21.0148203, longitude: 105.8448225))
//        marker2.title = "Công ty CP CK VN"
//        marker2.icon = UIImage(named: "tree 1")
//        marker2.snippet = "VietNam"
//        marker2.map = mapView
//
//    }
//
//    func addSourceMarket(){
//        let marker1 = GMSMarker(position: CLLocationCoordinate2D(latitude: 21.0368973, longitude: 105.832478))
//        marker1.title = "Lăng Bác"
//        marker1.icon = UIImage(named: "saucer 1")
//        marker1.snippet = "VietNam"
//        marker1.map = mapView
//
//        let marker2 = GMSMarker(position: CLLocationCoordinate2D(latitude: 21.0148203, longitude: 105.8448225))
//        marker2.title = "Công ty CP CK VN"
//        marker2.icon = UIImage(named: "tree 1")
//        marker2.snippet = "VietNam"
//        marker2.map = mapView
//
//    }
//
//    //    func goTotalDistance() {
//    //        let origin = "\(1),\(1)"
//    //        let destination = "\(1),\(1)"
//    //
//    //        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&key=AIzaSyBWFr2TsBWEr-e87uppfMdSBrfzXj3LsyU"
//    //
//    //        let url = URL(string: urlString)
//    //        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//    //            if error != nil {
//    //                print("error")
//    //            }else {
//    //                do{
//    //                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : AnyObject]
//    //                    let rows = json["rows"] as! NSArray
//    //                    print(rows)
//    //
//    //                    let dic = rows[0] as! Dictionary<String, Any>
//    //                    let elments = dic["elements"] as! NSArray
//    //                    let dis = elments[0] as! Dictionary<String, Any>
//    //                    let distanceMiles = dis["distance"] as! Dictionary<String, Any>
//    //                    let miles = distanceMiles["text"]! as! String
//    //
//    //
//    //                }catch let error as NSError {
//    //                    print("error: \(error)")
//    //                }
//    //            }
//    //        }).resume()
//    //    }
//
//}
//
//extension ViewController: CLLocationManagerDelegate{
//    // thay đổi quyền truy cập
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .notDetermined:
//            locationManager.requestAlwaysAuthorization()
//        case .authorizedAlways:
//            locationManager.startUpdatingLocation()
//            break
//        case .authorizedWhenInUse:
//            locationManager.startUpdatingLocation()
//            break
//        case .denied:
//            print("Quyền truy cập bị từ chối")
//            break
//        case .restricted:
//            print("Quyền truy cập bị hạn chế")
//            break
//        default:
//            fatalError()
//        }
//    }
//    // hàm này cập nhật toạ độ người dùng
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else {
//            return
//        }
//
//        camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), zoom: 10)
//        locationManager.stopUpdatingLocation()
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude , longitude: coordinate.longitude)
//        marker.title = "Me"
//        marker.snippet = "VietNam"
//        marker.map = mapView
//        marker.icon = UIImage(named: "car 1")
//
//        // sử dụng animate chuyển camera về trung tâm màn hình theo với độ zoom là 6
//        self.mapView.animate(to: camera)
//    }
//
//}
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    
    var originLatitude: Double = 0
    var originLongtitude: Double = 0
    
    var destinationLatitude: Double = 0
    var destinationLongtitude: Double = 0
    
    let directionService = DirectionService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.authorizationStatus() == .denied {
            
            showSettingAlert(message: "Need location!!!")
            return
        }
        
        guard let location = locationManager.location else {
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            
            guard let self = self,
                  error == nil,
                  let placemarks = placemarks,
                  placemarks.count > 0 else {
                
                return
                
            }
            let placemark = placemarks[0]
            
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = false
        
        
        mapView.delegate = self
        
        
        
        addMarker(latitude: 21.0368973, longitude: 105.832478, title: "Lăng Bác", snippet: "Hà Nội", icon: UIImage(named: "tree 1")!)
        addMarker(latitude: 21.0148203, longitude: 105.8448225, title: "Công ty CP CK Việt Nam", snippet: "Hà Nội", icon: UIImage(named: "saucer 1")!)
    }
    
    fileprivate func direction() {
        self.mapView.clear()
        self.addMarker(latitude: originLatitude, longitude: originLongtitude, title: "Vi tri cua ban", snippet: "Ha Noi", icon: UIImage(named: "car 1")!)
        self.addMarker(latitude: 21.0368973, longitude: 105.832478, title: "Lăng Bác", snippet: "Hà Nội", icon: UIImage(named: "tree 1")!)
        self.addMarker(latitude: 21.0148203, longitude: 105.8448225, title: "Công ty CP CK Việt Nam", snippet: "Hà Nội", icon: UIImage(named: "saucer 1")!)
        let origin: String = "\(originLatitude),\(originLongtitude)"
        let destination: String =
            "\(destinationLatitude),\(destinationLongtitude)"

        self.directionService.getDirections(origin: origin,
                                            destination: destination) { [weak self] (success) in
            if success {
                DispatchQueue.main.async {
                    self?.drawRoute()
                }
            } else {
                print("error direction")
            }
        }
    }
    
    fileprivate func drawRoute() {
        for step in self.directionService.selectSteps {
            if step.polyline.points != "" {
                let path = GMSPath(fromEncodedPath: step.polyline.points)
                let routePolyline = GMSPolyline(path: path)
                routePolyline.strokeColor = UIColor.red
                routePolyline.strokeWidth = 5.0
                routePolyline.map = mapView
            } else {
                return
            }
        }
    }
    
    fileprivate func afterDirection() {
        self.directionService.selectLegs.removeAll()
        self.directionService.selectSteps.removeAll()
    }
    
    func addMarker(latitude: Double, longitude: Double, title: String, snippet: String, icon: UIImage){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = title
        marker.icon = icon
        marker.snippet = snippet
        marker.map = self.mapView
    }
    
    
}

extension ViewController: CLLocationManagerDelegate {
    //Handle incoming location events.
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        if let location: CLLocation = locations.last {
            let locationLatitude = location.coordinate.latitude
            let locationLongtitude = location.coordinate.longitude
            self.originLatitude = locationLatitude
            self.originLongtitude = locationLongtitude
            self.addMarker(latitude: originLatitude, longitude: originLongtitude, title: "Vi tri cua ban", snippet: "Ha Noi", icon: UIImage(named: "car 1")!)
            let camera = GMSCameraPosition.camera(
                withLatitude: locationLatitude,
                longitude: locationLongtitude, zoom: zoomLevel)
            if mapView.isHidden {
                mapView.isHidden = false
                mapView.camera = camera
            } else {
                mapView.animate(to: camera)
            }
//            let circle = GMSCircle.init(position: camera.target, radius: 0)
//           circle.fillColor = UIColor.clear
//            circle.map = mapView
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        self.destinationLatitude = marker.position.latitude
        self.destinationLongtitude = marker.position.longitude
        self.direction()
        self.afterDirection()
        return true
    }
}
