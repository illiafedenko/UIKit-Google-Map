//
//  ViewController.swift
//  Swift-UIKit
//
//  Created by qwe on 10/7/23.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var carSelectionView: UICollectionView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewLeft: UIView!
    @IBOutlet weak var topViewRight: UIView!
    @IBOutlet weak var topViewLabel: UILabel!
    
    @IBOutlet weak var selectVehicleItem1: UIView!
    @IBOutlet weak var selectVehicleItem2: UIView!
    @IBOutlet weak var selectVehicleItem3: UIView!
    @IBOutlet weak var selectVehicleItem4: UIView!
        
    @IBOutlet weak var continueBtn: UIButton!
    
    @IBOutlet weak var paymentView: UIView!
    
    var locationManager = CLLocationManager()
    var carTypes = [CarModel]()
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        
        topView.backgroundColor = UIColor.clear
        
        topViewLeft.backgroundColor = UIColor.clear
        
        topViewRight.backgroundColor = UIColorFromRGB(rgbValue: 0x191B1A)
        topViewRight.layer.cornerRadius = 26
        
        continueBtn.tintColor = UIColorFromRGB(rgbValue: 0x43B02A)
        continueBtn.layer.cornerRadius = 30
        
        paymentView.backgroundColor = UIColor.clear

        // Create a tap gesture recognizer
        let paymentGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        let topViewRightGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        let topViewLeftGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        
        topViewLeft.isUserInteractionEnabled = true
        topViewRight.isUserInteractionEnabled = true
        paymentView.isUserInteractionEnabled = true
        
        topViewLeft.addGestureRecognizer(topViewLeftGesture)
        paymentView.addGestureRecognizer(paymentGesture)
        topViewRight.addGestureRecognizer(topViewRightGesture)
        
        carSelectionView.register(UINib(nibName: "Car", bundle: nil), forCellWithReuseIdentifier: "cell")
        carSelectionView.allowsMultipleSelection = false
        carSelectionView.backgroundColor = UIColor.clear
        carTypes = setUpcarTypes()
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func setupMapView()  {
        
        self.mapView?.isMyLocationEnabled = true
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        self.mapView.mapStyle(withFilename: "MapStyle", andType: "json")
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let location = CLLocationCoordinate2D(latitude: -6.94, longitude: 39.01)
        let camera = GMSCameraPosition.camera(withLatitude: -6.94, longitude: 39.01, zoom: 10)
        self.mapView?.animate(to: camera)
        let marker = GMSMarker(position: location)
        marker.icon = UIImage(named: "marker")
        marker.map = mapView
    }
    
    func setUpcarTypes() -> [CarModel] {
        var cars = [CarModel]()
        
        var car1 = CarModel()
        car1?.carType = "StaBoda"
        car1?.carImage = UIImage(named: "bike")
        car1?.carPrice = "3,000"
        car1?.waitTime = "3 min"
        car1?.seat = "1 Seat"
        
        var car2 = CarModel()
        car2?.carType = "Bajaj"
        car2?.carImage = UIImage(named: "bike2")
        car2?.carPrice = "4,000"
        car2?.waitTime = "2 min"
        car2?.seat = "3 Seat"
        
        var car3 = CarModel()
        car3?.carType = "StaCab"
        car3?.carImage = UIImage(named: "bike3")
        car3?.carPrice = "5,000"
        car3?.waitTime = "4 min"
        car3?.seat = "4 Seat"
        
        var car4 = CarModel()
        car4?.carType = "StaRoyal"
        car4?.carImage = UIImage(named: "bike4")
        car4?.carPrice = "8,000"
        car4?.waitTime = "4 min"
        car4?.seat = "6 Seat"
        
        cars.append(car1!)
        cars.append(car2!)
        cars.append(car3!)
        cars.append(car4!)
 
        return cars
    }
    
    @IBAction func buttonClicked(_sender: Any) {
        showAlert()
    }
    
    // Implement the action method
    @objc func viewTapped() {
        // Do something when the view is tapped
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Alert", message: "Button clicked!", preferredStyle: .alert)
          
//        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
//            //Cancel Action
//        }))
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
        
        }))
         
        DispatchQueue.main.async {
            self.present(alert, animated: false, completion: nil)
        }
          
    }
}

extension GMSMapView {
    func mapStyle(withFilename name: String, andType type: String) {
        do {
            if let styleURL = Bundle.main.url(forResource: name, withExtension: type) {
                self.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }

}


extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Car
        cell.carInfo = carTypes[indexPath.row]
           
        if indexPath == selectedIndexPath {
            cell.view.layer.borderWidth = 5.0
            cell.view.layer.borderColor = UIColorFromRGB(rgbValue: 0x43B02A).cgColor
            cell.setShadow(applyShadow: false)
            cell.info.isHidden = false
            
            cell.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        }else{
            cell.setShadow(applyShadow: true)
            cell.view.layer.borderWidth = 0.0
            cell.view.layer.borderColor = UIColor.clear.cgColor
            cell.info.isHidden = true
        }
        
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = carSelectionView.cellForItem(at: indexPath) as? Car
        if let collectionCell =  cell{
            
            collectionCell.setShadow(applyShadow: false)
        }
        self.selectedIndexPath = indexPath
        carSelectionView.reloadData()
    }
    
}
