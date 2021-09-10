package com.rsy.util;

import com.rsy.entity.Invest;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Enumeration;
import java.util.Locale;

/**
 * 使用反射机制封装request.getParameter("")
 *
 */
public class WebUtil {
    public static void makeRequestToObject(HttpServletRequest request, Object obj) {

            //获取字节码
            Class c = obj.getClass();
            /*
               request.getParameterNames()方法是将发送请求页面中form表单里所有具有name属性的表单对象获取(包括button).返回一个Enumeration类型的枚举.
                通过Enumeration的hasMoreElements()方法遍历.再由nextElement()方法获得枚举的值.此时的值是form表单中所有控件的name属性的值.
                最后通过request.getParameter()方法获取表单控件的value值.
             */
            Enumeration<String> parameterNames = request.getParameterNames();


                while (parameterNames.hasMoreElements()) {
                    //获取属性名
                    String fieldName = parameterNames.nextElement();
                    //获取方法名
                    String methodName = "set" + fieldName.toUpperCase().charAt(0) + fieldName.substring(1);
                    try {
                        /*当前端出现类中没有的属性，出现异常接着继续while循环*/
                        //获取调用的方法
                        Method setMethod = c.getDeclaredMethod(methodName, String.class);
                        //调用set方法 obj方法所在的类的对象（new）
                         setMethod.invoke(obj, request.getParameter(fieldName));
                    } catch (Exception e) {
                       // e.printStackTrace();
                    }
                }

           /*
           不行，类中有的属性值在前端页面没有
           Class c = obj.getClass();
            Field[] fields = c.getFields();
            for (Field field:fields){
                Modifier.toString(field.getModifiers())//修饰符
                field.getType().getSimpleName();//类型简称
                field.getName();//属性名
            }
*/

    }

}
