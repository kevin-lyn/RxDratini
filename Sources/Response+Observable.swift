//
//  Response+Observable.swift
//  RxDratini
//
//  Created by Kevin Lin on 30/7/17.
//
//

import Foundation
import Dratini
import RxSwift

private class ObserverOwner {
}

extension Response {
    public static func asObservable(in requestQueue: RequestQueue) -> Observable<Self> {
        return Observable.create { observer -> Disposable in
            let observerOwner = ObserverOwner()
            requestQueue.addObserver(ownedBy: observerOwner) { (result: Result<Self>) in
                switch result {
                case .success(let response):
                    observer.onNext(response)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                requestQueue.removeObservers(forType: self, ownedBy: observerOwner)
            }
        }
    }
}
