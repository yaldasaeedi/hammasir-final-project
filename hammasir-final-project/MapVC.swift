//
//  MapVC.swift
//  hammasir-final-project
//
//  Created by Helen Besharatian on 6/22/1402 AP.
//

import UIKit

class MapVC: UIViewController {
    var MapModel : MapM?
    var mapview: NTMapView?
    @IBOutlet weak var mapUIV: UIView!
    @IBOutlet weak var SearchDestinationUISB: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMap()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func searchingForDestination(_ sender: Any) {
        
        
    }
    
    func loadMap(){
        
        mapview = NTMapView(frame: mapUIV.bounds)
        guard let unwrappedMapView = mapview else {
            print("Map does not load")
            return
        }
        let returnedMapView = MapModel?.loadMap(mapView: unwrappedMapView)
        mapUIV.addSubview(returnedMapView!)
    }
    
    func longPressOnMap (){
                // Add a long press gesture recognizer to the view
            let longPressGesture = UILongPressGestureRecognizer(target: self, action:#selector(viewLongPressed(_:)))
            mapUIV.addGestureRecognizer(longPressGesture)
    }
            
    @objc func viewLongPressed(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            print("View long-pressed!")
                    // Perform any desired actions here
            }
        }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


