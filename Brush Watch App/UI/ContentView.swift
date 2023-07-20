//
//  ContentView.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/20.
//

import SwiftUI

struct ContentView: View {
                    
    var body: some View {
        
        RemedyIng(.OLB)
        
//        TabView {
////            ConnectEar()
////            Start()
////            SectionPre(.OLB)
////            SectionIng(.OLB)
////            SectionEd()
////            Tip()
////            Score()
////            RemedySelect()
////            RemedyIng()
////            Finished()
//            Start()
//            ForEach(SectionUtil.sections) { section in
//                SectionPre(section)
//                SectionIng(section)
//                SectionEd(section)
//            }
//        }.tabViewStyle(.page(indexDisplayMode: .never))
//            .edgesIgnoringSafeArea(.all)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
