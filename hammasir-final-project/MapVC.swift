//
//  MapVC.swift
//  hammasir-final-project
//
//  Created by Helen Besharatian on 6/22/1402 AP.
//

import UIKit

class MapVC: UIViewController {
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
    
    func showYesNoNotification() {
            let alertController = UIAlertController(title: "Notification", message: "Do you want to add your companies?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
                // Handle "Yes" button action you should pass the view to travelVC
                
                
            }
            
            let noAction = UIAlertAction(title: "No", style: .cancel) { (_) in
                // Handle "No" button action
                
            }
            
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            
            present(alertController, animated: true, completion: nil)
    }
        
    @IBAction func searchingForDestination(_ sender: Any) {
        
        
    }
    
    func loadMap(){
        
        mapview = NTMapView(frame: mapUIV.bounds)
        guard let unwrappedMapView = mapview else {
            print("Map does not load")
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

        mapUIV.addSubview(unwrappedMapView)
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


