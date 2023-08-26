//
//  RatingLine.swift
//  Brush
//
//  Created by cxq on 2023/8/16.
//
import Charts
import SwiftUI

struct RatingLine: View {
    private var weightModel = WeightData()
    private let dataPointWidth: CGFloat = 50
    @Namespace var trailingID
    @Namespace var leadingID
    
    let gradient = LinearGradient(gradient: Gradient(colors: [.primary.opacity(0.6), .primary.opacity(0.5), .primary.opacity(0.2), .primary.opacity(0.02)]), startPoint: .top, endPoint: .bottom)
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            let weight = weightModel.allWeights!

            ScrollViewReader { scrollViewProxy in
                ScrollView(.horizontal) {
                    HStack {
                        Image(systemName: "arrow.right")
                            .id(leadingID)
                            .onTapGesture {
                                scrollViewProxy.scrollTo(trailingID)
                            }.padding(.leading)
                        Chart {
                            ForEach(weight, id: \.id) { item in
                                let x = item.day
                                let y = item.score - 100
                                LineMark(
                                    x: .value("day", x),
                                    y: .value("score", y)
                                ).interpolationMethod(.catmullRom)
                                    .lineStyle(.init(lineWidth: 3))
                                AreaMark(x: .value("day", x),
                                         y: .value("score", y))
                                .interpolationMethod(.catmullRom)
                                .foregroundStyle(gradient)
                                PointMark(
                                    x: .value("day", x),
                                    y: .value("score", y)
                                ).annotation(position: .top) {
                                    Text("\(y)")
                                        .font(.system(size: 12))
                                        .fontWeight(.bold)
                                        .foregroundColor(.fontGray)
                                }
                            }
                        }
                        .foregroundColor(.primary)
                        .padding(.bottom, 8)
                        .chartYScale(domain: 0...110)
                        .chartYAxis {
                            AxisMarks(position: .trailing)
                        }
                        .chartXAxis {
                            AxisMarks(preset: .extended, position: .bottom, values: .stride(by: .day)) { value in
                                if value.as(Date.self)!.isFirstOfMonth() {
                                    AxisGridLine()
                                        .foregroundStyle(.black.opacity(0.5))
                                    let label = "01\n\(value.as(Date.self)!.monthName())"
                                    AxisValueLabel(label).foregroundStyle(.black)
                                } else {
                                    AxisValueLabel(
                                        format: .dateTime.day(.twoDigits)
                                    )
                                }
                            }
                        }
                        .frame(width: dataPointWidth * CGFloat(weight.count), height: min(width, height))
                        Color.clear.id(trailingID)
                    }
                }.onAppear {
                    scrollViewProxy.scrollTo(trailingID, anchor: .trailing)
                }
            }
        }.background(.white)
    }
}



struct WeightData {
    private(set) var allWeights: [Score]?
    
    static let weightInitial = 180
    static let weightInterval = 2
    static let weightMin = 175
    static let weightMax = 200
    
    init() {
        createWeightData(days: 100)
    }
    
    mutating func createWeightData(days: Int) {
        // Generate sample weight date between 175 and 200 pounds (+ or - 0-3 pounds daily)
        allWeights = []
        var selectedWeight = WeightData.weightInitial
        var add = true
        for interval in 0...days {
            switch selectedWeight {
                case (WeightData.weightMax - WeightData.weightInterval + 1)..<Int.max:
                    add = false
                case 0..<(WeightData.weightMin + WeightData.weightInterval):
                    add = true
                default:
                    add = (Int.random(in: 0...4) == 3) ? !add : add
            }
            
            selectedWeight = add ? selectedWeight + Int.random(in: 0...WeightData.weightInterval) : selectedWeight - Int.random(in: 0...WeightData.weightInterval)
            let selectedDate = Calendar.current.date(byAdding: .day, value: -1 * interval, to: Date())!
            allWeights!.append(Score(date: selectedDate, score: selectedWeight))
        }
    }
}

struct Score: Identifiable {
    let id = UUID()
    let day: Date
    let score: Int
    
    init(date: Date, score: Int) {
        self.day = date
        self.score = score
    }
}

#if DEBUG
struct RatingLine_Previews: PreviewProvider {
    static var previews: some View {
        RatingLine()
    }
}
#endif
