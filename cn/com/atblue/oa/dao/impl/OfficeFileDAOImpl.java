package cn.com.atblue.oa.dao.impl;

import java.util.List;

import cn.com.atblue.oa.dao.OfficeFileDAO;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.com.atblue.oa.bean.OfficeFile;

public class OfficeFileDAOImpl extends SqlMapClientDaoSupport implements OfficeFileDAO {

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table OFFICE_FILE
     *
     * @ibatorgenerated Wed Dec 23 15:08:35 CST 2009
     */
    public OfficeFileDAOImpl() {
        super();
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table OFFICE_FILE
     *
     * @ibatorgenerated Wed Dec 23 15:08:35 CST 2009
     */
    public int deleteByPrimaryKey(String pkid) {
        OfficeFile key = new OfficeFile();
        key.setPkid(pkid);
        int rows = getSqlMapClientTemplate().delete("OFFICE_FILE.ibatorgenerated_deleteByPrimaryKey", key);
        return rows;
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table OFFICE_FILE
     *
     * @ibatorgenerated Wed Dec 23 15:08:35 CST 2009
     */
    public void insert(OfficeFile record) {
        getSqlMapClientTemplate().insert("OFFICE_FILE.ibatorgenerated_insert", record);
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table OFFICE_FILE
     *
     * @ibatorgenerated Wed Dec 23 15:08:35 CST 2009
     */
    public void insertSelective(OfficeFile record) {
        getSqlMapClientTemplate().insert("OFFICE_FILE.ibatorgenerated_insertSelective", record);
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table OFFICE_FILE
     *
     * @ibatorgenerated Wed Dec 23 15:08:35 CST 2009
     */
    public OfficeFile selectByPrimaryKey(String pkid) {
        OfficeFile key = new OfficeFile();
        key.setPkid(pkid);
        OfficeFile record = (OfficeFile) getSqlMapClientTemplate().queryForObject("OFFICE_FILE.ibatorgenerated_selectByPrimaryKey", key);
        return record;
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table OFFICE_FILE
     *
     * @ibatorgenerated Wed Dec 23 15:08:35 CST 2009
     */
    public int updateByPrimaryKeySelective(OfficeFile record) {
        int rows = getSqlMapClientTemplate().update("OFFICE_FILE.ibatorgenerated_updateByPrimaryKeySelective", record);
        return rows;
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table OFFICE_FILE
     *
     * @ibatorgenerated Wed Dec 23 15:08:35 CST 2009
     */
    public int updateByPrimaryKey(OfficeFile record) {
        int rows = getSqlMapClientTemplate().update("OFFICE_FILE.ibatorgenerated_updateByPrimaryKey", record);
        return rows;
    }
    
    public List getByFk(String fk){
    	return getSqlMapClientTemplate().queryForList("OFFICE_FILE.getByFk", fk);
    	
    }
}