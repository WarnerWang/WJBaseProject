# WJBaseProject
@[TOC](iOS 基本项目结构，下载后可直接使用)
## 初衷
我是在外包公司工作的，每次接到一个新项目后都要重新创建工程，然后把之前项目中有用的部分挪到本项目中，还要改不符合的部分，非常麻烦。所以我就想创建一个可以通用的基本工程，有了新项目后直接改工程名和前缀就可以直接使用了。这样没新启一个工程就可以直接开始画页面了，非常方便。

## 工程地址
[WJBaseProject](https://github.com/WarnerWang/WJBaseProject)

## 项目的整体结构
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019032909523021.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NoZW5tb2RleXVnZQ==,size_16,color_FFFFFF,t_70)
项目中结合Pod进行一些第三方插件的管理，项目中已经把几个比较常用的第三方进行引用，其中Masonry在本工程中还未使用，如果不想使用可自行移除，其它的库在本工程中都有使用，如果想更换只需删除本工程中对应的代码即可，我会在下文中指出在哪些地方使用的第三方插件。

## 项目的分层情况
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190329100454654.png)
### M，V，C文件
M(Models)，V(Views)，C(controllers)这三个文件夹放整个工程的 Model，UIView， UIViewControllers，如果想使用MVVM模式，请自行添加ViewModel文件。
### utils文件
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019032910110818.png)
本文件夹放的是工具类，目前已有两个文件，WJUtils里放的是本工程中通用的一些方法

```
@interface WJUtils : NSObject

/// 获取当前ViewController页面
+ (WJBaseVC *)getCurrentVC;

/// 获取未销毁的指定界面
+ (WJBaseVC *)getCurrVC:(NSString *)className;

/// 获取rootVC
+ (WJMainTabBarVC *)getRootVC;

+ (void)toast:(NSString *)toastStr;

+ (void)toast:(NSString *)toastStr delay:(CGFloat)delay;

/// 在toView上显示loading框
+ (void)showHUDToView:(UIView *)toView;

/// 移除view上的loading框
+ (void)hideHUDFromView:(UIView *)view;

+ (BOOL)isLogin;

@end
```
WJDataHelper是NSUserDefault的存储帮助类
```
@interface WJDataHelper : NSObject

/// 保存配置数据或简单数据
+(void)saveDataInUserDefaults:(NSString *)key value:(nullable id)value;

/// 获取数据
+(id)getDataFromUserDefaults:(NSString *)key;

/// 删除数据
+(void)delDataInUserDefaults:(NSString *)key;

/// 保存可变数组
+(void)saveArrayData:(NSMutableArray *)value key:(NSString *)key;

/// 获取可变数组
+(NSMutableArray *)getArrayData:(NSString *)key;

/// 保存需要归档的数据
+ (void)saveNeedAchiveData:(nullable id)value key:(NSString *)key;

/// 获取需要归档的数据
+ (id)getNeedAchiveData:(NSString *)key;

/// 保存用户信息
+ (void)saveUserInfo:(nullable id)userInfo;

/// 获取用户信息
+ (id)getUserInfo;

@end
```

### network文件
本文件里的内容是基于YYModel和AFNetworking二次封装的网络库，如果你已有自己的网络库请自行替换。以下是对本网络库的说明，具体使用请下载工程自行查看注释
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190329103130670.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NoZW5tb2RleXVnZQ==,size_16,color_FFFFFF,t_70)
### base文件
此文件放的是项目的基类，其中WJBaseSVC是为基于UIScrollView的界面准备的，支持滑动导航栏渐变功能。WJBaseVC中引入了UIViewController+Helpers.h，此类别中有一些常用的方法，所有Controller中都可以使用，以下是类别中包含的方法

```
@interface UIViewController (Helpers)

/// 设置导航栏背景颜色
- (void)setNavBarBackColor:(UIColor *)color;

/// 设置导航栏标题颜色和字体
- (void)setNavBarTitleColor:(UIColor *)titleColor font:(UIFont *)font;

/// push到下一界面
-(void)pushNextVC:(NSString*) nextVcName;

-(void)pushNextVCByInstance:(UIViewController *) nextVC;

/// 替换当前界面
-(void) replaceVC:(NSString*) nextVcName;

-(void) replaceVCWithController:(UIViewController*)vc;

/// 返回到上一界面
-(void)popVC;

/// 返回到根页面
-(void)popToRootVC;

-(void)popToVC:(UIViewController*)vc;

/// 返回到指定的控制器，若没有则会返回上一级
- (void)popToStrVC:(NSString *)vc;

/// 返回到指定的控制器，若没有不会返回上一级
- (void)popToDesignatedVC:(NSString *)vc;

/// 返回前index的视图
- (void)popToIndex:(NSInteger)index;

/// 设置返回按钮
- (UIButton *)setLeftBackBtn:(NSString *)imageName;

/// 设置导航栏左按钮--图片
- (UIButton *)setLeftBtnWithImageName:(NSString *)imageName clickAction:(BtnClickBlock)block;

/// 设置导航栏左按钮--文字
- (UIButton *)setLeftBtnWithTitle:(NSString *)title clickAction:(BtnClickBlock)block;

/// 设置导航栏左按钮--文字
- (UIButton *)setLeftBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont clickAction:(BtnClickBlock)block;

/// 设置导航栏右按钮--本地图片
- (UIButton *)setRightBtnWithImageName:(NSString *)imageName clickAction:(BtnClickBlock)block;

/// 设置导航栏有按钮--网络图片
- (UIButton *)setRightBtnWitnImageUrl:(NSString *)imageUrl clickAction:(BtnClickBlock)block;

/// 设置导航栏有按钮--文字
- (UIButton*)setRightBtnWithTitle:(NSString *)title clickAction:(BtnClickBlock)block;

/// 设置导航栏有按钮--文字
- (UIButton*)setRightBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont clickAction:(BtnClickBlock)block;

/// 当前navigationController下push的VC
@property (nonatomic,strong,readonly) NSArray* navPushControllers;

/// 当前navigationController下push的VC数量
@property (nonatomic,assign,readonly) NSUInteger navPushCount;

@end
```
### macro文件
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190329105101489.png)
此文件中是以下宏定义，
WJ_MEASURE中是一些通用宏定义其中包括颜色宏，字体方法宏，屏幕相关宏等。
WJ_APP_CONFIG中是一些系统配置宏其中包括测试线上版本的控制，加密控制，默认秘钥，BASE_URL等。
WJ_DATAKEY是一些数据存储key和通知key的宏。
WJ_RESPONSE_CODE是网络请求返回状态码的宏
WJCommon是公共文件头文件引入文件，类似pch，只不过需要在相关文件中引入此文件

### main文件
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190329110557942.png)
此文件中放的是main.m和TabBarController文件，可以在TabBar文件中更改主导

### vendors文件
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190329110545882.png)
此文件中放的是一些第三方库，这些第三方库可能不支持pod进行管理，可能需要对对这些库进行修改，也可能是自定义的第三方库。
此文件中已存在的WJWebView是本人对WKWebView进行二次封装的一个库，本项目中已经根据此库创建了一个WJWebVC，跳转网页可以直接拿来用。

```
@interface WJWebVC : WJBaseVC

/**
是否根据网页改变标题
*/
@property (nonatomic,assign) BOOL changeTitle;

/**
是否pop到根页面
*/
@property (nonatomic,assign) BOOL isPopToRoot;

/**
网页参数
*/
@property (nonatomic,strong) NSMutableDictionary *params;

/**
添加网页地址
*/
-(void)addWebView:(NSString*) url;

/**
加载本地html
*/
-(void)addHtmlWebView:(NSString *)name;

@end
```
### categories文件
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190329111936896.png)
此文件中放的是一些通用的类别，一些控件的创建已经封装到对应的类别中可直接使用。

## 工程中使用到第三方库的地方，已进行二次封装
有时候可能因为需求问题，项目中的一些功能需要自定义，例如loading框，这时候项目可能已经完成相当一部分，如果没有进行二次封装，那么整个工程到处都是使用[MBProgressHUD showHUDAddedTo:toView animated:YES]; 这个方法弹出的loading框，那个整个工程的更改就相当耗时，这时候二次封装的好处就可以看出来了，只需要改动封装好的两个方法就可以将整个工程的所有地方的loading框进行更改，很方便。所有我在使用第三方库的时候都会对他进行二次封装。

### AFNetworking和YYModel
这两个库在本工程中的network文件中，如想删除只需删除本文件即可

### GTMBase64
这个库在NSString+Helpers.m文件中使用，在此文件中使用此库进行了DES加密，DES加密会在网络库中使用，如果需求中没有用到DES加密可自行删除

### SDWebImage
这个库在UIImageView+Helper.m中使用过，在此文件中对SDWebImage进行了二次封装，如果想使用网络加载图片就直接使用此文件中的方法即可，如果要更换图片加载库就直接改UIImageView+Helper.m的内容，其它不变。这种方法可以降低本工程和SDWebImage的耦合度。

```
typedef NS_ENUM(NSInteger, ImageUrlType) {
ImageUrlTypeNormal,
ImageUrlTypeSmall,
ImageUrlTypeBig,
};

@interface UIImageView (Helpers)

+(UIImageView *)createImageV;

+(UIImageView *)createImageViewWithImageName:(NSString *)imageName;

+(UIImageView *)createImageViewWithImageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode;

/**
* 加载图片
* @param urlStr   图片地址
*/
- (void)setImageWithUrlStr:(NSString *)urlStr;

/**
* 加载图片
* @param urlStr   图片地址
* @param imageUrlType 图片规格
*/
- (void)setImageWithUrlStr:(NSString *)urlStr imageUrlType:(ImageUrlType)imageUrlType;

/**
* 加载图片
* @param urlStr   图片地址
* @param endBlock 加载结束回调
*/
-(void)setImageWithUrlStr:(NSString *)urlStr endBlock:(nullable void(^)(BOOL isSuccess))endBlock;

/**
* 加载图片
* @param urlStr   图片地址
* @param endBlock 加载结束回调
* @param imageUrlType 图片规格
*/
-(void)setImageWithUrlStr:(NSString *)urlStr endBlock:(nullable void(^)(BOOL isSuccess))endBlock imageUrlType:(ImageUrlType)imageUrlType;

/**
* 加载图片
* @param urlStr   图片地址
* @param placeHolderName 本地缺省图片
*/
- (void)setImageWithUrlStr:(NSString *)urlStr placeHolderName:(NSString *)placeHolderName;

/**
* 加载图片
* @param urlStr   图片地址
* @param placeHolderName 本地缺省图片
* @param imageUrlType 图片规格
*/
- (void)setImageWithUrlStr:(NSString *)urlStr placeHolderName:(NSString *)placeHolderName imageUrlType:(ImageUrlType)imageUrlType;

/**
* 加载图片
* @param urlStr   图片地址
* @param placeHolderName 本地缺省图片
* @param endBlock 加载结束回调
*/
- (void)setImageWithUrlStr:(NSString *)urlStr placeHolderName:(NSString *)placeHolderName endBlock:(nullable void(^)(BOOL isSuccess))endBlock;

/**
* 加载图片
* @param urlStr   图片地址
* @param placeHolderName 本地缺省图片
* @param endBlock 加载结束回调
* @param imageUrlType 图片规格
*/
- (void)setImageWithUrlStr:(NSString *)urlStr placeHolderName:(NSString *)placeHolderName endBlock:(nullable void(^)(BOOL isSuccess))endBlock imageUrlType:(ImageUrlType)imageUrlType;

/**
* 加载图片
* @param urlStr   图片地址
* @param complete 获取到的图片对象
*/
- (void)setImageWithUrlStr:(NSString *)urlStr complete:(UIImage* (^)(UIImage *image))complete;

/**
* 加载图片
* @param urlStr   图片地址
* @param complete 获取到的图片对象
* @param imageUrlType 图片规格
*/
- (void)setImageWithUrlStr:(NSString *)urlStr complete:(UIImage* (^)(UIImage *image))complete imageUrlType:(ImageUrlType)imageUrlType;

/**
* 加载图片
* @param urlStr   图片地址
* @param placeHolderName 缺省图片
* @param complete 获取到的图片对象
* @param imageUrlType 图片规格
*/
- (void)setImageWithUrlStr:(NSString *)urlStr placeHolderName:(nonnull NSString *)placeHolderName complete:(UIImage* (^)(UIImage *image))complete imageUrlType:(ImageUrlType)imageUrlType;

@end
```
### MBProgressHUD
这个库在WJUtils文件中使用过，这里面封装了toast和loading的使用，如果想自定义直接更改.m中的方法即可，工程中所有使用此方法的地方无需理会。

```
+ (void)toast:(NSString *)toastStr;

+ (void)toast:(NSString *)toastStr delay:(CGFloat)delay;

/// 在toView上显示loading框
+ (void)showHUDToView:(UIView *)toView;

/// 移除view上的loading框
+ (void)hideHUDFromView:(UIView *)view;
```

### MJRefresh
这个库在UIScrollView+Helpers.m中使用过，在此文件中对MJRefresh进行了二次封装，继承自UIScrollView的类都可以调用。

```
@interface UIScrollView (Helpers)

+ (UIScrollView *)create;

- (void)scrollToTop;

- (void)scrollToBottom;

- (void)scrollToLeft;

- (void)scrollToRight;

- (void)scrollToTopAnimated:(BOOL)animated;

- (void)scrollToBottomAnimated:(BOOL)animated;

- (void)scrollToLeftAnimated:(BOOL)animated;

- (void)scrollToRightAnimated:(BOOL)animated;

// 自定义下拉刷新
- (void)addCustomRefreshHeader:(void (^)(void))headerBlock;

/**
* 下拉刷新
*/
- (void)addRefreshHeader:(void (^)(void))headerBlock;

/**
* 下拉刷新
* @param isBeginRefresh 是否在刚进来是就刷新
*/
- (void)addRefreshHeader:(void (^)(void))headerBlock isBeginRefresh:(BOOL)isBeginRefresh;

///开始刷新
- (void)beginRefreshing;

/// 移除下拉刷新
- (void)removeRefreshHeader;

/**
* 上拉加载更多
*/
- (void)addRefreshFooter:(void (^)(void))footerBlock;

/** 提示没有更多的数据 */
- (void)endRefreshingWithNoMoreData;

/// 重置没有更多数据
- (void)resetNoMoreData;

/// 结束刷新
- (void)endRefreshing:(BOOL)isHeader;

/// 结束所有刷新
- (void)endAllRefreshing;

@end
```

## 其它内容导航
修改已有XCode项目的名称 和 类名前缀 [传送门](https://blog.csdn.net/qq_23292307/article/details/80915654)
YYModel的使用 [传送门](https://github.com/ibireme/YYModel)
