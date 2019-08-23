//
//  RxMKMapViewDelegateProxy.swift
//  RxSwiftMapDelegateExample
//
//  Created by pham.xuan.tien on 8/21/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import RxSwift
import RxCocoa
import MapKit

final class RxMKMapViewDelegateProxy: DelegateProxy<MKMapView, MKMapViewDelegate>, MKMapViewDelegate, DelegateProxyType {

    /// Typed parent object.
    public weak private(set) var mapView: MKMapView?

    /// - parameter mapView: Parent object for delegate proxy.
    public init(mapView: ParentObject) {
        self.mapView = mapView
        super.init(parentObject: mapView, delegateProxy: RxMKMapViewDelegateProxy.self)
    }

    /// Factory method
    static func registerKnownImplementations() {
        self.register { RxMKMapViewDelegateProxy(mapView: $0) }
    }

    /// Getter for delegate proxy
    static func currentDelegate(for object: MKMapView) -> MKMapViewDelegate? {
        let mapView: MKMapView = object
        return mapView.delegate
    }

    /// Setter for delegate proxy
    static func setCurrentDelegate(_ delegate: MKMapViewDelegate?, to object: MKMapView) {
        let mapView: MKMapView = object
        mapView.delegate = delegate
    }
}
