package com.rsy.util;

import java.sql.*;

public class JdbcUtil {
    private static String url = "jdbc:mysql://localhost:3306/egov?useSSL=false&characterEncoding=utf8&serverTimezone=UTC";
    private static String username="root";
    private static String password="190909";
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet result = null ;
    /**
     * 放在ThreadLocal是线程安全的，一个线程一个连接对象
     */
    private static ThreadLocal<Connection> threadLocal = new ThreadLocal<Connection>();

    static{

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("加载驱动类失败");
        }

    }
    public Connection getCon() throws SQLException {
        con = threadLocal.get();
        if (con == null){
            con =  DriverManager.getConnection(url,username,password);
            threadLocal.set(con);
        }
        return con;
    }
    public PreparedStatement createStatement(String sql) throws SQLException {
        return ps = getCon().prepareStatement(sql);
    }
    public PreparedStatement createStatement(Connection con,String sql) throws SQLException {
        this.con = con;
        return ps = con.prepareStatement(sql);
    }
    public void close(){

        if(ps!=null){
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if(con!=null){
            try {
                con.close();
                threadLocal.remove();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }
    public  void close(ResultSet rs){
        if(rs!=null){
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        close();
    }
    public void close(Connection con){
        if (con!=null){
            try {
                threadLocal.remove();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public void close(PreparedStatement ps){
        if (ps!=null){
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public void rsClose(ResultSet rs){
        if(rs!=null){
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
