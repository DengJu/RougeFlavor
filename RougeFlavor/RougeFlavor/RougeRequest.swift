
import UIKit

public let RF = RougeRequest()

open class RougeRequest: NSObject {
    
    /// 普通请求
    /// - Parameters:
    ///   - requestConfig: 请求配置项
    ///   - success: 成功回调
    ///   - failure: 失败回调，如果实现了failure回调，则会返回错误码和错误信息，如果没有实现，则用
    /// - Returns: DataRequest
    @discardableResult open func request(_ requestConfig: RougeConfiguration! ,success : @escaping (_ data : Any)->(), failure : ((ResponseErrorInfo) ->Void)? = nil) -> DataRequest {
        return requestData(requestConfig, success: success, failure: failure, uploadProgress: nil)
    }
    
    /// 上传图片
    /// - Parameters:
    ///   - requestConfig: 请求配置项
    ///   - success: 成功回调
    ///   - failure: 失败回调
    /// - Returns: DataRequest
    @discardableResult open func uploadPhoto(_ requestConfig: RougeConfiguration!,_ image: UIImage? = nil,success : @escaping (_ data : Any)->(), failure : ((ResponseErrorInfo) ->Void)? = nil) -> DataRequest {
        return requestImageData(requestConfig, image: image, success: success, failure: failure, uploadProgress: nil)
    }
    
}
