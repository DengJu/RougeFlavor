
import Foundation

enum NetRequestError: Int {
    /// 请求成功
    case ok = 0
    /// 用户不存在
    case userNotExit = 1001
    /// 邮箱已经被注册
    case emailAlreadyExists = 1002
    /// 邮箱格式错误
    case illegalEmailFormat = 1003
    /// 错误的账号或者密码
    case wrongAccountOrPassword = 1004
    /// 用户被拉黑
    case userBeenBlocked = 1005
    /// 未成年
    case under18 = 1006
    /// 账号已经被删除
    case accountBeenDeleted = 1007
    /// 密码错误
    case passwordError = 1008
    /// 密码太短
    case passwordTooShort = 1009
    /// 设备被拉黑
    case deviceBeenBlock = 1010
    /// 设备注册达到上限
    case deviceRegistrationLimitReached = 1011
    /// 用户已经签到
    case userHasSignedIn = 1012
    /// 苹果订阅失败
    case subscriptionFailed = 1013
    /// 苹果订阅检查失败
    case subscriptionCheckFailed = 1014
    /// 从背包中送礼失败
    case failedSendGiftsFromBackpack = 1015
    /// 内购包月时重复请求
    case repeatRequestPurchasing = 1016
    /// 内购连续包月订购时解析订单内容异常
    case abnormalOrderContent = 1017
    /// 该用户今日已抽奖三次
    case drawnThreeTimes = 1018
    /// 昵称不能超过20个字符
    case nickNameTooLong = 1019
    /// 签名太长
    case signatureTooLong = 1020
    /// 未输入昵称
    case notInputNickName = 1021
    /// 未选择生日
    case notChooseBirthday = 1022
    /// 邀请码无效
    case inviteCodeInvalid = 1023
    /// 充值后才能送礼物
    case needToRechargeToSendGift = 1024
    /// 扣除积分不足
    case pointsInsufficient = 1025
    /// 未输入签名
    case notInputSignature = 1026
    /// 提交成功
    case submitSuccess = 1027
    /// 未设置价格，请自行设置价格
    case notSetRate = 1028
    /// 未输入联系方式
    case notInputContact = 1029
    /// 请选择语言
    case notChooseLanguage = 1030
    /// 请选择国家
    case notChooseCountry = 1031
    /// 请选择年龄
    case notChooseAge = 1032
    /// 已经是主播了，请不要重复申请
    case alreadyBecomeAnchor = 1033
    /// 经纪人码错误
    case agentCodeError = 1034
    /// 未选择直播经验
    case notChooseLiveExperience = 1035
    /// 未选择直播方式
    case notChooseLiveStyle = 1036
    /// 提现少于1000V币
    case withdrawalLessThan1000Coins = 1037
    /// 用户不能提现
    case userNotAllowWithdraw = 1038
    /// 不支持的提现方式
    case withdrawTypeNotSupport = 1039
    /// 需要联系经纪人才能提现
    case withdrawNeedToConnectAgent = 1040
    /// 输入的值不正确
    case correctAmount = 1041
    /// 没有更多的主播了
    case noMoreAnchorData = 1042
    /// V币不足
    case vCoinsInsufficient = 1043
    /// 不允许购买视频
    case notAllowBuyShortVideo = 1044
    /// 需要输入邮箱
    case notInputEmail = 1045
    /// 验证码错误
    case verifyCodeError = 1046
    /// 需要输入新密码
    case needInputNewPassword = 1047
    /// 新老密码一致
    case sameTheNewAndOldPassword = 1048
    /// 创建充值订单失败
    case creatOrderFailure = 1049
    /// 充值代码错误
    case rechargeCodeError = 1050
    /// 不能关注自己
    case canNotFollowSelf = 1051
    /// 主播不能关注主播
    case anchorNotAllowedFollowAnchor = 1052
    /// 充值失败请重试
    case rechargeFailNeedRetry = 1053
    /// 订阅失败
    case subscribeFail = 1054
    /// 您已经被对方拉黑
    case youAreBlocked = 1055
    /// 您拉黑了对方
    case youBlockedOtherParty = 1056
    /// 需要双方互相关注
    case needToFollowEachOther = 1057
    /// 个性签名太长
    case textLengthMoreThan100 = 1058
    /// 充值中，稍后再试
    case rechargingAndTryLater = 1059
    /// 订单过期
    case orderExpire = 1060
    /// 老虎机不能使用
    case slotMatchineNotUse = 1061
    /// 老虎机抽奖太快
    case slotMatchineTooFast = 1062
    /// 抽奖次数超过6次
    case lotteryCountMoreThan6 = 1063
    /// 老版匹配需要更新App版本
    case needUpdateApp = 1064
    /// 发送消息太快了
    case sendMessageTooFast = 1065
    /// 版本不存在
    case versionInvalid = 1066
    /// 后台扣币异常
    case deductCoinsError = 1067
    /// 订单信息异常，苹果返回订单信息为[]，前端刷新票据重新调用支付成功回调
    case rechargeOrderUnusual = 1068
    /// 不允许删除账号
    case notAllowedDeleteAccount = 1069
}

public enum ResonseError {
    
    /// http请求报错
    case httpError(_ code: Int, _ description: String)
    
    /// 后端请求报错
    case customError(_ code: Int, _ description: String)
    
    /// 前端处理报错
    case clientError(_ code: Int, _ description: String)
    
    /// 错误码
    public var errorCode: Int {
        switch self {
        case .httpError(let code,_):
            return code
        case .customError(let code,_):
            return code
        case .clientError(let code,_):
            return code
        }
    }
    
    /// 错误描述
    public var errorDescripton: String {
        switch self {
        case .httpError(_, let description):
            return description
        case .customError(_, let description):
            return description
        case .clientError(_, let description):
            return description
        }
    }
    
}

public struct ResponseErrorInfo {
    
    /// 错误码
    public let errorCode: Int
    
    /// 错误信息描述
    public let errorDescripton: String
    
    /// 当前请求信息
    public let request: URLRequest?
    
    public init(_ error: ResonseError, _ request: URLRequest?) {
        self.errorCode = error.errorCode
        self.errorDescripton = error.errorDescripton
        self.request = request
    }

}

