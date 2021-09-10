package com.rsy.entity;

import java.util.ArrayList;
import java.util.List;

public class Page<T> {
    private Integer pageno;   //第几页
    private Integer totalsize;//总记录条数
    private Integer pageCount;//总页数
    private Integer pagesize; //每页的记录条数
    private List<T> dataList;



    public Page() {
    }
    public Page(String pageno){
        if(pageno != null) {
            this.pageno = Integer.parseInt(pageno);
        }else {
            this.pageno = 1;
        }
        this.dataList = new ArrayList<T>();
    }
    public Page(Integer pageno, Integer totalsize, Integer pageCount, Integer pagesize) {
        this.pageno = pageno;
        this.totalsize = totalsize;
        this.pageCount = pageCount;
        this.pagesize = pagesize;
    }


    public Integer getPageno() {
        return pageno;
    }

    public void setPageno(Integer pageno) {
        if(pageno != null) {
            this.pageno = pageno;
        }else {
            this.pageno = 1;
        }

    }

    public Integer getTotalsize() {
        return totalsize;
    }

    public void setTotalsize(Integer totalsize) {
        this.totalsize = totalsize;
    }

    public Integer getPageCount() {
        return pageCount = totalsize % pagesize == 0 ? totalsize/pagesize : totalsize/pagesize + 1;
    }

   /* public void setPageCount(Integer pageCount) {
        this.pageCount = pageCount;
    }
*/
    public Integer getPagesize() {
        return pagesize;
    }

    public void setPagesize(Integer pagesize) {
        this.pagesize = pagesize;
    }
    public List<T> getDataList() {
        return dataList;
    }
}
