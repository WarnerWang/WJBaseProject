//
//  NSDate+Helpers.h
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/21.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Helpers)

///获取当前系统日期
+ (NSDate *)localDate;

/// 返回格式化时间
+ (NSString *)dateFormatter:(NSString *)formatterStr date:(NSDate *)date;

/// 根据格式化时间返回date对象
+ (NSDate *)dateStr:(NSString *)dateStr dateFormatter:(NSString *)formatterStr;

/// 将字符串时间转换为另一种格式的字符串时间
+ (NSString *)dateFormatter:(NSString *)formatterStr dateStr:(NSString *)dateStr;

/// 字符串格式时间转NSDate
+(NSDate *)getDateFromStr:(NSString *)timeStr;

/// date转String(yyyy-MM-dd HH:mm:ss)
+(NSString *)getDateStrFromDate:(NSDate *)date;

/// 转换时间戳时间，返回为NSdate型
+(NSDate *)getDateFromLongLong:(long long)time;

/// 获取指定信息的日期组件
+ (NSDateComponents *)getDateComponentsWithDate:(NSDate *)date unitFlags:(NSCalendarUnit)unitFlags;

/// 获取包含年月日时分秒的日期组件
+ (NSDateComponents *)getDateComponentsWithDate:(NSDate *)date;

/// 获得某一个时间对应的凌晨时间
+ (NSDate *)getDayStartDate:(NSDate *)date;

/// 获取两个时间间隔的指定日期组件
+ (NSDateComponents *)getDateComponentWithUnit:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/// 获得两个时间的间隔秒数
+ (NSInteger)getIntrvalSecondFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/**
 判断两个时间是否是同一天
 */
+ (BOOL)isSameDay:(NSDate *)date1 data2:(NSDate *)date2;



@property (nonatomic, readonly) NSInteger year; ///< Year component
@property (nonatomic, readonly) NSInteger month; ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger day; ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger hour; ///< Hour component (0~23)
@property (nonatomic, readonly) NSInteger minute; ///< Minute component (0~59)
@property (nonatomic, readonly) NSInteger second; ///< Second component (0~59)
@property (nonatomic, readonly) NSInteger nanosecond; ///< Nanosecond component
@property (nonatomic, readonly) NSInteger weekday; ///< Weekday component (1~7, first day is based on user setting)
@property (nonatomic, readonly) NSInteger weekdayOrdinal; ///< WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger weekOfMonth; ///< WeekOfMonth component (1~5)
@property (nonatomic, readonly) NSInteger weekOfYear; ///< WeekOfYear component (1~53)
@property (nonatomic, readonly) NSInteger yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger quarter; ///< Quarter component
@property (nonatomic, readonly) BOOL isLeapMonth; ///< whether the month is leap month
@property (nonatomic, readonly) BOOL isLeapYear; ///< whether the year is leap year
@property (nonatomic, readonly) BOOL isToday; ///< whether date is today (based on current locale)
@property (nonatomic, readonly) BOOL isYesterday; ///< whether date is yesterday (based on current locale)

#pragma mark - Date modify
///=============================================================================
/// @name Date modify
///=============================================================================

/** years后的同一天 */
- (nullable NSDate *)dateByAddingYears:(NSInteger)years;

/** months后的同一天 */
- (nullable NSDate *)dateByAddingMonths:(NSInteger)months;

/** weaks后的同一天 */
- (nullable NSDate *)dateByAddingWeeks:(NSInteger)weeks;

/** days后的同一天 */
- (nullable NSDate *)dateByAddingDays:(NSInteger)days;

/** hours小时后的时间 */
- (nullable NSDate *)dateByAddingHours:(NSInteger)hours;

/** minutes分钟后的时间 */
- (nullable NSDate *)dateByAddingMinutes:(NSInteger)minutes;

/** seconds秒后的时间 */
- (nullable NSDate *)dateByAddingSeconds:(NSInteger)seconds;

@end

NS_ASSUME_NONNULL_END
