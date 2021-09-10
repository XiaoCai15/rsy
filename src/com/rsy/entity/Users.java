package com.rsy.entity;

public class Users {
    private String usercode;
    private String username;
    private String orgtype;
    private String userpswd;
    private String  regdate;

    public String getRegdate() {
        return regdate;
    }

    public void setRegdate(String regdate) {
        this.regdate = regdate;
    }

    public String getUserpswd() {
        return userpswd;
    }
    public void setUserpswd(String userpswd) {
        this.userpswd = userpswd;
    }
    public String getUsercode() {
        return usercode;
    }

    public void setUsercode(String usercode) {
        this.usercode = usercode;
    }

    public String getUesrname() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getOrgtype() {
        return orgtype;
    }

    public void setOrgtype(String orgtype) {
        this.orgtype = orgtype;
    }
}
