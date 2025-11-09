import Foundation

class Utilities {
    static let shared = Utilities()
    
    func loadJson<T: Decodable>(filename fileName: String) -> [T] where T: Identifiable {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([T].self, from: data)
                
                return decodedData
            } catch {
                print("error:\(error)")
            }
        }
        
        return []
    }
}
