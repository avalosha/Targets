//
//  LineChart.swift
//  Targets
//
//  Created by Sferea-Lider on 12/02/24.
//

import SwiftUI
import Charts

struct LineChart: View {
    
    weak var navigationController: UINavigationController?
    
    private let lastYearFirst6Month: [MonthlySales] = [
        .init(date: .createDate(1, 1, 2022), sales: 2950),
        .init(date: .createDate(1, 2, 2022), sales: 4700),
        .init(date: .createDate(1, 3, 2022), sales: 2750),
        .init(date: .createDate(1, 4, 2022), sales: 1500),
        .init(date: .createDate(1, 5, 2022), sales: 5540),
        .init(date: .createDate(1, 6, 2022), sales: 7000),
    ]
    
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
                Text("Line Chart Screen")
                    .bold()
                    .font(.system(size: 21.0))
            }
            
            Spacer()
                .frame(width: 1, height: 50, alignment: .bottom)
            
            if #available(iOS 17.0, *) {
                Chart(thisYearFirst6Month + lastYearFirst6Month, id: \.id) { sale in
                    LineMark(
                        x: .value("Month", sale.month),
                        y: .value("Sales", sale.sales)
                    )
                    .foregroundStyle(by: .value("Year", sale.year))
                    
                    PointMark(
                        x: .value("Month", sale.month),
                        y: .value("Costs", sale.sales)
                    )
                    .foregroundStyle(by: .value("Year", sale.year))
                    .annotation(position: .overlay, alignment: .bottom, spacing: 10) {
                        Text("\(Int(sale.sales))")
                            .font(.caption)
                    }
                    
                }
                .frame(height: 300)
                .padding()
                
            } else {
                Text("Grafica no soportada")
            }

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
        }.navigationBarHidden(true)
    }
}

#Preview {
    LineChart()
}
