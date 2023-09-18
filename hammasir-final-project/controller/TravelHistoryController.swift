
import UIKit

class TravelHistoryController: UIViewController {

    var travelMapView: NTMapView?
    
    @IBOutlet weak var travelMapUIV: UIView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadMap()
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
}
