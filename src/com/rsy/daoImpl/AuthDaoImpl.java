package com.rsy.daoImpl;

import com.rsy.dao.AuthDao;
import com.rsy.entity.Auth;
import com.rsy.util.JdbcUtil;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

public class AuthDaoImpl implements AuthDao {

    @Override
    public int saveAuth(Map<String, String> authMap) throws SQLException {
        PreparedStatement ps = null;
        JdbcUtil jdbcUtil = new JdbcUtil();
        int rs = 0;


        String sql = "insert into t_auth(orgcode,remark,contactman,contacttel,filename,fileremark,usercode,feedback) values(?,?,?,?,?,?,?,0)";
      /*orgcode
        remark
        contactman
        contacttel
        filename
        fileremark
        authno
        usercode
        feedback*/
        ps = jdbcUtil.createStatement(sql);
        ps.setString(1,authMap.get("orgcode"));
        ps.setString(2,authMap.get("remark"));
        ps.setString(3,authMap.get("contactman"));
        ps.setString(4,authMap.get("contacttel"));
        ps.setString(5,authMap.get("filename"));
        ps.setString(6,authMap.get("fileremark"));
        ps.setString(7,authMap.get("usercode"));
        rs = ps.executeUpdate();
        jdbcUtil.close(ps);
        return rs;
    }

    @Override
    public Auth findByAuthno(String authno) {
        Auth auth = null ;
        PreparedStatement ps = null;
        JdbcUtil jdbcUtil = new JdbcUtil();
        ResultSet rs = null;
        String sql = "select e.regdate,a.contactman,a.contacttel,e.regcap,e.regcry from t_enterprise as e join t_auth a on e.orgcode=a.orgcode where a.authno=?";

        try {
            ps = jdbcUtil.createStatement(sql);
            ps.setString(1,authno);
            rs = ps.executeQuery();
            if (rs.next()){
                auth = new Auth();
                auth.setAuthno(authno);
                auth.setRegdate(rs.getString("regdate"));
                auth.setContactman(rs.getString("contactman"));
                auth.setContacttel(rs.getString("contacttel"));
                auth.setRegcap(rs.getString("regcap"));
                auth.setRegcry(rs.getString("regcry"));

            }
        } catch (SQLException e) {

            e.printStackTrace();
            throw new RuntimeException("添加失败");
        }finally {
            jdbcUtil.rsClose(rs);
            jdbcUtil.close(ps);
        }

        return auth;
    }

    @Override
    public int upFeedBack(String authno) {
        PreparedStatement ps = null;
        JdbcUtil jdbcUtil = new JdbcUtil();
        int rs = 0;
        String sql = "update t_auth set feedback='1' where authno=?";
        try {
            ps = jdbcUtil.createStatement(sql);
            ps.setString(1,authno);
            rs = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("反馈失败");
        }finally {
            jdbcUtil.close(ps);
        }


        return rs;
    }
}
