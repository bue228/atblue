<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="../../../import.jsp"%>
<%
	String sqid = request.getParameter("sqid");
    if(!StringUtil.isBlankOrEmpty(sqid)){
        Map map = new HashMap();
        map.put("sqid",sqid);
        officeHysqDAO.delOfficeHysq(map);
    }
    response.sendRedirect("index.jsp");
%>