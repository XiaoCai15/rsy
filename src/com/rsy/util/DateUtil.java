package com.rsy.util;

import java.text.SimpleDateFormat;
import java.util.Date;
/*
 * 日期工具类
 * */
public class DateUtil {
    /**
     * 日期格式化
     * @param data 日期
     * @param pattern 格式
     * @return
     */
    public  static String format(Date data,String pattern){
        return new SimpleDateFormat(pattern).format(data);
    }
}
