//
//  ViewController.swift
//  RxSwiftMapDelegateExample
//
//  Created by pham.xuan.tien on 8/20/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    private func configView() {
        mapView.rx.centerDidChange
            .subscribe(onNext: { coordinate in
                print(coordinate)
            })
    }
}
