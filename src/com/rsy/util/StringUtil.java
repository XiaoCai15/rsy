package com.rsy.util;

import java.util.ResourceBundle;

/**
 * 字符串工具类
 */
public class StringUtil {
    /*工具类构造方法一般私有化*/
    private StringUtil(){}

    /**
     * static 执行时机
     *当一个类被主动使用时，Java虚拟就会对其初始化，如下六种情况为主动使用：
     *
     * 当创建某个类的新实例时（如通过new或者反射，克隆，反序列化等）
     * 当调用某个类的静态方法时
     * 当使用某个类或接口的静态字段时
     * 当调用Java API中的某些反射方法时，比如类Class中的方法，或者java.lang.reflect中的类的方法时
     * 当初始化某个子类时
     * 当虚拟机启动某个被标明为启动类的类（即包含main方法的那个类）
     *
     * Java编译器会收集所有的类变量初始化语句和类型的静态初始化器，将这些放到一个特殊的方法中：clinit
     *
     */
    /*调用静态方法会执行*/
    private static ResourceBundle bundle = ResourceBundle.getBundle("com.rsy.resource.users");
    /**
     * 通过属性配置文件中的key获取value
     */
    public static String  getTextBycode(String code){
        return bundle.getString(code);
    }

    /**
     *
     * @param code
     * @return
     */
    public static String  getTextBycode(String s,String code){
        return bundle.getString(s + code);
    }
    /**
     * 判断字符串是否为空
     * @param str
     * @return true不为空 false为空
     */
    public static boolean isNotEmpty(String str){
        return str != null && str.trim().length() != 0;
    }
}
