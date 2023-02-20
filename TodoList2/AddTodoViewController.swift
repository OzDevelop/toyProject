//
//  AddTodoViewController.swift
//  TodoList2
//
//  Created by 변상필 on 2023/02/10.
//

import UIKit
import MapKit
import CoreLocation

class AddTodoViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
//    let map = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        map.setRegion(MKCoordinateRegion(center:  CLLocationCoordinate2D(latitude: 35.1342, longitude: 129.1032), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)

        
        self.map.showsUserLocation = true
        
//        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
//        setRegionAndAnnotation(center: center)
        

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var map: MKMapView!
    


    
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextView: UITextView!
    
    @IBAction func CancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    
    @IBAction func addListItemAction(_ sender: Any) {
        let title = titleTextField.text!
        let content = contentTextView.text ?? ""
        
        let item: TodoList = TodoList(title: title, content: content)
        
        print("Add List title : \(item.title)")
        list.append(item)
        self.navigationController?.popViewController(animated: true)
    }
}
