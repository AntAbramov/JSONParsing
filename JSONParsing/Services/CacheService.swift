import UIKit

class CacheService {
    
    private var cache = NSCache<NSString, CompanyStructHolder>()
    
    private class CompanyStructHolder {
        let value: Company
        init(value: Company) {
            self.value = value
        }
    }
    
    func fetchModel(for key: String) -> Company? {
        if let holder = cache.object(forKey: key as NSString) {
            return holder.value
        }
        return nil
    }
    
    func cache(model: Company, for key: String) {
        cache.setObject(CompanyStructHolder(value: model), forKey: key as NSString)
    }
    
    func emptyCache() {
        cache.removeAllObjects()
    }
    
}
