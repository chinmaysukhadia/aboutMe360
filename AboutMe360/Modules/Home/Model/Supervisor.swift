//
//	Supervisor.swift

import Foundation 
import ObjectMapper


class Supervisor : NSObject, NSCoding, Mappable{

	var quest : String?
	var rating : String?


	class func newInstance(map: Map) -> Mappable?{
		return Supervisor()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		quest <- map["quest"]
		rating <- map["rating"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         quest = aDecoder.decodeObject(forKey: "quest") as? String
         rating = aDecoder.decodeObject(forKey: "rating") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if quest != nil{
			aCoder.encode(quest, forKey: "quest")
		}
		if rating != nil{
			aCoder.encode(rating, forKey: "rating")
		}

	}

}
