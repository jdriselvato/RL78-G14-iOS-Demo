//
//  Global.swift
//
//  Created by James Wright on 10/15/14.
//  Copyright (c) 2014 James Wright. All rights reserved.
//

import UIKit


// MARK: Observable Properties

public class WeakWrapper<T: AnyObject>: Hashable, Equatable {
    weak var value: T?
    private let objectIdentifier: ObjectIdentifier
    init(_ value: T) {
        self.value = value
        objectIdentifier = ObjectIdentifier(value)
    }
    public var hashValue: Int {
        return objectIdentifier.hashValue
    }
}

public func ==<T>(lhs: WeakWrapper<T>, rhs: WeakWrapper<T>) -> Bool {
    return lhs.hashValue == rhs.hashValue
}


public class Observable<T> {
    public typealias Listener = T -> Void
    public typealias Observer = WeakWrapper<AnyObject>
    
    private var backingValue: T
    private var bindingMap = [Observer : Listener]()
    
    public var value: T {
        get {
            return backingValue
        }
        set {
            backingValue = newValue
            fire(backingValue)
        }
    }
    
    public var observerCount: Int {
        get {
            return bindingMap.count
        }
    }
    
    
    private func fire(v: T) {
        for (_, listener) in bindingMap {
            listener(v)
        }
    }
    
    public func bind(observer: AnyObject, listener: Listener) {
        cullBindings()
        bindingMap[Observer(observer)] = listener
    }
    
    public func bindAndFire(observer: AnyObject, listener: Listener) {
        bind(observer, listener: listener)
        fire(backingValue)
    }
    
    public func unbind(observer: AnyObject) {
        if bindingMap[Observer(observer)] != nil {
            bindingMap[Observer(observer)] = nil
        }
        cullBindings()
    }
    
    public func setWithoutFiring(newValue: T) {
        backingValue = newValue
    }
    
    public init(_ v: T) {
        backingValue = v
    }
    
    
    public func cullBindings() {
        if bindingMap.isEmpty { return }
        let badKeys = Array(bindingMap.keys).filter { $0.value == nil }
        badKeys.forEach {
            self.bindingMap[$0] = nil
        }
    }
    
}