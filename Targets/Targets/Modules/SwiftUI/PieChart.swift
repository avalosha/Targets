//
//  PieChart.swift
//  Targets
//
//  Created by Sferea-Lider on 12/02/24.
//

import SwiftUI
import Charts

struct PieChart: View {
    
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
                Text("Pie Chart Screen")
                    .bold()
                    .font(.system(size: 21.0))
            }
            
            Spacer()
                .frame(width: 1, height: 50, alignment: .bottom)
            
            if #available(iOS 17.0, *) {
                Chart(thisYearFirst6Month.sorted(by: { $0.sales > $1.sales }), id: \.id) { sale in
                    SectorMark(angle: .value("Sales", sale.sales), angularInset: 1)
                        .cornerRadius(5)
                        .foregroundStyle(by: .value("Month", sale.month))
                }
                .chartLegend(position: .bottom, alignment: .center, spacing: 25)
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
    PieChart()
}
