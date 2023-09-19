
import UIKit
import CoreLocation

class MapController: UIViewController, CLLocationManagerDelegate {
    
    var xDestination : Double?
    var yDestination : Double?
    var xOrigin : Double?
    var yOrigin : Double?
    var formattedAddress : String?
    
    var mapView: NTMapView?
    var startingTrip : StartingTripFlowController = StartingTripFlowController()
    var markerLayer: NTVectorElementLayer?
    var userMarkerLayer = NTVectorElementLayer()
    var marker = NTMarker()
    var animSt = NTAnimationStyle()
    var userLocation: CLLocation!
    var locationManager: CLLocationManager!
    
    
    let lastUpdateTime = NSString()
    let mRequestingLocationUpdates = Bool()
    
    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var currentLocationBTN: UIButton!
    @IBOutlet weak var minimizeBTN: UIButton!
    @IBOutlet weak var maximizeBTN: UIButton!
    
    override func viewDidLoad() {
        loadMap()
        initLocation()
        clickForSetingDestination()
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startLocationUpdates()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        stopLocationUpdates()
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
        
      
        markerLayer = NTNeshanServices.createVectorElementLayer()
        unwrappedMapView.getLayers().add(markerLayer)
        userMarkerLayer = NTNeshanServices.createVectorElementLayer()
        unwrappedMapView.getLayers()?.add(userMarkerLayer)
        unwrappedMapView.setFocalPointPosition(NTLngLat(x: 59.2, y: 36.5), durationSeconds: 0.4)
        unwrappedMapView.setZoom(13, durationSeconds: 0.4)
        mapContainerView.addSubview(unwrappedMapView)
        unwrappedMapView.frame = mapContainerView.bounds
        unwrappedMapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    func initLocation() {
        // Create a location manager
        locationManager = CLLocationManager()
        // Set a delegate to receive location callbacks
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        onLocationChanged()
    }
    func startLocationUpdates() {
        // Start the location manager
        locationManager.startUpdatingLocation()
    }
    
    func stopLocationUpdates() {
        // stop the location manager
        locationManager.stopUpdatingLocation()
    }
    
    func onLocationChanged() {
        if userLocation != nil {
            addUserMarker(NTLngLat(x: userLocation.coordinate.longitude, y: userLocation.coordinate.latitude))
            xOrigin = userLocation.coordinate.longitude
            yOrigin = userLocation.coordinate.latitude
        }
    }
    
    func clickForSetingDestination(){
        
        let mapEventListener = MapEventListener()
        mapEventListener?.onMapClickedBlock =  {clickInfo in
            if clickInfo.getClickType() == NTClickType.CLICK_TYPE_LONG {
                let clickedLocation = clickInfo.getClickPos()
                print("clicked")
                print(clickedLocation)
                self.addMarker(loc: clickedLocation!)
                self.xDestination = clickedLocation?.getX()
                self.yDestination = clickedLocation?.getY()
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
    
    func addUserMarker(_ loc: NTLngLat) {
        // Creating marker style. We should use an object of type MarkerStyleCreator, set all features on it
        // and then call buildStyle method on it. This method returns an object of type MarkerStyle
        let markStCr = NTMarkerStyleCreator()
        markStCr?.setSize(30)
        markStCr?.setBitmap(NTBitmapUtils.createBitmap(from: UIImage(named: "ic_marker")))
        let markSt: NTMarkerStyle = markStCr!.buildStyle()
        
        // Creating user marker
        let marker = NTMarker(pos: loc, style: markSt)
        
        // Clearing userMarkerLayer
        userMarkerLayer.clear()
        
        // Adding user marker to userMarkerLayer, or showing marker on map!
        userMarkerLayer.add(marker)
    }
    
    func accessSharedData() {
        TripData.shared.originLng = xOrigin!
        TripData.shared.originLat = yOrigin!
        TripData.shared.destinationLng = xDestination!
        TripData.shared.destinationLat = yDestination!
        //TripData.shared.formattedAddress = formattedAddress!
    }
    @IBAction func focusOnUserLocation(_ sender: Any) {
        
        if userLocation != nil {
            mapView!.setFocalPointPosition(NTLngLat(x: userLocation.coordinate.longitude, y: userLocation.coordinate.latitude), durationSeconds: 0.5)
            mapView!.setZoom(15, durationSeconds: 0.5)
        } else {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
    }
    
    @IBAction func DoneOnClicked(_ sender: Any) {
        
    }
    
    @IBAction func minimizeClicked(_ sender: Any) {
        
    }
    @IBAction func maximizeClicked(_ sender: Any) {
        
    }
}
