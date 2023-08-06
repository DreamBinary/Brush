//
//  SectionUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/7/19.
//

import Foundation

enum Section :String, Identifiable {
    var id: Self {
        return self
    }
    case ORT = "ORT"
    case OLT = "OLT"
    case MRT = "MRT"
    case MLT = "MLT"
    case IRT = "IRT"
    case ILT = "ILT"
    case ORB = "ORB"
    case OLB = "OLB"
    case MRB = "MRB"
    case MLB = "MLB"
    case IRB = "IRB"
    case ILB = "ILB"
    case Finish = "Finish"
}


class SectionUtil {
    static func getName(_ section: Section) -> String {
        switch section {
            case .ORT:
                return "右上颊侧面"
            case .OLT:
                return "左上颊侧面"
            case .MRT:
                return "右上咬合面"
            case .MLT:
                return "左上咬合面"
            case .IRT:
                return "右上舌侧面"
            case .ILT:
                return "左上舌侧面"
            case .ORB:
                return "右下颊侧面"
            case .OLB:
                return "左下颊侧面"
            case .MRB:
                return "右下咬合面"
            case .MLB:
                return "左下咬合面"
            case .IRB:
                return "右下舌侧面"
            case .ILB:
                return "左下舌侧面"
            case .Finish:
                return "完成"
        }
    }
    
    static func getNext(_ section: Section) -> Section {
        switch section {
            case .ORT:
                return .OLT
            case .OLT:
                return .MRT
            case .MRT:
                return .MLT
            case .MLT:
                return .IRT
            case .IRT:
                return .ILT
            case .ILT:
                return .ORB
            case .ORB:
                return .OLB
            case .OLB:
                return .MRB
            case .MRB:
                return .MLB
            case .MLB:
                return .IRB
            case .IRB:
                return .ILB
            case .ILB:
                return .Finish
            case .Finish:
                return .Finish
        }
    }
}
