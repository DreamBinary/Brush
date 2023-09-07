//
//  AggrementView.swift
//  Brush
//
//  Created by 吕嘻嘻 on 2023/8/18.
//

//
//  LoginWay.swift
//  Brush
//
//  Created by cxq on 2023/6/22.
//

import SwiftUI
import PopupView

struct AggrementView: View {
    @Binding var isAgree: Bool
    @State private var fontSize: CGFloat = 13
    @State private var showingPopup: Bool = false
    
    @State private var showUserAgreement: Bool = false
    @State private var showPrivacyPolicy: Bool = false


    private var fontColor: Color {
        return isAgree ? Color(0x263238) : Color(0x9f9f9f, 0.59)
    }

    var body: some View {
        HStack (spacing:0){
            Image(systemName: isAgree ? "checkmark.circle" :"circle").foregroundColor(fontColor)
            
            Text("我已阅读并同意").foregroundColor(fontColor).font(Font.system(size: fontSize))
            Text("TuneBrush用户协议")
                .foregroundColor(fontColor)
                .font(Font.system(size: fontSize))
                .underline(true, color: fontColor)
                .onTapGesture {
                    showUserAgreement=true;
                }
            Text("和")
                .foregroundColor(fontColor)
                .font(Font.system(size: fontSize))
            Text("隐私政策")
                .foregroundColor(fontColor)
                .font(Font.system(size: fontSize))
                .underline(true, color: fontColor)
                .onTapGesture {
                    showPrivacyPolicy=true;
                }
        }.onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                isAgree.toggle()
            }
            showingPopup.toggle()
        }.sheet(isPresented: $showUserAgreement) {
            UserAgreement().presentationDragIndicator(.visible)
        }.sheet(isPresented: $showPrivacyPolicy) {
            PrivacyPolicy().presentationDragIndicator(.visible)
        }
    }
}

struct UserAgreement: View {
    var body: some View {
            VStack(spacing:14){
                VStack(spacing:14){
                    TitleText(text:"TuneBrush 用户协议")
                    
                    ContentText(subTitle:"生效时间",content:"2023年9月1日")
                    Text("\t欢迎使用TuneBrush应用！在使用本应用之前，请仔细阅读以下用户协议。通过使用TuneBrush应用，即表示您同意遵守以下规定。如果您不同意以下条款，请勿使用本应用。").font(.system(size: 14))
                }
                ContentText(subTitle:"隐私政策",content:"请注意，您的个人数据将根据我们的隐私政策进行处理。我们会通过HTTPS协议将数据存储在云端数据库中，以确保您的数据安全。请在使用本应用之前，详细阅读我们的隐私政策以获取更多信息。")
                ContentText(subTitle:"数据收集与使用",content:"TuneBrush应用通过Apple Watch获取用户刷牙速度以及习惯信息，以提供科学规范的刷牙建议。这些数据将被加密并存储在云端数据库中，用于分析和改进应用性能。我们承诺不会向第三方出售或分享您的个人数据。")
                ContentText(subTitle:"科学依据",content:"我们理解不同用户具有不同的口腔健康需求。TuneBrush应用提供了个性化设置选项，允许您根据个人需求调整刷牙节奏和震动模式，以便获得最佳效果。")
                ContentText(subTitle:"个性化设置",content:"TuneBrush应用的刷牙节奏和震动模式基于牙科医学建议和相关科学研究。我们的团队与专业牙科医生合作，以确保提供的刷牙建议具有科学性和可靠性。")
                ContentText(subTitle:"免责声明",content:"尽管TuneBrush应用旨在帮助用户改善刷牙习惯，但最终的刷牙效果仍可能因个人因素而异。我们不能保证应用所提供的刷牙建议对所有用户都适用。在使用本应用的同时，请继续定期就诊牙科医生，以确保您的口腔健康。")
                ContentText(subTitle:"知识产权",content:"TuneBrush应用中的所有音乐、设计和内容的知识产权归TuneBrush团队所有。未经授权，您不得复制、修改、传播或用于商业目的。")
                ContentText(subTitle:"联系我们",content:"如果您有任何问题、意见、建议或疑虑，请随时通过tunebrush@shawnxixi.icu与我们联系。")
                Text("通过使用TuneBrush应用，您同意并遵守以上条款。我们保留随时更新用户协议的权利，更新后的条款将在本页面公布。请定期查阅以获取最新信息。").font(.system(size: 14))
                HStack{
                    Spacer()
                    Text("TuneBrush团队").font(.system(size: 20)).bold()
                }
                
            }.frame(width: UIScreen.main.bounds.width*0.9,height: UIScreen.main.bounds.height)
    }
}

struct PrivacyPolicy: View {
    var body: some View {
        VStack(spacing:14){
            VStack(spacing:14){
                TitleText(text:"TuneBrush 隐私政策")
                
                ContentText(subTitle:"生效时间",content:"2023年9月1日")
                Text("\t欢迎使用 TuneBrush 应用！本隐私政策旨在向您解释我们如何收集、使用、保护和处理您的个人信息。请在使用本应用之前仔细阅读本隐私政策。").font(.system(size: 14))
            }
            VStack(alignment:.leading,spacing:8){
                SubtitleText(text:"1. 数据收集与使用")
                ContentText(subTitle:"1.1 刷牙数据",content:"在您使用 TuneBrush 应用时，我们会通过 Apple Watch 收集您的刷牙速度和习惯数据。这些数据将被加密并匿名存储在云端数据库中，用于为您提供科学规范的刷牙建议。")
                ContentText(subTitle:"1.2 隐私安全",content:"我们通过使用安全的 HTTPS 协议来传输您的数据，以确保数据在传输过程中的保密性和完整性。")
            }
            
            VStack(alignment:.leading,spacing:8){
                SubtitleText(text:"2. 数据保护与存储")
                ContentText(subTitle:"2.1 数据安全",content:"我们采取适当的技术和组织措施来保护您的数据免遭未经授权的访问、使用或披露。")
                ContentText(subTitle:"2.2 数据存储期限",content:"您的数据将保留在我们的云端数据库中，以确保应用的正常运作。如果您决定停止使用 TuneBrush 应用，您的数据将会在合理的时间内被删除。")
            }
            
            VStack(alignment:.leading,spacing:8){
                SubtitleText(text:"4. 隐私政策变更与通知")
                Text("我们可能会不定期更新本隐私政策，以反映我们的实践和法律要求。我们会通过在应用内或其他适当方式通知您有关重大变更的信息。").font(.system(size: 14))
            }
            
            VStack(alignment:.leading,spacing:8){
                SubtitleText(text:"5. 联系我们")
                Text("如果您有关于本隐私政策、数据处理或其他隐私问题的任何疑问，请随时通过tunebrush@shawnxixi.icu与我们联系。").font(.system(size: 14))
            }
   
            Text("通过使用 TuneBrush 应用，即表示您同意并理解本隐私政策所述的信息处理方式。我们承诺持续保护您的隐私和个人信息。").font(.system(size: 14))
            HStack{
                Spacer()
                Text("TuneBrush团队").font(.system(size: 20)).bold()
            }
            
        }.frame(width: UIScreen.main.bounds.width*0.9,height: UIScreen.main.bounds.height)
    }
}

struct TitleText:View{
    var text:String = "text"
    var body: some View{
        Text(text).font(.title).bold()
    }
}
struct SubtitleText:View{
    var text:String = "text"
    var body: some View{
        Text(text).font(.system(size: 14)).bold()
    }
}


struct ContentText:View{
    var subTitle:String = "subtitle"
    var content:String = "content"
    var body: some View{
        Text(subTitle+":").font(.system(size: 14)).bold()  + Text(content).font(.system(size: 14))
    }
}

// 把这个用户协议在swiftui中写出来 生效日期写9月1日 最外围用一个hstack 需要有段落 段落标题需要加粗 尽可能复用样式
struct UserAgreement_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicy()
    }
}


