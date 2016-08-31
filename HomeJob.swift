
import Foundation
import RealmSwift
import ObjectMapper

protocol Meta {
    static func url() -> String
}

class HomeJob: Object, Mappable, Meta {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var title = ""
    dynamic var address = ""
    dynamic var endDate = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //Impl. of Mappable protocol
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
        title <- map["title"]
        name <- map["creator_detail"]
        address <- map["address"]
        endDate <- map["end_date"]
        
    }
    
    //Impl. of Meta protocol
    static func url() -> String {
        return "https://bitbucket.org/hyphe/blog-examples/raw/master/fetchData/demoapi/music"
    }
}

