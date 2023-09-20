
import UIKit
import CoreLocation

class MapController: UIViewController, CLLocationManagerDelegate {
    
    private var xDestination : Double = 0.0
    private var yDestination : Double = 0.0
    private var xOrigin : Double = 0.0
    private var yOrigin : Double = 0.0
    private var formattedAddress : String?
    
    private var APIRequestForFormatedAddress : APIrequest = APIrequest()
    private var startingTrip : StartingTripFlowController = StartingTripFlowController()
    private var markerLayer: NTVectorElementLayer?
    private var userMarkerLayer = NTVectorElementLayer()
    private var marker = NTMarker()
    private var animSt = NTAnimationStyle()
    private var mapView: NTMapView?
    private let lastUpdateTime = NSString()
    //let mRequestingLocationUpdates = Bool()
    
    private var userLocation: CLLocation!
    private var locationManager: CLLocationManager!
    private var zoomNumber : Float = 13
    
    
    
    
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
        unwrappedMapView.setZoom(zoomNumber, durationSeconds: 0.4)
        mapContainerView.addSubview(unwrappedMapView)
        unwrappedMapView.frame = mapContainerView.bounds
        unwrappedMapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    func initLocation() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        userLocation = locations.last
        onLocationChanged()
    }
    func startLocationUpdates() {
        
        locationManager.startUpdatingLocation()
    }
    
    func stopLocationUpdates() {
        
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
                self.addMarker(loc: clickedLocation!)
                self.xDestination = (clickedLocation?.getX())!
                self.yDestination = (clickedLocation?.getY())!
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
        
        let markStCr = NTMarkerStyleCreator()
        markStCr?.setSize(30)
        markStCr?.setBitmap(NTBitmapUtils.createBitmap(from: UIImage(named: "ic_marker")))
        let markSt: NTMarkerStyle = markStCr!.buildStyle()
        
        let marker = NTMarker(pos: loc, style: markSt)
        
        userMarkerLayer.clear()
        
        userMarkerLayer.add(marker)
    }
    
    func accessSharedData() {

        TripData.shared.originLng = xOrigin
        TripData.shared.originLat = yOrigin
        TripData.shared.destinationLng = xDestination
        TripData.shared.destinationLat = yDestination

        APIRequestForFormatedAddress.getTheAddress(latitude: xOrigin, longitude: yOrigin) { address in
            if let address = address {
                
                print("Formatted Address (Origin): \(address)")
                TripData.shared.originFormattedAddress = address
            } else {
                print("Failed to retrieve the origin address.")
            }
        }

        APIRequestForFormatedAddress.getTheAddress(latitude: xDestination, longitude: yDestination) { address in
            if let address = address {
                
                print("Formatted Address (Destination): \(address)")
                TripData.shared.destinationFormattedAddress = address
            } else {
                print("Failed to retrieve the destination address.")
            }
        }
//        print(tempFormattedAdrressForOrigin)
//        print(tempFormattedAdrressForDestination)

       
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
        
        self.accessSharedData()
        startingTrip.showNameInputNotification(on: self)
    }
    
    @IBAction func minimizeClicked(_ sender: Any) {
        
        if zoomNumber > 1 {
            
            zoomNumber -= 1
            mapView?.setZoom(zoomNumber, durationSeconds: 0.4)
        }
    }

    @IBAction func maximizeClicked(_ sender: Any) {
        
        if zoomNumber < 20 {
            
            zoomNumber += 1
            mapView?.setZoom(zoomNumber, durationSeconds: 0.4)
        }
    }
}
