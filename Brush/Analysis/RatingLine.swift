//
//  RatingLine.swift
//  Brush
//
//  Created by cxq on 2023/8/16.
//
import Charts
import SwiftUI

struct ScorePoint: Identifiable, Codable, Equatable {
    let id: Int
    let brushTime: Date
    let totalScore: Int
}

struct RatingLine: View {
    var scoreList: [ScorePoint] = []
    private let dataPointWidth: CGFloat = 50
    @Namespace var trailingID
    //    @Namespace var leadingID

    let gradient = LinearGradient(gradient: Gradient(colors: [.primary.opacity(0.6), .primary.opacity(0.5), .primary.opacity(0.2), .primary.opacity(0.02)]), startPoint: .top, endPoint: .bottom)
    var body: some View {
        GeometryReader { geo in
            let height = geo.size.height
            ScrollViewReader { scrollViewProxy in
                Spacer(minLength: 0)
                ScrollView(.horizontal) {
                    HStack {
                        //                        Image(systemName: "arrow.right")
                        //                            .id(leadingID)
                        //                            .onTapGesture {
                        //                                scrollViewProxy.scrollTo(trailingID)
                        //                            }.padding(.leading)
                        Spacer(minLength: 8)
                        Chart {
                            ForEach(scoreList.indices, id: \.self) { index in
                                let x = scoreList[index].brushTime
                                let y = scoreList[index].totalScore
                                LineMark(
                                    x: .value("time", x),
                                    y: .value("score", y)
                                ).interpolationMethod(.catmullRom)
                                    .lineStyle(.init(lineWidth: 3))
                                AreaMark(x: .value("time", x),
                                         y: .value("score", y))
                                    .interpolationMethod(.catmullRom)
                                    .foregroundStyle(gradient)
                                PointMark(
                                    x: .value("time", x),
                                    y: .value("score", y)
                                ).annotation(position: .top) {
                                    Text("\(y)")
                                        .font(.system(size: 12))
                                        .fontWeight(.bold)
                                        .foregroundColor(.fontGray)
                                }

                                PointMark(
                                    x: .value("time", x),
                                    y: .value("score", 40)
                                ).symbolSize(10)
                                    .annotation(position: .bottom) {
                                        Group {
                                            if (index > 1 && x.dayNum() != scoreList[index - 1].brushTime.dayNum()) || index == 0 {
                                                Text("\(x.time())\n\(x.dayNum())")
                                            } else {
                                                Text(x.time())
                                            }
                                        }.font(.system(size: 10))
                                            .fontWeight(.medium)
                                            .foregroundColor(.fontBlack)
                                    }
                            }
                        }
                        .foregroundColor(.primary)
                        .padding(.bottom)
                        .chartYScale(domain: 40 ... 110)
                        .chartYAxis {
                            AxisMarks(position: .trailing)
                        }
                        .chartXAxis {
                            //                            AxisMarks(preset: .extended, position: .bottom) { value in
                            //                                let label = value.as(Date.self)!.time()
                            //                                AxisValueLabel(label).foregroundStyle(.black)
                            //                            }
                        }
                        .frame(width: dataPointWidth * CGFloat(scoreList.count), height: height)
                        Color.clear.id(trailingID)
                    }
                }.onAppear {
                    scrollViewProxy.scrollTo(trailingID, anchor: .trailing)
                }
            }
        }
            .background(.white)
    }
}

#if DEBUG
struct RatingLine_Previews: PreviewProvider {
    static var previews: some View {
        RatingLine()
    }
}
#endif
