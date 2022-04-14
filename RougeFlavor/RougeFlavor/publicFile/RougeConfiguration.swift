/*
 网络请求配置项，常规模式下，所有的属性都需要用户自行配置，默认属性有可能导致请求失败
packageName - 每个包都不一样，服务端判断是哪一个包
uuid - uuid默认为空，则请求一定会报错，uuid没有默认值的原因是因为uuid需要存储到钥匙串，创建钥匙串需要一个group identity，每个项目的identity不一样，如果一样，则可能导致安装了A、B两个集成了这个framework的项目，A项目中可能获取到的uuid是B项目的。
channel - 渠道，默认为shared，就是自然安装。在DeepLink后，需要传从DeepLink中获取的参数给后台绑定关系。
source - 包来源，告诉后台是iOS平台
netType - 当前的网络类型，有网络链接为 WiFi / Cellular 两种类型，无网络链接则为Not Connected
version - 为项目的版本号，不是此Framework的版本
requestToken - 请求的token，服务端需要这个token来判断权限，必须要传，不传此参数不能正常使用SDK。
callId - 调用通话接口需要，判断通话唯一的ID，必须要传，不传此参数不能正常使用SDK。
isAudit - 是否是审核模式，需要此参数来判断是否进入审核模式，必须要传，不传此参数不能正常使用SDK。
testBaseUrlString - 测试服地址，必须要传，不传此参数不能正常使用SDK。
baseUrlString - 正式服地址，必须要传，不传此参数不能正常使用SDK。
serviceMCC - 运营商MCC，必须要传，不传此参数不能正常使用SDK。

 Network request configuration item. In the normal mode, all attributes need to be configured by the user. The shared attribute may cause the request to fail
Packagename - each package is different. The server determines which package it is
UUID - if UUID is empty by shared, the request will report an error. The reason why UUID has no shared value is that UUID needs to be stored in the key string. Creating the key string requires a group identity. The identity of each project is different. If it is the same, it may lead to the installation of two projects integrating a and B into the framework. The UUID that may be obtained in project a is the identity of project B.
Channel - channel. The shared is shared, which means natural installation. After deeplink, you need to pass the parameters obtained from deeplink to the background binding relationship.
Source - the source of the package, telling the background that it is the IOS platform
Nettype - the current network type. There are two types of network links: WiFi / cellular, and not connected if there is no network link
Version - is the version number of the project, not the version of this framework
Requesttoken - the token requested. The server needs this token to determine permissions. It must be passed. If this parameter is not passed, the SDK cannot be used normally.
Callid - to call the call interface, it is necessary to determine the unique ID of the call. If this parameter is not passed, the SDK cannot be used normally.
Whether isaudit - is in audit mode requires this parameter to determine whether it enters audit mode. It must be passed. If this parameter is not passed, the SDK cannot be used normally.
Testbaseurlstring - test server address, which must be passed. If this parameter is not passed, the SDK cannot be used normally.
Baseurlstring - the official service address must be passed. If this parameter is not passed, the SDK cannot be used normally.
serviceMCC - Mobile Country Code. If this parameter is not passed, the SDK cannot be used normally.
 */
import UIKit


//MARK: - RequestParameterConfig
public struct RequestParameterConfig {
    
    public static var shared: RequestParameterConfig = RequestParameterConfig()
    
    /// 包名
    public var packageName: String = ""
    
    /// uuid
    public var uuid: String = ""
    
    /// channel
    public var channel: String = "default"
    
    /// source
    public var source: String = "ios"
    
    /// 当前用户选择的语言
    public var currentLanguage: String = "en"
    
    /// model
    public var model: String = UIDevice.modelName
    
    /// 网络类型
    public var netType: String = "Not Connected"
    
    /// 时间戳
    public var timeStamp: String = timeStamp
    
    /// 版本
    public var version: String = "1.0.0"
    
    /// osModel
    public var os: String = UIDevice.current.systemVersion
    
    /// 请求token,必须传
    public var requestToken: String = ""
    
    /// 通话唯一ID,必须传
    public var callId: String = ""
    
    /// 是否是审核模式
    public var isAudit: Bool = true
    
    public var needAppInfoHeader: Bool = false
    
    /// 运营商MCC
    public var serviceMCC: String?
    
    /// 服务器地址,必须传
    public var baseUrlString: String = ""
    
    /// 当前请求返回的错误
    /// 1.没有实现failure回调才会有值，否则为nil
    /// 2.总是为上一次的错误
    /// 3.建议每个请求都实现failure回调，因为在开始下一次请求时，此参数值会重置为nil，不能缓存
    public var errorInfo: ResponseErrorInfo?
    
    public var requestErrorInfo: ((_ error: ResponseErrorInfo) -> Void)?
    
    private static let timeStamp: String = {
        let now = NSDate()
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let timeStamp = CLongLong(round(timeInterval*1000))
        return "\(timeStamp)"
    }()
}

//MARK: - RequestModel
class RequestModel<T>: HandyJSON {
    var code: Int = 0
    var msg: String = ""
    var time: String = ""
    var data: T? = nil
    
    required init() {}
}

//MARK: - RequestConfig
/*
 请求的配置项枚举，不允许单独添加，只能修改SDK才能添加/删除
 详情请看下方枚举中配置
 
 The requested configuration items are enumerated. They cannot be added separately. They can only be added / deleted by modifying the SDK
 See the configuration in the enumeration below for details
 */
public enum RougeConfiguration: Equatable {
    
    public static func == (lhs: RougeConfiguration, rhs: RougeConfiguration) -> Bool {
        return true
    }
    /// 初始化
    case InitAPI
    /// 签到
    case CheckIn
    /// FAQ
    case QueryFAQ
    /// 隐身登录
    case HiddenLogin
    /// 游客登录
    case TouristLogin
    /// 礼物列表
    case QueryGiftList
    /// 签到信息
    case QueryDailyInfo
    /// 获取用户信息
    case BasicInfo(id: Int)
    /// 查询语言列表
    case QueryLanguages
    /// 查询抽奖转盘列表
    case QueryLotteryList
    /// 查询是否能抽奖
    case QueryCanLottery
    /// 抽奖动作接口
    case QuerySetLottery
    /// 查询图片上传凭证
    case QueryImageTicket
    /// 匹配主播接口
    case MatchOnlyAnchor
    /// 免费消息条数
    case QueryFreeMsgNum
    /// 刷新用户信息
    case RefreshUserModel
    /// 下单
    case DoOrder(listId: Int)
    /// 查询支持的充值类型
    case QueryRechargeType
    /// 查询首充模型
    case QueryFirstRecharge
    /// 购买小视频
    case BuyShortVideo(id: Int)
    /// 匹配不喜欢接口
    case MatchUnlike(userId: Int)
    /// 主播详情
    case AnchorDetailInfo(id: Int)
    /// 删除小视频
    case DeleteShortVideo(id: Int)
    /// 老虎机中奖记录列表
    case LuckyNumber_RecordList
    /// 查询视屏播放信息
    case QueryVideoInfo(id: String)
    /// 上传图片
    case UploadPhoto(isHead: Bool)
    /// 用户小视频列表
    case UsersVideoList(userId: Int)
    /// 移除被拉黑用户
    case RemoveBlocker(userId: Int)
    /// 发消息扣费
    case SendMessage(anchorId: Int)
    /// 通话心跳
    case CallHeartBeat(callId: String)
    /// 关注和取消关注
    case FollowOrUnfollow(userId: Int)
    /// 取消支付
    case DoCancelPay(orderId: String)
    /// 批量查询用户信息
    case QueryManyUsersInfo(ids: [Int])
    /// 拉黑列表
    case QueryBlockList(pageIndex: Int)
    /// 查询视屏上传凭证
    case QueryVideoTicket(title: String)
    /// 获取配置项
    case QueryConfigs(configs: [String])
    /// 查询自己的小视频
    case QueryMyVideos(pageIndex: Int)
    /// 查询充值状态
    case QueryPPStatus(orderId: String)
    /// 通话开始接口
    case CallStart(userId: Int, caller: Int)
    /// 喜欢小视频
    case LikeVideo(type: Int, videoId: Int)
    /// 查询自己喜欢的小视频
    case QueryLikeVideos(pageIndex: Int)
    /// 查询排行榜
    case QueryRankList(type: Int, day: Int)
    /// 送礼物接口
    case SendGift(anchorId: Int, giftId: Int)
    /// 验证票据充值
    case VerifyTransaction(baseStr: String)
    /// 查询关注列表
    case QueryFollowList(type: Int, page: Int)
    /// 绑定FireBase-Token
    case BindingFCMToken(fcmToken: String)
    /// 通话前置检查
    case CallBefore(userId: Int, callId: String)
    /// 查询主播详情排行榜
    case QueryAnchorDetailRank(anchorID: Int)
    /// 推荐主播列表
    case RecommendList(mutiNum: Int, total: Int)
    /// 评价主播
    case EvaluteAnchor(isUp: Int, label: [String])
    /// 删除账号
    case DeleteAccount(type: Int, reason: String)
    /// 三方登录
    case ThirdLogin(user: String, userStr: String)
    /// 查询充值列表
    case QueryCoinsList(codetype: Int?, type: Int)
    /// 老虎机排行榜列表
    case LuckyNumber_RankList(day: Int, type: Int)
    /// 老虎机投注
    case LuckyNumber_GetNumber(betsNumber: Int)
    /// 历史列表
    case QueryHistoryList(type: Int, pageIndex: Int)
    /// 查询小视频列表
    case QueryShortVideoList(type: Int, pageIndex: Int, _ videoLabel: Int = 0)
    /// 通话异常上报
    case CallFailLog(userId: Int, type: Int, callId: String)
    /// 注册填写用户资料
    case RegisterInfo(name: String, age: Int, gender: Int)
    /// 主播列表
    case AnchorList(page: Int, languages: [Int], type: Int)
    /// 上传视频完成
    case SubmitVideoUpload(picUrl: String, videoId: String, labelId:[Int], info: String)
    /// 匹配成功
    case MatchSuccess(userId: Int, costInfo: [[String: Any]])
    /// 通话结束
    case CallEnd(userId: Int, time: Int, status: Int, callId: String)
    /// 购买失败
    case DoBuyFailLog(ticket: String, orderId: String, errorMsg: String)
    /// 举报/拉黑
    case ReportOrBlock(userId: Int, type: Int, content: String, blockType: Int)
    /// 提交反馈
    case SubmitFeedback(type: Int, reason: String, photos: [String], email: String)
    /// 编辑用户资料
    case ModifyUserInfo(name: String, age: String, gender: String, country: Int, signature: String, pic: [Dictionary<String, Any>])
    
    /// 获取分享金币
    case GetShareCoins
    /// 刷新RTMToken
    case RefreshRTMToken
    /// 刷新RTCToken
    case RefreshRTCToken(houseId: String)
    /// 新配置项
    case FindByCodeCat(config: String)
    /// 查询免费视频详情
    case QueryFreeVideoInfo(userId: Int)
    
    /// 获取房间列表
    case LivingRoomList(label: String, pageIndex: Int, _ param1: String?, _ param2: String?, _ param3: String?, _ param4: String?, _ param5: String?, _ param6: String?)
    /// 创建房间（开始直播）
    case BeginLiving(cover: String, label: String, roomName: String, liveNotice: String, _ param1: String?, _ param2: String?, _ param3: String?, _ param4: String?, _ param5: String?, _ param6: String?)
    /// 删除直播房间
    case DeleteLivingRoom(roomId: Int)
    /// 查询声网房间人数
    case QueryAgoraUserList(channelName: String)
    
    case GUIHouseList
    case GUICreateRoomList(model: HandyJSON)
    case GUIUpdateRoomInfo(model: HandyJSON)
    case GUIRegister(model: HandyJSON)
    case GUILogin(userId: String)
    case GUIUserInfo(userId: String)
    case GUIUpdateUserInfo(model: HandyJSON)
    case GUIUploadPic
    
}
