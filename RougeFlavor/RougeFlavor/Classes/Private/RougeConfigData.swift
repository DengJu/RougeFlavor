import UIKit

//MARK: - About Parameter
extension RougeConfiguration {
    
    /*
     公共参数
     Common Parameters
     */
    private var localParameters: [String : Any] {
        return ["appPackage":RequestParameterConfig.shared.packageName,
                "appid":RequestParameterConfig.shared.uuid,
                "channel":RequestParameterConfig.shared.channel,
                "from":RequestParameterConfig.shared.source,
                "lan":RequestParameterConfig.shared.currentLanguage,
                "model":RequestParameterConfig.shared.model,
                "net":RequestParameterConfig.shared.netType,
                "os":RequestParameterConfig.shared.os,
                "timestamp":RequestParameterConfig.shared.timeStamp,
                "version":RequestParameterConfig.shared.version,
                "nonce":"fasdfjabdshjbJfdsfjks",
                "signlog":"123"]
    }
    
    /// 参数拼接
    /// Splicing Parameters
    private var parameters: [String : Any] {
        var para:[String : Any] = [:]
        if !path.contains("v3") {
            para = localParameters
        }
        switch self {
        case let .RegisterInfo(name, age, gender):
            para["name"] = name
            para["gender"] = gender
            let calendar = Calendar.current
            let year = calendar.component(.year, from: Date())
            para["birthday"] = "\(year - age)-01-01"
            para["picList"] = []
            return para
        case let .AnchorList(page, languages, type):
            para["num"] = page
            para["language"] = languages
            para["type"] = type
            para["isAnchor"] = 1
            para["sortFlag"] = 1
            return para
        case let .AnchorDetailInfo(id):
            para["anchorUserId"] = id
            return para
        case let .UsersVideoList(userId):
            para["userId"] = userId
            return para
        case let .RecommendList(mutiNum, total):
            para["mutiNum"] = mutiNum
            para["total"] = total
            return para
        case let .ModifyUserInfo(name, age, gender, country, signature, pic):
            para["nickname"] = name
            para["birthday"] = age
            para["country"] = country
            para["gender"] = gender
            para["signature"] = signature
            para["pic"] = pic
            return para
        case let .QueryCoinsList(codeType, type):
            if let code = codeType {
                para["codeType"] = code
            }
            para["type"] = type
            return para
        case .QueryFAQ:
            para["type"] = 0
            return para
        case let .QueryRankList(type, day):
            para["type"] = type
            para["day"] = day
            return para
        case let .QueryBlockList(pageIndex):
            para["pageIndex"] = pageIndex
            return para
        case let .ReportOrBlock(userId, type, content, blockType):
            para["id"] = userId
            para["type"] = type
            para["content"] = content
            para["block"] = blockType
            return para
        case let .RemoveBlocker(userId):
            para["userId"] = userId
            return para
        case .QueryFirstRecharge:
            para["type"] = ""
            return para
        case let .DeleteAccount(type, reason):
            para["type"] = type
            para["reason"] = reason
            return para
        case let .SubmitFeedback(type, reason, photos, email):
            para["type"] = type
            para["suggest"] = reason
            para["picList"] = photos
            para["email"] = email
            return para
        case let .QueryManyUsersInfo(ids):
            para["ids"] = ids
            return para
        case let .SendGift(anchorId, giftId):
            para["anchorId"] = anchorId
            para["giftId"] = giftId
            return para
        case let .FollowOrUnfollow(userId):
            para["userId"] = userId
            return para
        case let .CallBefore(userId, callId):
            para["userId"] = userId
            para["callId"] = callId
            return para
        case let .CallStart(userId, caller):
            para["userId"] = userId
            para["caller"] = caller
            para["callId"] = RequestParameterConfig.shared.callId
            return para
        case .CallHeartBeat(let callId):
            para["callId"] = callId
            return para
        case let .CallEnd(userId, time, status, callId):
            para["userId"] = userId
            para["time"] = time
            para["status"] = status
            para["callId"] = callId
            return para
        case let .CallFailLog(userId, type, callId):
            para["userId"] = userId
            para["type"] = type
            para["callId"] = callId
            return para
        case let .VerifyTransaction(baseStr):
            para["baseStr"] = baseStr
            para["orderId"] = ""
            return para
        case let .QueryConfigs(configs):
            para["configs"] = configs
            return para
        case let .QueryVideoInfo(id):
            para["videoId"] = id
            return para
        case let .EvaluteAnchor(isUp, label):
            para["isUp"] = isUp
            para["label"] = label
            return para
        case let .QueryHistoryList(type, pageIndex):
            para["type"] = type
            para["pageIndex"] = pageIndex
            return para
        case let .MatchSuccess(userId, costInfo):
            para["callId"] = RequestParameterConfig.shared.callId
            para["costInfo"] = costInfo
            para["userId"] = userId
            return para
        case let .QueryShortVideoList(type, pageIndex, videoLabel):
            para["type"] = type
            para["pageIndex"] = pageIndex
            if videoLabel > 0 {
                para["videoLabel"] = videoLabel
            }
            para["isAnchor"] = RequestParameterConfig.shared.isAudit ? 0 : 1
            return para
        case let .LikeVideo(type, videoId):
            para["type"] = type
            para["videoId"] = videoId
            return para
        case let .QueryVideoTicket(title):
            para["title"] = title
            return para
        case let .SubmitVideoUpload(picUrl, videoId, labelId, info):
            para["price"] = "0"
            para["fileSize"] = "0"
            para["info"] = info
            para["picUrl"] = picUrl
            para["videoId"] = videoId
            para["labelId"] = labelId
            return para
        case let .QueryMyVideos(pageIndex):
            para["pageIndex"] = pageIndex
            return para
        case let .QueryLikeVideos(pageIndex):
            para["pageIndex"] = pageIndex
            return para
        case let .DeleteShortVideo(id):
            para["id"] = id
            return para
        case let .BuyShortVideo(id):
            para["id"] = id
            return para
        case let .QueryAnchorDetailRank(anchorID):
            para["anchorId"] = anchorID
            para["type"] = 1
            return para
        case let .ThirdLogin(user, userStr):
            para["email"] = ""
            para["nickName"] = ""
            para["user"] = user
            para["userStr"] = userStr
            return para
        case let .SendMessage(anchorId):
            para["anchorId"] = anchorId
            return para
        case let .QueryFollowList(type, page):
            para["type"] = type
            para["page"] = page
            return para
        case let .DoOrder(listId):
            para["listId"] = listId
            return para
        case let .LuckyNumber_RankList(day, type):
            para["day"] = day
            para["type"] = type
            return para
        case let .LuckyNumber_GetNumber(betsNumber):
            para["betsNumber"] = betsNumber
            return para
        case let .QueryPPStatus(orderId):
            para["orderId"] = orderId
            return para
        case let .MatchUnlike(userId):
            para["userId"] = userId
            return para
        case let .DoBuyFailLog(ticket, orderId, errorMsg):
            para["ticket"] = ticket
            para["orderId"] = orderId
            para["errorMsg"] = errorMsg
            return para
        case let .DoCancelPay(orderId):
            para["orderId"] = orderId
            return para
        case let .BindingFCMToken(fcmToken):
            para["token"] = fcmToken
            return para
        case let .FindByCodeCat(config):
            para["codeCat"] = config
            return para
        case let .BasicInfo(id):
            para["id"] = id
            return para
        case let .LivingRoomList(label, pageIndex, param1, param2, param3, param4, param5, param6):
            para["label"] = label
            para["pageIndex"] = pageIndex
            para["language"] = ""
            if let p = param1 {
                para["info1"] = p
            }
            if let p = param2 {
                para["info2"] = p
            }
            if let p = param3 {
                para["info3"] = p
            }
            if let p = param4 {
                para["data1"] = p
            }
            if let p = param5 {
                para["data2"] = p
            }
            if let p = param6 {
                para["data3"] = p
            }
            return para
        case let .BeginLiving(cover, label, roomName, liveNotice, param1, param2, param3, param4, param5, param6):
            para["cover"] = cover
            para["label"] = label
            para["roomName"] = roomName
            para["liveNotice"] = liveNotice
            para["language"] = ""
            if let p = param1 {
                para["info1"] = p
            }
            if let p = param2 {
                para["info2"] = p
            }
            if let p = param3 {
                para["info3"] = p
            }
            if let p = param4 {
                para["data1"] = p
            }
            if let p = param5 {
                para["data2"] = p
            }
            if let p = param6 {
                para["data3"] = p
            }
            return para
        case let .DeleteLivingRoom(roomId):
            para["id"] = roomId
            return para
        case let .GUILogin(userId):
            para["userId"] = userId
            return para
        case let .GUIUpdateRoomInfo(model):
            if let json = model.toJSON() {
                para.merge(json, uniquingKeysWith: {$1})
            }
            return para
        case let .GUIRegister(model):
            if let json = model.toJSON() {
                para.merge(json, uniquingKeysWith: {$1})
            }
            return para
        case let .GUICreateRoomList(model):
            if let json = model.toJSON() {
                para.merge(json, uniquingKeysWith: {$1})
            }
            return para
        case let .GUIUpdateUserInfo(model):
            if let json = model.toJSON() {
                para.merge(json, uniquingKeysWith: {$1})
            }
            return para
        case let .GUIUserInfo(userId):
            para["userId"] = userId
            return para
        default:
            return para
        }
    }
    
}

//MARK: - Request Path
private extension RougeConfiguration {
    
    /// 请求路径
    /// Request Path
    private var path: String {
        switch self {
        case .InitAPI: return "/v2/auth/init"
        case .TouristLogin: return "/v1/auth/touristLogin"
        case .RegisterInfo: return "/v2/users/postRegUserInfo"
        case .AnchorList: return "/v3/user/getUserList"
        case .AnchorDetailInfo: return "/v3/user/anchor/infos"
        case .UsersVideoList: return "/v1/svideo/own_list"
        case .RecommendList: return "/v3/anchor/recommend/get_recommend_anchor_list"
        case .ModifyUserInfo: return "/v2/user/changeUserInfo"
        case let .UploadPhoto(ishead): return ishead ? "/v1/pic/uploadHeadImage" : "/v1/pic"
        case .QueryDailyInfo: return "/v2/sign/getSign"
        case .CheckIn: return "/v2/sign/signin"
        case .RefreshUserModel: return "/v2/users/newUserInfo"
        case .QueryRechargeType: return "/ppy/supportRecharge"
        case .QueryCoinsList: return "/v1/recharge/list"
        case .QueryFAQ: return "/v1/help/list"
        case .QueryRankList: return "/v1/anchor/toplist"
        case .QueryBlockList: return "/v1/report/blockList"
        case .ReportOrBlock: return "/v1/report/add"
        case .RemoveBlocker: return "/v1/report/removeBlock"
        case .QueryFirstRecharge: return "/v2/popup/getPopup"
        case .DeleteAccount: return "/v1/user/delUserByVip"
        case .HiddenLogin: return "/v2/auth/hideLogin"
        case .SubmitFeedback: return "/v1/feedBack"
        case .QueryManyUsersInfo: return "/v2/user/userStatusList"
        case .QueryGiftList: return "/v1/auth/newGiftList"
        case .SendGift: return "/v1/gift"
        case .FollowOrUnfollow: return "/v1/anchor/care"
        case .CallBefore: return "/v2/call/callBefore"
        case .CallStart: return "/v2/call/callStart"
        case .CallHeartBeat: return "/v2/call/calling"
        case .CallEnd: return "/v2/call/callEnd"
        case .CallFailLog: return "/v2/call/callFailLog2"
        case .VerifyTransaction: return "/v2/rechargev2/ticketSuccess"
        case .QueryConfigs: return "/v2/auth/getInitConfig"
        case .QueryVideoInfo: return "/v1/video/getPlayInfo"
        case .EvaluteAnchor: return "/v2/call/callingComments"
        case .QueryHistoryList: return "/v2/calls/callList"
        case .MatchOnlyAnchor: return "/v1/userMatch/matchAnchorOnly"
        case .MatchUnlike: return "/v1/userMatch/matchUnLike"
        case .MatchSuccess: return "/v1/userMatch/matchSuccess"
        case .QueryShortVideoList: return "/v1/svideo/list"
        case .LikeVideo: return "/v1/svideo/favVideo"
        case .QueryVideoTicket: return "/v1/video/getVideoTicket"
        case .QueryImageTicket: return "/v1/video/getImageTicket"
        case .SubmitVideoUpload: return "/v1/svideo/submitVideo"
        case .QueryMyVideos: return "/v1/svideo/own_list"
        case .QueryLikeVideos: return "/v1/svideo/fav_list"
        case .QueryLotteryList: return "/v2/lottery/list"
        case .QueryCanLottery: return "/v2/lottery/isLottery"
        case .QuerySetLottery: return "/v2/lottery/setLottery"
        case .DeleteShortVideo: return "/v1/svideo/removeVideo"
        case .BuyShortVideo: return "/v1/svideo/buyVideo"
        case .QueryLanguages: return "/v1/auth/languages"
        case .QueryAnchorDetailRank: return "/v1/anchor/loverTop"
        case .ThirdLogin: return "/v1/auth/appleSign"
        case .QueryFreeMsgNum: return "/v2/backpack/msgNum"
        case .SendMessage: return "/v2/call/sendMessage"
        case .QueryFollowList: return "/v1/anchor/careList"
        case .DoOrder: return "/v1/recharge/order"
        case .LuckyNumber_RankList: return "/v1/anchor/toplist"
        case .LuckyNumber_GetNumber: return "/v1/lucky/getLuckyNumber"
        case .LuckyNumber_RecordList: return "/v1/lucky/getSlotRecordList"
        case .QueryPPStatus: return "/v1/recharge/queryStatus"
        case .DoBuyFailLog: return "/v1/recharge/failCallBack"
        case .DoCancelPay: return "/v1/recharge/cancelCallBack"
        case .BindingFCMToken: return "/v1/users/bandFireBaseToken"
        case .GetShareCoins: return "/v2/rtc/getCountShareCoin"
        case .FindByCodeCat: return "/v2/code/findByCodeCat"
        case .RefreshRTCToken: return "/v3/user/refresh_rtctoken"
        case .RefreshRTMToken: return "/v3/user/refresh_rtmtoken"
        case .QueryFreeVideoInfo: return "/v3/user/anchor/get_audit_video_info"
        case .BasicInfo: return "/v2/user/basicInfo"
        case .LivingRoomList: return "/v2/tmproom/getList"
        case .BeginLiving: return "/v2/tmproom/createLive"
        case .DeleteLivingRoom: return "/v2/tmproom/delLive"
        case .QueryAgoraUserList: return "/v3/agora/user_list"
        case .GUIHouseList: return "/v1/appApi/houseList"
        case .GUICreateRoomList: return "/v1/appApi/createHouse"
        case .GUILogin: return "/v1/appApi/login"
        case .GUIRegister: return "/v1/appApi/reg"
        case .GUIUpdateRoomInfo: return "/v1/appApi/updateHouse"
        case .GUIUserInfo: return "/v1/appApi/userInfo"
        case .GUIUpdateUserInfo: return "/v1/appApi/edit_info"
        case .GUIUploadPic: return "/v1/appApi/uploadImage"
        }
    }
    
    /// 请求全路径
    /// Request Full Path
    private var urlPath: String {
        let BaseUrl = RequestParameterConfig.shared.baseUrlString
        return BaseUrl + path
    }
    
}

extension RougeConfiguration {
    
    /// 请求体是否需要加密
    /// Whether the request body needs encryption
    var isEncryptRequest: Bool {
        //V1请求和Get请求不需要加密
        if (path.contains("v2") || path.contains("v3")) && !isGetRequest {
            return true
        }else {
            return false
        }
    }
    
    /// 不需要token的接口，需要单独添加case
    /// For the interface that does not require a token, you need to add a case separately
    var isNeedToken: Bool {
        switch self {
        case .InitAPI:
            return false
        default:
            return true
        }
    }
    
    /// 是否是GET请求
    /// is GET Request
    var isGetRequest: Bool {
        switch self {
        case .AnchorDetailInfo:
            return true
        case .RecommendList:
            return true
        case .RefreshRTCToken:
            return true
        case .RefreshRTMToken:
            return true
        case .QueryFreeVideoInfo:
            return true
        case .QueryAgoraUserList:
            return true
        default:
            return false
        }
    }
    
    /// 是否是上传图片接口
    /// is UPLOAD Image
    private var isUploadImage: Bool {
        switch self {
        case .UploadPhoto:
            return true
        case .GUIUploadPic:
            return true
        default:
            return false
        }
    }
    
    /// GET请求地址
    /// Get Request URL
    private var getRequestUrl: String {
        switch self {
        case .AnchorDetailInfo(let id):
            return urlPath + "?anchorUserId=\(id)"
        case .RecommendList(let mutiNum, let total):
            return urlPath + "?mutiNum=\(mutiNum)&total=\(total)"
        case .RefreshRTCToken(let houseId):
            return urlPath + "?houseId=" + houseId
        case .QueryFreeVideoInfo(let userId):
            return urlPath + "?anchorUserId=\(userId)"
        case .QueryAgoraUserList(let channelName):
            return urlPath + "?channelName=" + channelName
        default:
            return ""
        }
    }
    
    /// 请求
    var request: URLRequest {
        if getRequestUrl.isEmpty {
            return postRequest
        }else {
            return getRequest
        }
    }
    
    /// Get请求
    /// Get Request
    private var getRequest: URLRequest {
        var request = URLRequest.init(url: URL.init(string: getRequestUrl)!)
        request.timeoutInterval = 15
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        if let mcc = RequestParameterConfig.shared.serviceMCC {
            request.setValue(mcc, forHTTPHeaderField: "cardtype")
        }
        if RequestParameterConfig.shared.needAppInfoHeader {
            request.setValue(RequestParameterConfig.shared.packageName + "#" + RequestParameterConfig.shared.version, forHTTPHeaderField: "appinfo")
        }
        if isNeedToken {
            if !RequestParameterConfig.shared.requestToken.isEmpty {
                if urlPath.contains("v3") {
                    request.setValue(RequestParameterConfig.shared.requestToken, forHTTPHeaderField: "Authorization")
                }else {
                    request.setValue("Bearer " + RequestParameterConfig.shared.requestToken, forHTTPHeaderField: "Authorization")
                }
            }
        }
        if urlPath.contains("v2") || urlPath.contains("v3") {
            let randomString = String.randomString(length: 6)
            request.setValue(randomString, forHTTPHeaderField: "x-request-id")
        }
        return request
    }
    
    /// Post请求
    /// Post Request
    private var postRequest: URLRequest {
        var request = URLRequest.init(url: URL.init(string: urlPath)!)
        request.timeoutInterval = 15
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let mcc = RequestParameterConfig.shared.serviceMCC {
            request.setValue(mcc, forHTTPHeaderField: "cardtype")
        }
        if RequestParameterConfig.shared.needAppInfoHeader {
            request.setValue(RequestParameterConfig.shared.packageName + "#" + RequestParameterConfig.shared.version, forHTTPHeaderField: "appinfo")
        }
        if isUploadImage {
            request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        }
        if isNeedToken {
            if !RequestParameterConfig.shared.requestToken.isEmpty {
                if urlPath.contains("v3") {
                    request.setValue(RequestParameterConfig.shared.requestToken, forHTTPHeaderField: "Authorization")
                }else {
                    request.setValue("Bearer " + RequestParameterConfig.shared.requestToken, forHTTPHeaderField: "Authorization")
                }
            }
        }
        if urlPath.contains("v2") || urlPath.contains("v3") {
            let jsonString = parameters.toJsonString
            let randomString = String.randomString(length: 6)
            let timeStamp = RequestParameterConfig.shared.timeStamp
            let md5String = (timeStamp + jsonString + "M" + "imo-vivi" + randomString).md5()
            request.setValue(md5String, forHTTPHeaderField: "x-sign")
            request.setValue(randomString, forHTTPHeaderField: "x-request-id")
            request.setValue(timeStamp, forHTTPHeaderField: "x-time")
            if let encryptedBytes = try? AES(key: ENCRYPTKEY.bytes, blockMode: ECB(), padding: .pkcs7).encrypt(jsonString.bytes) {
                let baseString = encryptedBytes.toBase64()
                let data = (baseString.data(using: .utf8))! as Data
                request.httpBody = data
            }
            return request
        }else {
            let data = try? JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
            request.httpBody = data
            return request
        }
    }
    
    /// 解密的秘钥
    /// Decrypt-Key
    var DECRYPTKEY: String {
        return "GsbajY3RMKzIYFqI2AeeqN1T7dDecodi"
    }
    
    /// 加密的秘钥
    /// Encrypt-Key
    var ENCRYPTKEY: String {
        return "GsbajY4RMKzIYFIIACy3qN1T6dEncodi"
    }
    
    /// 公钥
    /// Publick-Key
    var PUBLICKEY: String {
        return "ObQgZtGDva/xgvfAMJY9rfM71Oz5xg4Lws9lHD/AHTFE2bhGDkA1ZmDpNlI7gR2WD/fIw9PpYlMDHUgXBvif2Q=="
    }
}
