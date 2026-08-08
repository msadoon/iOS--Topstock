public enum SnapshotPeriod: String, CaseIterable {
    case fiveMin
    case oneHour
    
    var description: String {
        switch self {
        case .fiveMin:
            GlobalVars.Text.TimeLine.fiveMinPeriod.rawValue
        case .oneHour:
            GlobalVars.Text.TimeLine.oneHourPeriod.rawValue
        }
    }
}
