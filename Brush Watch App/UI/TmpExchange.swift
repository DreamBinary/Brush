////
////  TmpExchange.swift
////  Brush Watch App
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
//        let util = PhoneUtil() { message in
//            if (message["msg"] != nil) {
//                txt = message["msg"] as! String
//            }
//        }
//        VStack {
//            Text("\(txt)")
//            
//            TextField("msg to iphone", text: $msg)
//            
//            Button(action: {
//                util.send2Phone(["msg": msg])
//            }, label: {
//                Text("send")
//            })
//        }.background(.red)
//    }
//}
//
//struct TmpExchange_Previews: PreviewProvider {
//    static var previews: some View {
//        TmpExchange()
//    }
//}
