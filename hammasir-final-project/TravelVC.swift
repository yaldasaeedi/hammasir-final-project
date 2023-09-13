//
//  TravelVC.swift
//  hammasir-final-project
//
//  Created by Helen Besharatian on 6/22/1402 AP.
//

import UIKit

class TravelVC: UIViewController {

    var travelMapView: NTMapView?
    
    @IBOutlet weak var travelMapUIV: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMap()
        // Do any additional setup after loading the view.
    }
    
    func loadMap(){
        
        travelMapView = NTMapView(frame: travelMapUIV.bounds)
        guard let unwrappedMapView = travelMapView else {
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

        travelMapUIV.addSubview(unwrappedMapView)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
