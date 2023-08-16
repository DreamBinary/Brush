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
    private let dataPointWidth: CGFloat = 30
    @Namespace var trailingID
    @Namespace var leadingID
    
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
                                LineMark(
                                    x: .value("day", item.day),
                                    y: .value("score", item.score - 150)
                                ).interpolationMethod(.catmullRom)
                                PointMark(
                                    x: .value("day", item.day),
                                    y: .value("score", item.score - 150)
                                )
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
        }.navigationTitle("评分曲线")
            .onAppear {
            AppDelegate.orientationLock = .all // And making sure it stays that way
        }.onDisappear {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation") // Forcing the rotation to portrait
            AppDelegate.orientationLock = .portrait // And making sure it stays that way
        }
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
