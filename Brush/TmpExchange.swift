////
////  TmpExchange.swift
////  Brush
////
////  Created by cxq on 2023/8/4.
////
//
//import SwiftUI
//
//struct TmpExchange: View {
//    @State var txt: String = "Hello World"
//    @State var msg: String = ""
//    
//    var body: some View {
//        let util = WatchUtil() { message in
//            if (message["msg"] != nil) {
//                txt = message["msg"] as! String
//            }
//        }
//        VStack {
//            Text("\(txt)")
//            
//            TextField("msg to watch", text: $msg)
//            
//            Button(action: {
//                util.send2Watch(["msg": msg, "start": true])
//            }, label: {
//                Text("send")
//                
//            })
//        }.background(.white)
//    }
//}
//
//struct TmpExchange_Previews: PreviewProvider {
//    static var previews: some View {
//        TmpExchange()
//    }
//}
