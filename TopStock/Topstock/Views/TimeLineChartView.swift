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
    
    @Binding private var timeFrame: SnapshotPeriod
    
    init(networking: TopStockAPI,
         for symbol: String,
         in timeFrame: Binding<SnapshotPeriod>) {
        self.historicalBarsViewModel = HistoricalBarsViewModel(networking: networking,
                                                               for: symbol)
        self._timeFrame = timeFrame
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Chart(self.historicalBarsViewModel.candlesticks) { candlestick in
                    PointMark(x:
                            .value(self.pointMarkXTitle, candlestick.time),
                              y:
                            .value(self.pointMarkYTitle, candlestick.closePrice))
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartXAxisLabel(GlobalVars.HistoricalBars.AxisTitles.timeFrame.rawValue.localizedUppercase)
            .chartYAxisLabel(GlobalVars.HistoricalBars.AxisTitles.value.rawValue.localizedUppercase)
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
