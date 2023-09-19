
import UIKit
import CoreLocation

class MapController: UIViewController {
    
    var mapView: NTMapView?
    var startingTrip : StartingTripFlowController = StartingTripFlowController()
    var markerLayer: NTVectorElementLayer?
    var marker = NTMarker()
    var animSt = NTAnimationStyle()
   
    private let UPDATE_INTERVAL_IN_MILISECONDS = 1000
    private let FASTEST_UPDATE_INTERVAL_IN_MILISECONDS = 1000

    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var currentLocationBTN: UIButton!
    @IBOutlet weak var minimizeBTN: UIButton!
    @IBOutlet weak var maximizeBTN: UIButton!
    
    override func viewDidLoad() {
        loadMap()
        clickForSetingDestination()
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
        
//        let neshan2 = NTNeshanServices.createTrafficLayer()
//        unwrappedMapView.getLayers().add(neshan2)
//
//        let neshan3 = NTNeshanServices.createPOILayer(false)
//        unwrappedMapView.getLayers().add(neshan3)
        
        markerLayer = NTNeshanServices.createVectorElementLayer()
        unwrappedMapView.getLayers().add(markerLayer)
    
        unwrappedMapView.setFocalPointPosition(NTLngLat(x: 59.2, y: 36.5), durationSeconds: 0.4)
        unwrappedMapView.setZoom(13, durationSeconds: 0.4)
        mapContainerView.addSubview(unwrappedMapView)
        unwrappedMapView.frame = mapContainerView.bounds
        unwrappedMapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
   
    func getUserCurrentLocation(){
        
    }
    func clickForSetingDestination(){
        
        let mapEventListener = MapEventListener()
        mapEventListener?.onMapClickedBlock =  {clickInfo in
            if clickInfo.getClickType() == NTClickType.CLICK_TYPE_LONG {
                let clickedLocation = clickInfo.getClickPos()
                print("clicked")
                print(clickedLocation)
                self.addMarker(loc: clickedLocation!)

            }
        }
        mapView?.setMapEventListener(mapEventListener)
        
    }
    
    func addMarker(loc: NTLngLat) {
        
        guard let layer = self.markerLayer else {
            
            return
        }
        layer.clear()

        let animStB1 = NTAnimationStyleBuilder()
        animStB1?.setFade(NTAnimationType.ANIMATION_TYPE_SMOOTHSTEP)
        animStB1?.setSizeAnimationType(NTAnimationType.ANIMATION_TYPE_SPRING)
        animStB1?.setPhaseInDuration(0.5)
        animStB1?.setPhaseOutDuration(0.5)
        animSt = animStB1!.buildStyle()
        
        let markStCr = NTMarkerStyleCreator()
        markStCr?.setSize(30)
        markStCr?.setBitmap(NTBitmapUtils.createBitmap(from: UIImage(named: "ic_marker")))
        markStCr?.setAnimationStyle(animSt)
        var markSt = NTMarkerStyle()
        markSt = markStCr!.buildStyle()
        
        marker = NTMarker(pos: loc, style: markSt)
        
        layer.add(marker)
        
        let vectorElementEventListener = VectorElementClickedListener()
        vectorElementEventListener?.onVectorElementClickedBlock = {clickInfo in
            if clickInfo.getClickType() == NTClickType.CLICK_TYPE_DOUBLE {
                
                layer.remove(clickInfo.getVectorElement())
            }
            
            return true
        }
        
        layer.setVectorElementEventListener(vectorElementEventListener)
    }
    
    
}
