//
//  MapM.swift
//  hammasir-final-project
//
//  Created by Helen Besharatian on 6/22/1402 AP.
//

import Foundation

class MapM {
    
    func loadMap( mapView : NTMapView ) -> NTMapView {
        
        let neshan = NTNeshanServices.createBaseMap(NTNeshanMapStyle.NESHAN)
        mapView.getLayers().add(neshan)

        let neshan2 = NTNeshanServices.createTrafficLayer()
        mapView.getLayers().add(neshan2)

        let neshan3 = NTNeshanServices.createPOILayer(false)
        mapView.getLayers().add(neshan3)

        mapView.setFocalPointPosition(NTLngLat(x: 59.2, y: 36.5), durationSeconds: 0.4)
        mapView.setZoom(13, durationSeconds: 0.4)
        
        return mapView

    }

    
    
}
