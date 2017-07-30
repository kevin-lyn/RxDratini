//
//  Request+Observable.swift
//  RxDratini
//
//  Created by Kevin Lin on 30/7/17.
//
//

import Foundation
import Dratini
import RxSwift

extension Request {
    public func asObservable(in requestQueue: RequestQueue) -> Observable<Self.ResponseType> {
        return Observable.create { observer -> Disposable in
            let requestID = requestQueue.add(self)
            requestQueue.addObserver(for: requestID) { (result: Result<Self.ResponseType>) in
                switch result {
                case .success(let response):
                    observer.onNext(response)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                requestQueue.cancel(requestID)
            }
        }
    }
}
