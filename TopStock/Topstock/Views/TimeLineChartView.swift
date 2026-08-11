import SwiftUI
import Charts
import SwiftData

struct TimeLineChartView: View {
    private var historicalBarsViewModel: HistoricalBarsViewModel
    private var pointMarkXTitle: String {
        GlobalVars.HistoricalBars.AxisTitles.timeFrame.rawValue.localizedUppercase
    }
    
    private var pointMarkYTitle: String {
        GlobalVars.HistoricalBars.AxisTitles.value.rawValue.localizedUppercase
    }
    
    private var gainerGraph: Bool
    @Binding private var timeFrame: SnapshotPeriod
    
    init(networking: TopStockAPI,
         for security: Security,
         in timeFrame: Binding<SnapshotPeriod>) {
        self.historicalBarsViewModel = HistoricalBarsViewModel(networking: networking,
                                                               for: security.symbol)
        self._timeFrame = timeFrame
        self.gainerGraph = security.percentChange >= 0
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Chart(self.historicalBarsViewModel.candlesticks, id: \.timestamp) { candlestick in
                    LineMark(x:
                            .value(self.pointMarkXTitle, candlestick.timestamp),
                              y:
                            .value(self.pointMarkYTitle, candlestick.closePrice))
                   .foregroundStyle(self.gainerGraph ? .green : .red)
            }
            .chartScrollableAxes(.horizontal)
            .overlay(alignment: .topLeading) {
                Text("USD")
                    .bold()
                    .padding(.top, 4)
                    .padding(.leading, 8)
                    .allowsHitTesting(false)
            }
            .chartYAxis {
                AxisMarks { value in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel {
                        if let number = value.as(Double.self) {
                          Text(number, format: .number.precision(.fractionLength(0)))
                        }
                    }
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .hour, count: 1)) { value in
                    if let date = value.as(Date.self) {
                        let hour = Calendar.autoupdatingCurrent.component(.hour, from: date)
                        AxisValueLabel(collisionResolution: .disabled, offsetsMarks: true) {
                            VStack(alignment: .leading, spacing: 0) {
                                switch (value.index, hour) {
                                case (_, 12):
                                    Text(date, format:  .dateTime.hour())
                                case (0, _):
                                    Text(date, format:  .dateTime.hour())
                                    
                                    Text(date, format: .dateTime.month().day())
                                default:
                                    Text(date, format:  .dateTime.hour(.defaultDigits(amPM: .omitted)))
                                }
                            }
                            .fixedSize(horizontal: true, vertical: false)
                            .lineLimit(nil)
                            .minimumScaleFactor(0.8)
                        }
                        
                        if value.index == 0 {
                            AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
                            AxisTick(stroke: StrokeStyle(lineWidth: 0.5))
                        } else {
                            AxisGridLine()
                            AxisTick()
                        }
                    }
                }
            }
            .bold()
            .aspectRatio(1, contentMode: .fit)
            
        }
        .padding()
        .background(
            .regularMaterial
                .shadow(.drop(color: .black.opacity(0.08), radius: GlobalVars.Shadow.smallRadius.rawValue, x: -GlobalVars.Shadow.smallRadius.rawValue, y: GlobalVars.Shadow.smallRadius.rawValue))
                .shadow(.drop(color: .black.opacity(0.06), radius: GlobalVars.Shadow.smallRadius.rawValue, x: -GlobalVars.Shadow.smallRadius.rawValue, y: GlobalVars.Shadow.smallRadius.rawValue)),
            in: .rect(cornerRadius: GlobalVars.Corners.largeRadius.rawValue)
        )
        .onChange(of: self.timeFrame) { _, newValue in
            Task { @MainActor
                let _ = await self.historicalBarsViewModel.getHistoricalBars(for: newValue)
            }
        }
        .onAppear {
            Task { @MainActor
                let _ = await self.historicalBarsViewModel.getHistoricalBars(for: self.timeFrame)
            }
        }
    }
}

