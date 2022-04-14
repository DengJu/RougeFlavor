# RougeFlavor
Network request module for MiMo

## Support
· > iOS 13.0

## Usage

1.导入RougeFlavor.framework到您的项目中
2.在项目-> Target -> General -> Framework,Libraries, and Embedded content中，添加RougeFlavor.framework
3.项目中 
``` 
import RougeFlavor 
```
```
RequestParameterConfig.shared.packageName = "Random"
RequestParameterConfig.shared.uuid = "00008020-0011353C34DA002E"
RequestParameterConfig.shared.version = "1.0.0"
/// 建议所有参数都手动配置，建议所有参数都手动配置，建议所有参数都手动配置
...
RF.request(.InitAPI) { response in
    debugPrint(response)
}
```
