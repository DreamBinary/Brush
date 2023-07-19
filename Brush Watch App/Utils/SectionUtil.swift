//
//  SectionUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/7/19.
//

import Foundation


class SectionUtil {
    
    static func getName(_ section: Section?) -> String {
        switch section {
            case .OLB:
                return "外左下片区"
            case .OLT:
                return "外左上片区"
            case .ILB:
                return "内左下片区"
            case .ILT:
                return "内左上片区"
            case .ORB:
                return "外右下片区"
            case .ORT:
                return "外右上片区"
            case .IRB:
                return "内右下片区"
            case .IRT:
                return "内右上片区"
            case .none:
                return "完成"
        }
    }
    
    static func getId(_ section: Section) -> String {
        switch section {
            case .OLB:
                return "OLB"
            case .OLT:
                return "OLT"
            case .ILB:
                return "ILB"
            case .ILT:
                return "ILT"
            case .ORB:
                return "ORB"
            case .ORT:
                return "ORT"
            case .IRB:
                return "IRB"
            case .IRT:
                return "IRT"
        }
    }
    
    
    static func getNext(_ section: Section) -> Section? {
        switch section {
            case .OLB:
                return .OLT
            case .OLT:
                return .ILB
            case .ILB:
                return .ILT
            case .ILT:
                return .ORB
            case .ORB:
                return .ORT
            case .ORT:
                return .IRB
            case .IRB:
                return .IRT
            case .IRT:
                return nil
        }
    }
    
    
    
    
    //    static fun getName(section: Section?): String = when (section) {
    //
    //        Section.OLB -> "外左下片区"
    //        Section.OLT -> "外左上片区"
    //        Section.ILB -> "内左下片区"
    //        Section.ILT -> "内左上片区"
    //        Section.ORB -> "外右下片区"
    //        Section.ORT -> "外右上片区"
    //        Section.IRB -> "内右下片区"
    //        Section.IRT -> "内右上片区"
    //        null -> "完成"
    //    }
    //
    //    fun getId(section: Section): Int = when (section) {
    //        Section.OLB -> R.drawable.sec_olb
    //        Section.OLT -> R.drawable.sec_olb
    //        Section.ILB -> R.drawable.sec_olb
    //        Section.ILT -> R.drawable.sec_olb
    //        Section.ORB -> R.drawable.sec_olb
    //        Section.ORT -> R.drawable.sec_olb
    //        Section.IRB -> R.drawable.sec_olb
    //        Section.IRT -> R.drawable.sec_olb
    //    }
    //
    //    // 左右手
    //    fun getNext(section: Section): Section? = when (section) {
    //        Section.OLB -> Section.OLT
    //        Section.OLT -> Section.ILB
    //        Section.ILB -> Section.ILT
    //        Section.ILT -> Section.ORB
    //        Section.ORB -> Section.ORT
    //        Section.ORT -> Section.IRB
    //        Section.IRB -> Section.IRT
    //        Section.IRT -> null
    //    }
    
    
    
}
