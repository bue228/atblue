package cn.com.atblue.oa.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.com.atblue.common.bean.PageBean;
import cn.com.atblue.oa.bean.OfficeNotice;
import cn.com.atblue.oa.dao.OfficeNoticeDAO;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

public class OfficeNoticeDAOImpl extends SqlMapClientDaoSupport implements
        OfficeNoticeDAO {

	/**
	 * This method was generated by Apache iBATIS ibator. This method
	 * corresponds to the database table OFFICE_NOTICE
	 * 
	 * @ibatorgenerated Wed Dec 23 09:49:51 CST 2009
	 */ 
	public OfficeNoticeDAOImpl() {
		super();
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method
	 * corresponds to the database table OFFICE_NOTICE
	 * 
	 * @ibatorgenerated Wed Dec 23 09:49:51 CST 2009
	 */
	public int deleteByPrimaryKey(String noticeid) {
		OfficeNotice key = new OfficeNotice();
		key.setNoticeid(noticeid);
		int rows = getSqlMapClientTemplate().delete(
				"OFFICE_NOTICE.ibatorgenerated_deleteByPrimaryKey", key);
		return rows;
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method
	 * corresponds to the database table OFFICE_NOTICE
	 * 
	 * @ibatorgenerated Wed Dec 23 09:49:51 CST 2009
	 */
	public void insert(OfficeNotice record) {
		getSqlMapClientTemplate().insert(
				"OFFICE_NOTICE.ibatorgenerated_insert", record);
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method
	 * corresponds to the database table OFFICE_NOTICE
	 * 
	 * @ibatorgenerated Wed Dec 23 09:49:51 CST 2009
	 */
	public void insertSelective(OfficeNotice record) {
		getSqlMapClientTemplate().insert(
				"OFFICE_NOTICE.ibatorgenerated_insertSelective", record);
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method
	 * corresponds to the database table OFFICE_NOTICE
	 * 
	 * @ibatorgenerated Wed Dec 23 09:49:51 CST 2009
	 */
	public OfficeNotice selectByPrimaryKey(String noticeid) {
		OfficeNotice key = new OfficeNotice();
		key.setNoticeid(noticeid);
		OfficeNotice record = (OfficeNotice) getSqlMapClientTemplate()
				.queryForObject(
						"OFFICE_NOTICE.ibatorgenerated_selectByPrimaryKey", key);
		return record;
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method
	 * corresponds to the database table OFFICE_NOTICE
	 * 
	 * @ibatorgenerated Wed Dec 23 09:49:51 CST 2009
	 */
	public int updateByPrimaryKeySelective(OfficeNotice record) {
		int rows = getSqlMapClientTemplate().update(
				"OFFICE_NOTICE.ibatorgenerated_updateByPrimaryKeySelective",
				record);
		return rows;
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method
	 * corresponds to the database table OFFICE_NOTICE
	 * 
	 * @ibatorgenerated Wed Dec 23 09:49:51 CST 2009
	 */
	public int updateByPrimaryKeyWithBLOBs(OfficeNotice record) {
		int rows = getSqlMapClientTemplate().update(
				"OFFICE_NOTICE.ibatorgenerated_updateByPrimaryKeyWithBLOBs",
				record);
		return rows;
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method
	 * corresponds to the database table OFFICE_NOTICE
	 * 
	 * @ibatorgenerated Wed Dec 23 09:49:51 CST 2009
	 */
	public int updateByPrimaryKeyWithoutBLOBs(OfficeNotice record) {
		int rows = getSqlMapClientTemplate().update(
				"OFFICE_NOTICE.ibatorgenerated_updateByPrimaryKey", record);
		return rows;
	}

	public List selectAllByDepartment(PageBean pb, Map map) {
		map.put("currentPage", pb.getCurrentPage());
		map.put("pageSize", pb.getPageSize());
		return getSqlMapClientTemplate().queryForList(
				"OFFICE_NOTICE.selectAllByDepartment", map);
	}

	public int selectAllByDepartment(Map map) {
		return (Integer) getSqlMapClientTemplate().queryForObject(
				"OFFICE_NOTICE.selectAllByDepartmentCount", map);
	}

	public String getStatus(String status) {
		if (status != null && status.equals("0")) {
			return "�ݸ�";
		} else {
			return "����";
		}
	}

	public String getSummary(String content, int offset) throws Exception {
		return "";
	}

	public List getExpiredNotice(String userid, PageBean pb) {
		Map map = new HashMap();
		map.put("currentPage", pb.getCurrentPage());
		map.put("pageSize", pb.getPageSize());
		map.put("userid", userid);
		return getSqlMapClientTemplate().queryForList("OFFICE_NOTICE.getExpiredNotice", map);
	}

	public int getExpiredNoticeCount(String userid) {
		Map map = new HashMap();
		map.put("userid", userid);
		return (Integer)getSqlMapClientTemplate().queryForObject("OFFICE_NOTICE.getExpiredNoticeCount", map);
	}

	public List getNowNotice(String userid, PageBean pb) {
		Map map = new HashMap();
		map.put("currentPage", pb.getCurrentPage());
		map.put("pageSize", pb.getPageSize());
		map.put("userid", userid);
		//System.out.println(getSqlMapClientTemplate().queryForList("OFFICE_NOTICE.getNowNotice", map).size());
		return getSqlMapClientTemplate().queryForList("OFFICE_NOTICE.getNowNotice", map);
	}

	public int getNowNoticeCount(String userid) {
		Map map = new HashMap();
		map.put("userid", userid);
		return (Integer)getSqlMapClientTemplate().queryForObject("OFFICE_NOTICE.getNowNoticeCount", map);
	}
	
	public static void main(String[] args){
		System.out.println(111);
	}


}