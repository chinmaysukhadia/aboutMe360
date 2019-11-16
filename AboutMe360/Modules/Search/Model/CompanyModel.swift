//
//	RootClass.swift

import Foundation 
import ObjectMapper


class CompanyModel : NSObject, NSCoding, Mappable{

	var message : String?
	var orgName : [OrgName]?
	var status : String?


	class func newInstance(map: Map) -> Mappable?{
		return CompanyModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		message <- map["message"]
		orgName <- map["org_name"]
		status <- map["status"]
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         message = aDecoder.decodeObject(forKey: "message") as? String
         orgName = aDecoder.decodeObject(forKey: "org_name") as? [OrgName]
         status = aDecoder.decodeObject(forKey: "status") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if orgName != nil{
			aCoder.encode(orgName, forKey: "org_name")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}

	}

}

// MARK: - Attorney Formatted Data
extension CompanyModel {
    
    class func formattedDataArray(data: [[String : AnyObject]]) -> [CompanyModel]? {
        return Mapper<CompanyModel>().mapArray(JSONArray:data)
    }
    
    class func formattedDataDict(data: [String : AnyObject]) -> CompanyModel? {
        return Mapper<CompanyModel>().map(JSON: data)
    }
}
