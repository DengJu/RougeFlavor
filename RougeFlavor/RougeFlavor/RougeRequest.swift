
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

public extension RougeRequest {
    
    /// 不带图片数据请求
    /// - Returns: 返回DataRequest
    private func requestData<T>(_ requestConfig: RougeConfiguration!, success: @escaping (_ data : T)->(), failure: ((ResponseErrorInfo) ->Void)? = nil, uploadProgress: ((Double) -> Void)? = nil) -> DataRequest
    {
        let request = AF.request(requestConfig.request)
        if requestConfig.isEncryptRequest {
            request.responseString { response in
                switch response.result {
                case .success(let responseObject):
                    guard let code = response.response?.statusCode else { return }
                    guard code == 200 else {
                        guard let fail = failure else {
                            let errorInfo = ResponseErrorInfo(.customError(code, "请求错误："+responseObject), requestConfig.request)
                            RequestParameterConfig.shared.errorInfo = errorInfo
                            if let closure = RequestParameterConfig.shared.requestErrorInfo {
                                closure(errorInfo)
                            }
                            debugPrint(errorInfo)
                            return
                        }
                        fail(ResponseErrorInfo(.customError(code, responseObject), requestConfig.request))
                        return
                    }
                    guard responseObject.count > 0 else {
                        let errorInfo = ResponseErrorInfo(.customError(51001, "请求错误：响应为空"), requestConfig.request)
                        RequestParameterConfig.shared.errorInfo = errorInfo
                        if let closure = RequestParameterConfig.shared.requestErrorInfo {
                            closure(errorInfo)
                        }
                        debugPrint(errorInfo)
                        return
                    }
                    guard let x_sign = (response.response?.allHeaderFields["x-sign"] ?? response.response?.allHeaderFields["X-Sign"]) as? String else {
                        let errorInfo = ResponseErrorInfo(.customError(51001, "请求错误：响应头里面没有x-sign参数，可能是请求头参数错误造成"), requestConfig.request)
                        RequestParameterConfig.shared.errorInfo = errorInfo
                        if let closure = RequestParameterConfig.shared.requestErrorInfo {
                            closure(errorInfo)
                        }
                        debugPrint(errorInfo)
                        return
                    }
                    if let baseStr = response.value,
                       let data = Data(base64Encoded: baseStr, options: .ignoreUnknownCharacters),
                       let decodeArrayData = try? AES(key: requestConfig.DECRYPTKEY.bytes, blockMode: ECB(), padding: .pkcs7).decrypt(data.bytes),
                       let decodeString = String(data: Data(decodeArrayData), encoding: .utf8),
                       decodeString.HMAC(key: requestConfig.PUBLICKEY) == x_sign {
                        if let model = RequestModel<T>.deserialize(from: decodeString.convertDictionary()) {
                            guard let data = model.data, model.code == 0 else {
                                guard let fail = failure else {
                                    let errorInfo = ResponseErrorInfo(.customError(51001, model.msg), requestConfig.request)
                                    RequestParameterConfig.shared.errorInfo = errorInfo
                                    if let closure = RequestParameterConfig.shared.requestErrorInfo {
                                        closure(errorInfo)
                                    }
                                    debugPrint(errorInfo)
                                    return
                                }
                                fail(ResponseErrorInfo(.customError(model.code, model.msg), requestConfig.request))
                                return
                            }
                            if case .DeleteAccount = requestConfig  {
                                /// 如果删除账号成功，移除token
                                RequestParameterConfig.shared.requestToken = ""
                            }
                            success(data)
                        }
                    }else {
                        guard let fail = failure else {
                            let errorInfo = ResponseErrorInfo(.customError(51001, "请求错误：" + "Request failure!"), requestConfig.request)
                            RequestParameterConfig.shared.errorInfo = errorInfo
                            if let closure = RequestParameterConfig.shared.requestErrorInfo {
                                closure(errorInfo)
                            }
                            debugPrint(errorInfo)
                            return
                        }
                        fail(ResponseErrorInfo(.customError(21001, "解密验签失败"), requestConfig.request))
                    }
                case .failure(let error):
                    if let underlyingError = error.underlyingError {
                        if let urlError = underlyingError as? URLError {
                            if urlError.code == .timedOut {
                                AF.cancelAllRequests()
                            }else {
                                let statusCode = urlError.code.rawValue
                                let errorDesc = urlError.localizedDescription
                                guard let fail = failure else {
                                    let errorInfo = ResponseErrorInfo(.customError(51001, errorDesc), requestConfig.request)
                                    RequestParameterConfig.shared.errorInfo = errorInfo
                                    if let closure = RequestParameterConfig.shared.requestErrorInfo {
                                        closure(errorInfo)
                                    }
                                    debugPrint(errorInfo)
                                    return
                                }
                                fail(ResponseErrorInfo(.httpError(statusCode, errorDesc), requestConfig.request))
                            }
                        }
                    }
                }
            }
        }else {
            request.responseJSON { response in
                switch response.result {
                case .success(_):
                    guard response.value != nil,
                          let dict = response.value as? [String: Any],
                          let model = RequestModel<T>.deserialize(from: dict) else { return }
                    guard let data = model.data, model.code == 0 else {
                        guard let fail = failure else {
                            let errorInfo = ResponseErrorInfo(.customError(51001, model.msg), requestConfig.request)
                            RequestParameterConfig.shared.errorInfo = errorInfo
                            if let closure = RequestParameterConfig.shared.requestErrorInfo {
                                closure(errorInfo)
                            }
                            debugPrint(errorInfo)
                            return
                        }
                        fail(ResponseErrorInfo(.httpError(model.code, model.msg), requestConfig.request))
                        return
                    }
                    success(data)
                case .failure(let error):
                    if let underlyingError = error.underlyingError {
                        if let urlError = underlyingError as? URLError {
                            if urlError.code == .timedOut {
                                AF.cancelAllRequests()
                            }else {
                                let statusCode = urlError.code.rawValue
                                let errorDesc = urlError.localizedDescription
                                guard let fail = failure else {
                                    let errorInfo = ResponseErrorInfo(.customError(51001, errorDesc), requestConfig.request)
                                    RequestParameterConfig.shared.errorInfo = errorInfo
                                    if let closure = RequestParameterConfig.shared.requestErrorInfo {
                                        closure(errorInfo)
                                    }
                                    debugPrint(errorInfo)
                                    return
                                }
                                fail(ResponseErrorInfo(.httpError(statusCode, errorDesc), requestConfig.request))
                            }
                        }
                    }
                }
            }
        }
        return request
    }
    
    /// 带图片数据请求
    /// - Returns: 返回DataRequest
    private func requestImageData<T>(_ requestConfig: RougeConfiguration, image: UIImage?, success: @escaping (_ data : T)->(), failure: ((ResponseErrorInfo) ->Void)? = nil, uploadProgress: ((Double) -> Void)? = nil) -> DataRequest {
        let request = AF.upload(multipartFormData: { multipartforData in
            if let data = image?.jpegData(compressionQuality: 0.5) {
                multipartforData.append(data, withName: "file", fileName: "avatar.jpg", mimeType: "image/jpeg")
            }
        }, with: requestConfig.request)
        request.responseJSON { response in
            switch response.result {
            case .success(_):
                guard response.value != nil,
                      let dict = response.value as? [String: Any],
                      let model = RequestModel<T>.deserialize(from: dict) else { return }
                guard let data = model.data, model.code == 0 else {
                    guard let fail = failure else {
                        let errorInfo = ResponseErrorInfo(.customError(51001, model.msg), requestConfig.request)
                        RequestParameterConfig.shared.errorInfo = errorInfo
                        if let closure = RequestParameterConfig.shared.requestErrorInfo {
                            closure(errorInfo)
                        }
                        debugPrint(errorInfo)
                        return
                    }
                    fail(ResponseErrorInfo(.httpError(model.code, model.msg), requestConfig.request))
                    return
                }
                success(data)
            case .failure(let error):
                if let underlyingError = error.underlyingError {
                    if let urlError = underlyingError as? URLError {
                        if urlError.code == .timedOut {
                            AF.cancelAllRequests()
                        }else {
                            let statusCode = urlError.code.rawValue
                            let errorDesc = urlError.localizedDescription
                            guard let fail = failure else {
                                let errorInfo = ResponseErrorInfo(.customError(51001, errorDesc), requestConfig.request)
                                RequestParameterConfig.shared.errorInfo = errorInfo
                                if let closure = RequestParameterConfig.shared.requestErrorInfo {
                                    closure(errorInfo)
                                }
                                debugPrint(errorInfo)
                                return
                            }
                            fail(ResponseErrorInfo(.httpError(statusCode, errorDesc), requestConfig.request))
                        }
                    }
                }
            }
        }
        return request
    }
    
}

