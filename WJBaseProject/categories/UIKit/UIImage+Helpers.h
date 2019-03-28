//
//  UIImage+Helpers.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/21.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Helpers)

/// 获取一个1X1的给定颜色的图片
+ (UIImage *)imageWithColor:(UIColor *)color;

/// 获取一个指定大小颜色的图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/// 创建并返回带有自定义绘图代码的图像。
+ (UIImage *)imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock;

/// 此图像是否具有alpha通道。
- (BOOL)hasAlphaChannel;


/**
 在指定矩形中绘制整个图像，内容随ContentMode更改。
 @param rect 指定大小
 @param contentMode 内容显示模式
 @param clips 超出范围是否裁剪
 */
- (void)drawInRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode clipsToBounds:(BOOL)clips;

/// 返回从该图像缩放的新图像。图像将根据需要进行拉伸。
- (UIImage *)imageByResizeToSize:(CGSize)size;


/// 返回从该图像缩放的新图像。图像内容将用ContentMode更改。
- (UIImage *)imageByResizeToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;

/// 返回从该图像中剪切的新图像
- (UIImage *)imageByCropToRect:(CGRect)rect;


/**
 返回一个将边缘替换颜色的新的UIImage

 @param insets 边缘距离
 @param color nil为clearColor
 @return 处理后的image
 */
- (UIImage *)imageByInsetEdge:(UIEdgeInsets)insets withColor:(UIColor *)color;

/// 返回裁切为圆角后的图片
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius;

/// 返回带边框的圆角的图片
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor;


/**
 返回带边框的圆角图片
 @param radius 圆角大小
 @param corners 圆角方向
 @param borderWidth 边框宽度
 @param borderColor 边框颜色 nil为clearColor
 @param borderLineJoin 边界线连接类型
 @return 新的图片
 */
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin;


/**
 返回新的旋转图像（相对于中心）。

 @param radians 逆时针旋转的弧度。⟲
 @param fitSize YES：新图像的大小将根据所有内容进行扩展。
                NO：图像大小不会更改，内容可能会被剪切。
 @return 新的图片
 */
- (UIImage *)imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;

/// 逆时针旋转90度⤺
- (UIImage *)imageByRotateLeft90;

/// 顺时针旋转90度⤼
- (UIImage *)imageByRotateRight90;

/// 旋转180度↻
- (UIImage *)imageByRotate180;

/// 垂直翻转⥯
- (UIImage *)imageByFlipVertical;

/// 水平翻转⇋
- (UIImage *)imageByFlipHorizontal;

/// 用给定的颜色在alpha通道中着色图像。
- (UIImage *)imageByTintColor:(UIColor *)color;

/// 返回灰度图像
- (UIImage *)imageByGrayscale;

/// 对此图像应用模糊效果。适合模糊任何内容。
- (UIImage *)imageByBlurSoft;

/// 对此图像应用模糊效果。适用于除纯白外的任何内容的模糊处理。
- (UIImage *)imageByBlurLight;

/// 对此图像应用模糊效果。适合显示黑色文本。
- (UIImage *)imageByBlurExtraLight;

/// 对此图像应用模糊效果。适用于显示白色文本。
- (UIImage *)imageByBlurDark;

/// 对此图像应用模糊和淡色。
- (UIImage *)imageByBlurWithTint:(UIColor *)tintColor;

/**
 对该图像应用模糊、淡色和饱和度调整，（可选）在@a maskimage指定的区域内。
 @param blurRadius 点中的模糊半径，0表示没有模糊效果。
 @param tintColor 一个可选的uicolor对象，与模糊和饱和度操作的结果均匀混合。这种颜色的alpha通道决定了色调   是nil表示没有颜色。
 @param tintBlendMode tintcolor混合模式。默认值为kcgBlendModeNormal
 @param saturation 值1.0不会对生成的图像产生任何更改。小于1.0的值将使生成的图像去饱和 而大于1.0的值将产生相反的效果。0表示灰度。
 @param maskImage 如果指定，inputimage仅在区域中修改由该掩码定义。这必须是一个图像蒙版或它 必须满足mask参数CGContextClipToMask
 @return 新的图像
 */
- (UIImage *)imageByBlurRadius:(CGFloat)blurRadius
                     tintColor:(nullable UIColor *)tintColor
                      tintMode:(CGBlendMode)tintBlendMode
                    saturation:(CGFloat)saturation
                     maskImage:(nullable UIImage *)maskImage;

/// 角度转弧度
+ (CGFloat)degreesToRadians:(CGFloat)degrees;

/// 弧度转角度
+ (CGFloat)radiansToDegrees:(CGFloat)radians;

@end

NS_ASSUME_NONNULL_END
