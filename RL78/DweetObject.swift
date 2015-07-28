//
//  DweetObject.swift
//  rn78
//
//  Created by John on 7/27/15.
//  Copyright (c) 2015 Flare Labs. All rights reserved.
//

import Foundation

struct DweetObject {
    let by: String
    let this: String
    let thing: String
    let content: ContentObject
    
    static func emptyDweet() -> DweetObject {
        return DweetObject(by: " ", this: " ", thing: " ", content: ContentObject.emptyContent())
    }
    
    static func dweet(json: JSON) -> DweetObject {
        let by = json["by"].stringValue
        let this = json["this"].stringValue
        let thing = json["with"][0]["thing"].stringValue
        let content = ContentObject.content(json)
        
        return DweetObject(by: by, this: this, thing: thing, content: content)
    }
    
    static func dweet(dweetObject: DweetObject) -> Dictionary<String, String> {
        var dictionary =  Dictionary<String, String>()
        
        let content = dweetObject.content
        
        dictionary = [
            "by" : dweetObject.by,
            "this" : dweetObject.this,
            "thing" : dweetObject.thing,
            "temperature" : content.temperature,
            "light" : content.light,
            "potentiometer": content.potentiometer,
            "button_1" : content.button_1,
            "button_2" : content.button_2,
            "button_3" : content.button_3,
            "tilt_z" : content.tilt_z,
            "tilt_x" : content.tilt_x,
            "tilt_y" : content.tilt_y,
        ]
        
        return dictionary
    }
}

struct ContentObject {
    let temperature: String
    let light: String
    let potentiometer: String
    
    let button_1: String
    let button_2: String
    let button_3: String

    let tilt_z: String
    let tilt_y: String
    let tilt_x: String
    
    static func emptyContent() -> ContentObject {
        return ContentObject(temperature: "", light: "", potentiometer: "", button_1: "", button_2: "", button_3: "", tilt_z: "", tilt_y: "", tilt_x: "")
    }
    
    static func content(json: JSON) -> ContentObject {
        let content = json["with"][0]["content"]
        
        let temperature = content["Temperature"].stringValue
        let light = content["Light"].stringValue
        let potentiometer = content["Potentiometer"].stringValue
        
        let button_1 = content["Button_1"].stringValue
        let button_2 = content["Button_2"].stringValue
        let button_3 = content["Button_3"].stringValue
        
        let tilt_z = content["Tilt_Z"].stringValue
        let tilt_y = content["Tilt_Y"].stringValue
        let tilt_x = content["Tilt_X"].stringValue
        
        return ContentObject(temperature: temperature, light: light, potentiometer: potentiometer, button_1: button_1, button_2: button_2, button_3: button_3, tilt_z: tilt_z, tilt_y: tilt_y, tilt_x: tilt_x)
    }
    
}