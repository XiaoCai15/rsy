package com.rsy.auth.servlet;

import com.rsy.entity.Users;
import com.rsy.service.AuthService;
import com.rsy.serviceImpl.AuthServiceImpl;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 添加核准件
 */
public class InsertAuthServlet extends HttpServlet {
    private static AuthService authService = new AuthServiceImpl();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Map<String,String> authMap = new HashMap<String,String>();
        authMap.put("usercode", ((Users) request.getSession().getAttribute("user")).getUsercode());
        boolean upfileok = true;
        String path = null;

        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.getSizeThreshold();

        //设置缓冲区大小与临时文件目录
        factory.setSizeThreshold(1024*1024*10);
        //文件的临时存储目录
        String tmpPath = this.getServletContext().getRealPath("/tmp");;
        factory.setRepository(new File(tmpPath));

        //解析器文件上传的核心对象
        ServletFileUpload upload=new ServletFileUpload(factory);

        //设置单个文件大小限制
        upload.setFileSizeMax(1024*1024*10);
        //设置所有文件总和大小限制
        upload.setSizeMax(1024*1024*30);
        try {
            List<FileItem> list=upload.parseRequest(request);
            String orgcode = null;
            for (FileItem fileitem:list) {
                if (fileitem.isFormField()){
                    String name = fileitem.getFieldName();//getFieldName方法用于返回表单标签name属性的值。
                    String value = fileitem.getString("UTF-8");
                    authMap.put(name,value);
                    if ("orgcode".equals(name)){
                        orgcode = value;
                    }
                }else {
                    String oldFileName = fileitem.getName();
                    String newFileName = orgcode + oldFileName.substring(oldFileName.lastIndexOf("."));
                    authMap.put("filename",newFileName);
                    path = this.getServletContext().getRealPath("/authFile")+"/"+newFileName;
                    fileitem.write(new File(path));
                }
            }
        } catch (Exception e) {
            upfileok = false;
            e.printStackTrace();
        }
        if (upfileok){
            boolean saveok = authService.saveAuth(authMap);
            if (saveok){
                response.sendRedirect("/egov/auth/inputOrg.jsp");
            }else {
                File file = new File(path);
                file.delete();
            }
        }else {
            String error = "文件上传失败，请重新填写";
            request.setAttribute("error",error);
            request.getRequestDispatcher("/auth/openAccountAuthDetail.jsp").forward(request,response);
        }


    }
    /**
     * FileItem类的常用方法：
     *
     * 1.  boolean isFormField()
     *
     *         isFormField方法用于判断FileItem类对象封装的数据是一个普通文本表单字段，还是一个文件表单字段，如果是普通表单字段则返回true，否则返回false。因此，可以使用该方法判断是否为普通表单域，还是文件上传表单域。
     *
     * 2.  String getName()
     *        getName方法用于获得文件上传字段中的文件名。
     *
     *        注意IE或FireFox中获取的文件名是不一样的，IE中是绝对路径，FireFox中只是文件名。
     *
     * 3.  String getFieldName()
     *       getFieldName方法用于返回表单标签name属性的值。如上例中<input type="text" name="column" />的value。
     *
     * 4.  void write(File file)
     *
     *         write方法用于将FileItem对象中保存的主体内容保存到某个指定的文件中。如果FileItem对象中的主体内容是保存在某个临时文件中，该方法顺利完成后，临时文件有可能会被清除。该方法也可将普通表单字段内容写入到一个文件中，但它主要用途是将上传的文件内容保存在本地文件系统中。
     *
     * 5.  String getString()
     *       getString方法用于将FileItem对象中保存的数据流内容以一个字符串返回，它有两个重载的定义形式：
     *
     *       public java.lang.String getString()
     *
     *       public java.lang.String getString(java.lang.String encoding)
     *
     *              throws java.io.UnsupportedEncodingException
     *
     *         前者使用缺省的字符集编码将主体内容转换成字符串，后者使用参数指定的字符集编码将主体内容转换成字符串。如果在读取普通表单字段元素的内容时出现了中文乱码现象，请调用第二个getString方法，并为之传递正确的字符集编码名称。
     *
     * 6.  String getContentType()
     *         getContentType 方法用于获得上传文件的类型，即表单字段元素描述头属性“Content-Type”的值，如“image/jpeg”。如果FileItem类对象对应的是普通表单字段，该方法将返回null。
     *
     * 7.  boolean isInMemory()
     *         isInMemory方法用来判断FileItem对象封装的数据内容是存储在内存中，还是存储在临时文件中，如果存储在内存中则返回true，否则返回false。
     *
     * 8.  void delete()
     *        delete方法用来清空FileItem类对象中存放的主体内容，如果主体内容被保存在临时文件中，delete方法将删除该临时文件。
     *
     *         尽管当FileItem对象被垃圾收集器收集时会自动清除临时文件，但及时调用delete方法可以更早的清除临时文件，释放系统存储资源。另外，当系统出现异常时，仍有可能造成有的临时文件被永久保存在了硬盘中。
     *
     * 9.  InputStream getInputStream()
     *     以流的形式返回上传文件的数据内容。
     *
     * 10. long getSize()
     *       返回该上传文件的大小（以字节为单位）。
     */
}
