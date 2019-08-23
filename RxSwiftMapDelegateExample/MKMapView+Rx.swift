//
//  MKMapView+Rx.swift
//  RxSwiftMapDelegateExample
//
//  Created by pham.xuan.tien on 8/21/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import RxSwift
import RxCocoa
import MapKit

extension Reactive where Base: MKMapView {
    /// Reactive wrapper for `delegate`.
    var delegate: DelegateProxy<MKMapView, MKMapViewDelegate> {
        return RxMKMapViewDelegateProxy.proxy(for: base)
    }

    var regionDidChangeAnimated: ControlEvent<Bool> {
        let source = delegate
            .methodInvoked(#selector(MKMapViewDelegate.mapView(_:regionDidChangeAnimated:)))
            .map { annotation in
                return try castOrThrow(Bool.self, annotation[1])
        }
        return ControlEvent(events: source)
    }

    var centerDidChange: Observable<CLLocationCoordinate2D> {
        return regionDidChangeAnimated
            .map { [base] _ in base.centerCoordinate }
            .startWith(base.centerCoordinate)
    }
}

func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return returnValue
}
