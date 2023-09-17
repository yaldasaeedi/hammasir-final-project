//
//  MapVC.swift
//  hammasir-final-project
//
//  Created by Helen Besharatian on 6/22/1402 AP.
//
import UIKit

class MapVC: UIViewController {
    
    var mapModel: MapModel?
    var mapView: NTMapView?
    
    @IBOutlet weak var mapContainerView: UIView!
    
    override func viewDidLoad() {
        loadMap()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func loadMap() {
        
        mapView = NTMapView(frame: mapContainerView.bounds)
        guard let unwrappedMapView = mapView else {
            
            print("Map view is not initialized")
            return
        }
        let neshan = NTNeshanServices.createBaseMap(NTNeshanMapStyle.NESHAN)
        unwrappedMapView.getLayers().add(neshan)
        
        let neshan2 = NTNeshanServices.createTrafficLayer()
        unwrappedMapView.getLayers().add(neshan2)
        
        let neshan3 = NTNeshanServices.createPOILayer(false)
        unwrappedMapView.getLayers().add(neshan3)
        
        unwrappedMapView.setFocalPointPosition(NTLngLat(x: 59.2, y: 36.5), durationSeconds: 0.4)
        unwrappedMapView.setZoom(13, durationSeconds: 0.4)
        mapContainerView.addSubview(unwrappedMapView)
      
    }
   
    
    func longPressOnMap (){
                    
        let longPressGesture = UILongPressGestureRecognizer(target: self, action:#selector(viewLongPressed(_:)))
        mapContainerView.addGestureRecognizer(longPressGesture)
    }

    @objc func viewLongPressed(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began {
            
            print("View long-pressed!")
        }
    }
}
