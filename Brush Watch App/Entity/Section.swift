//
//  Section.swift
//  Brush Watch App
//
//  Created by cxq on 2023/7/19.
//

import Foundation

enum Section :Identifiable {
    var id: Self {
        return self
    }
    
    case OLB
    case OLT
    case ILB
    case ILT
    case ORB
    case ORT
    case IRB
    case IRT
    
    case Finish
}
