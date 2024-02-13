//
//  BarChart.swift
//  Targets
//
//  Created by Sferea-Lider on 12/02/24.
//

import SwiftUI
import Charts

struct BarChart: View {
    
    weak var navigationController: UINavigationController?

    let thisYearFirst6Month: [MonthlySales] = [
            .init(date: .createDate(1, 1, 2023), sales: 6000),
            .init(date: .createDate(1, 2, 2023), sales: 4650),
            .init(date: .createDate(1, 3, 2023), sales: 6750),
            .init(date: .createDate(1, 4, 2023), sales: 8550),
            .init(date: .createDate(1, 5, 2023), sales: 5500),
            .init(date: .createDate(1, 6, 2023), sales: 5000),
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Bar Chart Screen")
                    .bold()
                    .font(.system(size: 21.0))
            }
            
            Spacer()
                .frame(width: 1, height: 50, alignment: .bottom)
            
            if #available(iOS 16.0, *) {
                Chart(thisYearFirst6Month, id: \.id) { sale in
                    
                    RuleMark(y: .value("Average", average(thisYearFirst6Month)))
                        .foregroundStyle(.white)
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                        .annotation(alignment: .leading) {
                            Text("Average")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    
                    BarMark(
                        x: .value("Month", sale.month),
                        y: .value("Sales", sale.sales)
                    )
                    .cornerRadius(5)
                    .foregroundStyle(by: .value("Month", sale.month))
                    
                }
                .frame(height: 300)
                .padding()
                .chartPlotStyle(content: { plotContent in
                    plotContent.background(.thinMaterial)
                })
                
                Spacer()
                    .frame(width: 1, height: 50, alignment: .bottom)
                
                VStack(alignment: .center) {
                    Button(action: {
                        navigationController?.popViewController(animated: true)
                    }) {
                        Text("Back")
                            .font(.system(size: 21.0))
                            .bold()
                            .frame(width: UIScreen.main.bounds.width, height: 10, alignment: .center)
                    }
                }
                
            } else {
                Text("Grafica no soportada")
            }
        }.navigationBarHidden(true)
        
    }
    
    func average(_ sales: [MonthlySales]) -> Double {
        var average: Double = 0
        for sale in sales {
            average += sale.sales
        }
        return average / Double(sales.count)
    }

}

#Preview {
    BarChart()
}
