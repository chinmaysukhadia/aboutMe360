//
//	Data.swift

import Foundation 
import ObjectMapper

class HomeData : NSObject, NSCoding, Mappable{
    
    var catAvgRating : [[String]]?
    var dob : String?
    var email : String?
    var experience : [Experience]?
    var fullName : String?
    var hQualification : [HQualification]?
    var id : String?
    var other : [Supervisor]?
    var peer : [Supervisor]?
    var phone : String?
    var profileImg : String?
    var profileStatus : String?
    var profileType : String?
    var quesAvgRating : [[String]]?
    var selfRating : String?
    var subordinate : [Supervisor]?
    var supervisor : [Supervisor]?
    var totalAvg : [Supervisor]?
    var totalAvgRating : String?
    var totalInvitesRatingCount : String?
    var totalRatingCount : Int?
    var typeAvgRating : [[String]]?
    var url : String?
    var activeStatus : String?
    var alreadyRated : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return HomeData()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        catAvgRating <- map["cat_avg_rating"]
        dob <- map["dob"]
        email <- map["email"]
        experience <- map["experience"]
        fullName <- map["full_name"]
        hQualification <- map["h_qualification"]
        id <- map["id"]
        other <- map["other"]
        peer <- map["peer"]
        phone <- map["phone"]
        profileImg <- map["profile_img"]
        profileStatus <- map["profile_status"]
        profileType <- map["profile_type"]
        quesAvgRating <- map["ques_avg_rating"]
        selfRating <- map["self_rating"]
        subordinate <- map["subordinate"]
        supervisor <- map["supervisor"]
        totalAvg <- map["total_avg"]
        totalAvgRating <- map["total_avg_rating"]
        totalInvitesRatingCount <- map["total_invites_rating_count"]
        totalRatingCount <- map["total_rating_count"]
        typeAvgRating <- map["type_avg_rating"]
        url <- map["url"]
        activeStatus <- map["active_status"]
        alreadyRated <- map["already_rated"]
        
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        catAvgRating = aDecoder.decodeObject(forKey: "cat_avg_rating") as? [[String]]
        dob = aDecoder.decodeObject(forKey: "dob") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        experience = aDecoder.decodeObject(forKey: "experience") as? [Experience]
        fullName = aDecoder.decodeObject(forKey: "full_name") as? String
        hQualification = aDecoder.decodeObject(forKey: "h_qualification") as? [HQualification]
        id = aDecoder.decodeObject(forKey: "id") as? String
        other = aDecoder.decodeObject(forKey: "other") as? [Supervisor]
        peer = aDecoder.decodeObject(forKey: "peer") as? [Supervisor]
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        profileImg = aDecoder.decodeObject(forKey: "profile_img") as? String
        profileStatus = aDecoder.decodeObject(forKey: "profile_status") as? String
        profileType = aDecoder.decodeObject(forKey: "profile_type") as? String
        quesAvgRating = aDecoder.decodeObject(forKey: "ques_avg_rating") as? [[String]]
        selfRating = aDecoder.decodeObject(forKey: "self_rating") as? String
        subordinate = aDecoder.decodeObject(forKey: "subordinate") as? [Supervisor]
        supervisor = aDecoder.decodeObject(forKey: "supervisor") as? [Supervisor]
        totalAvg = aDecoder.decodeObject(forKey: "total_avg") as? [Supervisor]
        totalAvgRating = aDecoder.decodeObject(forKey: "total_avg_rating") as? String
        totalInvitesRatingCount = aDecoder.decodeObject(forKey: "total_invites_rating_count") as? String
        totalRatingCount = aDecoder.decodeObject(forKey: "total_rating_count") as? Int
        typeAvgRating = aDecoder.decodeObject(forKey: "type_avg_rating") as? [[String]]
        url = aDecoder.decodeObject(forKey: "url") as? String
        activeStatus = aDecoder.decodeObject(forKey: "active_status") as? String
        alreadyRated = aDecoder.decodeObject(forKey: "already_rated") as? Int
        
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if catAvgRating != nil{
            aCoder.encode(catAvgRating, forKey: "cat_avg_rating")
        }
        if dob != nil{
            aCoder.encode(dob, forKey: "dob")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if experience != nil{
            aCoder.encode(experience, forKey: "experience")
        }
        if fullName != nil{
            aCoder.encode(fullName, forKey: "full_name")
        }
        if hQualification != nil{
            aCoder.encode(hQualification, forKey: "h_qualification")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if other != nil{
            aCoder.encode(other, forKey: "other")
        }
        if peer != nil{
            aCoder.encode(peer, forKey: "peer")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
        if profileImg != nil{
            aCoder.encode(profileImg, forKey: "profile_img")
        }
        if profileStatus != nil{
            aCoder.encode(profileStatus, forKey: "profile_status")
        }
        if profileType != nil{
            aCoder.encode(profileType, forKey: "profile_type")
        }
        if quesAvgRating != nil{
            aCoder.encode(quesAvgRating, forKey: "ques_avg_rating")
        }
        if selfRating != nil{
            aCoder.encode(selfRating, forKey: "self_rating")
        }
        if subordinate != nil{
            aCoder.encode(subordinate, forKey: "subordinate")
        }
        if supervisor != nil{
            aCoder.encode(supervisor, forKey: "supervisor")
        }
        if totalAvg != nil{
            aCoder.encode(totalAvg, forKey: "total_avg")
        }
        if totalAvgRating != nil{
            aCoder.encode(totalAvgRating, forKey: "total_avg_rating")
        }
        if totalInvitesRatingCount != nil{
            aCoder.encode(totalInvitesRatingCount, forKey: "total_invites_rating_count")
        }
        if totalRatingCount != nil{
            aCoder.encode(totalRatingCount, forKey: "total_rating_count")
        }
        if typeAvgRating != nil{
            aCoder.encode(typeAvgRating, forKey: "type_avg_rating")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }
        
        if activeStatus != nil{
            aCoder.encode(activeStatus, forKey: "active_status")
        }
        if alreadyRated != nil{
            aCoder.encode(alreadyRated, forKey: "already_rated")
        }
        
        
    }
    
}
//
//
//class HomeData : NSObject, NSCoding, Mappable{
//
//    var activeStatus : String?
//    var alreadyRated : Int?
//    var catAvgRating : [[String]]?
//    var dob : String?
//    var email : String?
//    var experience : [Experience]?
//    var fullName : String?
//    var hQualification : [HQualification]?
//    var id : String?
//    var phone : String?
//    var profileImg : String?
//    var profileStatus : String?
//    var profileType : String?
//    var quesAvgRating : [[String]]?
//    var totalAvgRating : String?
//    var totalInvitesRatingCount : String?
//    var totalRatingCount : Int?
//    var typeAvgRating : [[String]]?
//    var url : String?
//    var supervisor : [Supervisor]?
//    var totalAvg : [Supervisor]?
//    var selfRating : String?
//    var other : [AnyObject]?
//    var peer : [AnyObject]?
//    var subordinate : [AnyObject]?
//
//
//    class func newInstance(map: Map) -> Mappable?{
//        return HomeData()
//    }
//    required init?(map: Map){}
//    private override init(){}
//
//    func mapping(map: Map)
//    {
//        activeStatus <- map["active_status"]
//        alreadyRated <- map["already_rated"]
//        catAvgRating <- map["cat_avg_rating"]
//        dob <- map["dob"]
//        email <- map["email"]
//        experience <- map["experience"]
//        fullName <- map["full_name"]
//        hQualification <- map["h_qualification"]
//        id <- map["id"]
//        phone <- map["phone"]
//        profileImg <- map["profile_img"]
//        profileStatus <- map["profile_status"]
//        profileType <- map["profile_type"]
//        quesAvgRating <- map["ques_avg_rating"]
//        totalAvgRating <- map["total_avg_rating"]
//        totalInvitesRatingCount <- map["total_invites_rating_count"]
//        totalRatingCount <- map["total_rating_count"]
//        typeAvgRating <- map["type_avg_rating"]
//        url <- map["url"]
//
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required init(coder aDecoder: NSCoder)
//    {
//         activeStatus = aDecoder.decodeObject(forKey: "active_status") as? String
//         alreadyRated = aDecoder.decodeObject(forKey: "already_rated") as? Int
//         catAvgRating = aDecoder.decodeObject(forKey: "cat_avg_rating") as? [[String]]
//         dob = aDecoder.decodeObject(forKey: "dob") as? String
//         email = aDecoder.decodeObject(forKey: "email") as? String
//         experience = aDecoder.decodeObject(forKey: "experience") as? [Experience]
//         fullName = aDecoder.decodeObject(forKey: "full_name") as? String
//         hQualification = aDecoder.decodeObject(forKey: "h_qualification") as? [HQualification]
//         id = aDecoder.decodeObject(forKey: "id") as? String
//         phone = aDecoder.decodeObject(forKey: "phone") as? String
//         profileImg = aDecoder.decodeObject(forKey: "profile_img") as? String
//         profileStatus = aDecoder.decodeObject(forKey: "profile_status") as? String
//         profileType = aDecoder.decodeObject(forKey: "profile_type") as? String
//         quesAvgRating = aDecoder.decodeObject(forKey: "ques_avg_rating") as? [[String]]
//         totalAvgRating = aDecoder.decodeObject(forKey: "total_avg_rating") as? String
//         totalInvitesRatingCount = aDecoder.decodeObject(forKey: "total_invites_rating_count") as? String
//         totalRatingCount = aDecoder.decodeObject(forKey: "total_rating_count") as? Int
//         typeAvgRating = aDecoder.decodeObject(forKey: "type_avg_rating") as? [[String]]
//         url = aDecoder.decodeObject(forKey: "url") as? String
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc func encode(with aCoder: NSCoder)
//    {
//        if activeStatus != nil{
//            aCoder.encode(activeStatus, forKey: "active_status")
//        }
//        if alreadyRated != nil{
//            aCoder.encode(alreadyRated, forKey: "already_rated")
//        }
//        if catAvgRating != nil{
//            aCoder.encode(catAvgRating, forKey: "cat_avg_rating")
//        }
//        if dob != nil{
//            aCoder.encode(dob, forKey: "dob")
//        }
//        if email != nil{
//            aCoder.encode(email, forKey: "email")
//        }
//        if experience != nil{
//            aCoder.encode(experience, forKey: "experience")
//        }
//        if fullName != nil{
//            aCoder.encode(fullName, forKey: "full_name")
//        }
//        if hQualification != nil{
//            aCoder.encode(hQualification, forKey: "h_qualification")
//        }
//        if id != nil{
//            aCoder.encode(id, forKey: "id")
//        }
//        if phone != nil{
//            aCoder.encode(phone, forKey: "phone")
//        }
//        if profileImg != nil{
//            aCoder.encode(profileImg, forKey: "profile_img")
//        }
//        if profileStatus != nil{
//            aCoder.encode(profileStatus, forKey: "profile_status")
//        }
//        if profileType != nil{
//            aCoder.encode(profileType, forKey: "profile_type")
//        }
//        if quesAvgRating != nil{
//            aCoder.encode(quesAvgRating, forKey: "ques_avg_rating")
//        }
//        if totalAvgRating != nil{
//            aCoder.encode(totalAvgRating, forKey: "total_avg_rating")
//        }
//        if totalInvitesRatingCount != nil{
//            aCoder.encode(totalInvitesRatingCount, forKey: "total_invites_rating_count")
//        }
//        if totalRatingCount != nil{
//            aCoder.encode(totalRatingCount, forKey: "total_rating_count")
//        }
//        if typeAvgRating != nil{
//            aCoder.encode(typeAvgRating, forKey: "type_avg_rating")
//        }
//        if url != nil{
//            aCoder.encode(url, forKey: "url")
//        }
//
//    }
//
//}
