<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.Date"%>
<%@ include file="../../../import.jsp"%>
<%
    CUser cUser = (CUser)session.getAttribute("cUser");
    cUser = cUser == null?new CUser():cUser;
    OfficeCirculationDAO officeCirculationDAO = (OfficeCirculationDAO)SpringFactory.instance.getBean("officeCirculationDAO");
    OfficeCirculationCheckDAO officeCirculationCheckDAO = (OfficeCirculationCheckDAO)SpringFactory.instance.getBean("officeCirculationCheckDAO");
    String pkid = request.getParameter("pkid");
    String act = request.getParameter("act");
    List checkList = oDao.getOfficeCirculationCheckList(pkid);
    String[] checkmans = new String[1];
    checkmans[0] = "";
    String checkman = "";
    if(checkList != null && checkList.size() > 0){
        checkmans = new String[checkList.size()];
        for(int i=0; i<checkList.size(); i++){
            Map map = (Map)checkList.get(i);
            String name = StringUtil.parseNull(map.get("REAL_NAME"),"");
            String checkflag = StringUtil.parseNull(map.get("CHECKFLAG"),"");
            if("1".equals(checkflag)){
                checkman = checkman + "<font color='green'>"+name +"</font>;";
            }else{
                checkman = checkman + "<font color='red'>"+name +"</font>;";
            }
            checkmans[i] = StringUtil.parseNull(map.get("CHECKMAN"),"");
        }
    }
    OfficeCirculation document = null;
    try{
        document = officeCirculationDAO.selectByPrimaryKey(pkid);
    }catch(Exception e){
        e.printStackTrace();
    }
    List hasFileList = officeFileDAO.getByFk(pkid);
//    OfficeCirculationCheck officeCirculationCheck = officeCirculationCheckDAO.selectByPrimaryCyid(pkid);
//    if(officeCirculationCheck==null) officeCirculationCheck = new OfficeCirculationCheck();
    List userList  = dao.getGsldAllUser();
    List userList1  = dao.getJgksAllUser();
    List userList2  = dao.getJcdwAllUser();
    userList = userList == null?new ArrayList():userList;
    userList1 = userList1 == null?new ArrayList():userList1;
    userList2 = userList2 == null?new ArrayList():userList2;
    if("sign".equals(act)){
        oDao.updateOfficeCirculationCheck(cUser.getUserId(),pkid);
        boolean isAllChecked = oDao.isAllCirculationCheck(pkid);
        if(isAllChecked && document != null){
            document.setZt("传阅完成");
            officeCirculationDAO.updateByPrimaryKey(document);
        }
        out.print("<script>");
        out.print("window.location='check_index.jsp';");
        out.print("</script>");
    }

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
    <script src="<%=contentPath%>/js/common.js"
            type="text/javascript" defer="true"></script>
    <link href="<%=contentPath%>/css/css.css" rel="stylesheet" type="text/css">
    <link href="<%=contentPath%>/images/css.css" rel="stylesheet" type="text/css">
    <link href="<%=request.getContextPath()%>/js/ext/resources/css/ext-all.css" rel="stylesheet" type="text/css">
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/js/ext/adapter/ext/ext-base.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/ext/ext-all.js"></script>

    <script type="text/javascript">
        function checkForm(){
            document.all.act.value = "sign";
            document.form1.submit();
        }

        /****************
         * 生成多个附件
         * chivasju
         ****************/
        var fileCount = 1;
        function addFile(){
            fileCount++;
            var fileTd = document.getElementById("fileTd");
            var fileTable = document.getElementById("mtabtab");
            var tableRows  = fileTable.getElementsByTagName("tr");
            var objTR = fileTable.insertRow();
            var objTD = objTR.insertCell();
            objTD.innerHTML = "<td nowrap='nowrap' width='120' class='head_left'>&nbsp;</td>";
            objTD = objTR.insertCell();
            objTD.innerHTML += "<td class='head_right' align='left'>"
            objTD.innerHTML += fileCount +  ".&nbsp;&nbsp;&nbsp;<input type='file' name='file_" + fileCount + "' style='width: 400px;'></td>";
        }
        function delFile(pkid, fkid){
            var ajax = GetO();
            if(window.confirm("是否删除该附件?")){
                ajax.open("GET", "./delete_file.jsp?pkid=" + pkid + "&fkid=" + fkid, false);
                ajax.setRequestHeader("If-Modified-Since","0");
                ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                ajax.setRequestHeader("Content-Type","text/html; encoding=gb18030");
                ajax.onreadystatechange = function() {
                    if (ajax.readyState == 4) {
                        var rtnStr = ajax.responseText;
                        document.getElementById('hasFile').innerHTML = rtnStr;
                    }
                }
                ajax.send(null);
            }
        }
    </script>

    <script type="text/javascript">
        function lbz(obj){
            document.form1.wjbh.value=obj.value;
        }
        Ext.onReady(function(){
            var win;
            var button = Ext.get('checkman');

            button.on('click', function(){
                // create the window on the first click and reuse on subsequent clicks
                if(!win){
                    win = new Ext.Window({
                        applyTo:'hello-win',
                        layout:'fit',
                        width:500,
                        height:400,
                        closeAction:'hide',
                        plain: true,
                        pageX:100,
                        pageY:100,
                        items: new Ext.TabPanel({
                            applyTo: 'hello-tabs',
                            autoTabs:true,
                            activeTab:0,
                            deferredRender:false,
                            border:false,
                            defaults:{autoScroll: true}
                        }),
                        buttons: [{
                            text:'确定',
                            handler: function(){
                                document.form1.checkman.value = "";
                                for(var i=0; i<document.form1.ubox.length; i++){
                                    if(document.form1.ubox[i].checked){
                                        document.form1.checkman.value+=document.form1.ubox[i].title + ";";
                                    }
                                    //document.form1.ubox[i].checked=obj.checked;
                                }
                                win.hide();
                            }
                        },{
                            text: '关闭',
                            handler: function(){
                                win.hide();
                            }
                        }]
                    });
                }
                win.show(this);
            });
        });
        function checkPartAll(obj,alt){
            for(var i=0; i<document.form1.ubox.length; i++){
                if(document.form1.ubox[i].getAttribute("alt") == alt){
                    document.form1.ubox[i].checked=obj.checked;
                }
            }
        }

        function checkPartNot(obj,alt){
            for(var i=0; i<document.form1.ubox.length; i++){
                if(document.form1.ubox[i].getAttribute("alt")  == alt){
                    document.form1.ubox[i].checked=!document.form1.ubox[i].checked;
                }
            }
        }
    </script>
</head>
<body onload="_resizeNoPage();">
<form name="form1" method="post">
    <input type="hidden" name="act" value="sign">
    <input type="hidden" name="pkid" value="<%=pkid%>">
    <div id="hello-win" class="x-hidden">
        <div id="hello-tabs">
            <div class="x-tab" title="请选择签收用户">
                <table border="0" width="100%">
                    <tr>
                        <td colspan="6" align="left">
                            <input type="checkbox" name="allBox" onclick="checkAll(this);">全选&nbsp;
                            <input type="checkbox" name="allBox" onclick="checkUnAll();">反选&nbsp;
                            <hr width="100%">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" align="left">
                            <hr width="100%">
                            <h2>公司领导</h2>
                            <input type="checkbox" onclick="checkPartAll(this,'gsld');"/>全选<input type="checkbox"  onclick="checkPartNot(this,'gsld');"/>反选
                            <hr width="100%">
                        </td>
                    </tr>
                    <%for(int i=0; i<userList.size(); i++){
                        CUser u = (CUser)userList.get(i);
                        if(i==0){
                    %>
                    <tr>
                        <td><input type="checkbox" name="ubox"  <%if(StringUtil.contains(checkmans,u.getUserId())){ %> checked="checked"<%} %>  value="<%=u.getUserId() %>" alt="gsld"><%=u.getRealName() %></td>
                        <%	}else if(i%6==0){ %>
                    </tr>
                    <tr>
                        <td><input type="checkbox" name="ubox" <%if(StringUtil.contains(checkmans,u.getUserId())){ %> checked="checked"<%} %>  value="<%=u.getUserId() %>" alt="gsld"><%=u.getRealName() %></td>
                        <%	}else{ %>
                        <td><input type="checkbox" name="ubox" <%if(StringUtil.contains(checkmans,u.getUserId())){ %> checked="checked"<%} %>  value="<%=u.getUserId() %>" alt="gsld"><%=u.getRealName() %></td>
                        <%	} %>
                        <%} %>
                        <%
                            if(userList.size()%6!=0){
                                for(int i=0; i<userList.size()%6-1; i++){%>
                        <td>&nbsp;</td>
                        <%}%>
                    </tr>
                    <%}%>
                    <tr>
                        <td colspan="6" align="left">
                            <hr width="100%">
                            <h2>机关科室</h2>
                            <input type="checkbox"  onclick="checkPartAll(this,'jgks');"/>全选<input type="checkbox" onclick="checkPartNot(this,'jgks');"/>反选
                            <hr width="100%">
                        </td>
                    </tr>
                    <%for(int i=0; i<userList1.size(); i++){
                        CUser u = (CUser)userList1.get(i);
                        if(i==0){
                    %>
                    <tr>
                        <td><input type="checkbox" name="ubox"  <%if(StringUtil.contains(checkmans,u.getUserId())){ %> checked="checked"<%} %>  value="<%=u.getUserId() %>" alt="jgks"><%=u.getRealName() %></td>
                        <%	}else if(i%6==0){ %>
                    </tr>
                    <tr>
                        <td><input type="checkbox" name="ubox" <%if(StringUtil.contains(checkmans,u.getUserId())){ %> checked="checked"<%} %>  value="<%=u.getUserId() %>" alt="jgks"><%=u.getRealName() %></td>
                        <%	}else{ %>
                        <td><input type="checkbox" name="ubox" <%if(StringUtil.contains(checkmans,u.getUserId())){ %> checked="checked"<%} %>  value="<%=u.getUserId() %>" alt="jgks"><%=u.getRealName() %></td>
                        <%	} %>
                        <%} %>
                        <%
                            if(userList1.size()%6!=0){
                                for(int i=0; i<userList1.size()%6-1; i++){%>
                        <td>&nbsp;</td>
                        <%}%>
                    </tr>
                    <%}%>
                    <tr>
                        <td colspan="6" align="left">
                            <hr width="100%">
                            <h2>基层单位</h2>
                            <input type="checkbox"  onclick="checkPartAll(this,'jcdw');"/>全选<input type="checkbox" onclick="checkPartNot(this,'jcdw');"/>反选
                            <hr width="100%">
                        </td>
                    </tr>
                    <%for(int i=0; i<userList2.size(); i++){
                        CUser u = (CUser)userList2.get(i);
                        if(i==0){
                    %>
                    <tr>
                        <td><input type="checkbox" name="ubox"  <%if(StringUtil.contains(checkmans,u.getUserId())){ %> checked="checked"<%} %>  value="<%=u.getUserId() %>" alt="jcdw"><%=u.getRealName() %></td>
                        <%	}else if(i%6==0){ %>
                    </tr>
                    <tr>
                        <td><input type="checkbox" name="ubox" <%if(StringUtil.contains(checkmans,u.getUserId())){ %> checked="checked"<%} %>  value="<%=u.getUserId() %>" alt="jcdw"><%=u.getRealName() %></td>
                        <%	}else{ %>
                        <td><input type="checkbox" name="ubox" <%if(StringUtil.contains(checkmans,u.getUserId())){ %> checked="checked"<%} %>  value="<%=u.getUserId() %>" alt="jcdw"><%=u.getRealName() %></td>
                        <%	} %>
                        <%} %>
                        <%
                            if(userList2.size()%6!=0){
                                for(int i=0; i<userList2.size()%6-1; i++){%>
                        <td>&nbsp;</td>
                        <%}%>
                    </tr>
                    <%}%>
                </table>
            </div>
        </div>
    </div>
    <table width="100%" height="25" border="0" cellpadding="0"
           cellspacing="0"
           background="<%=contentPath%>/images/mhead.jpg">
        <tr>
            <td width="3%" align="center">
                <img src="<%=contentPath%>/images/mlogo.jpg" width="11"
                     height="11">
            </td>
            <td width="15%" class="mhead">
                来文查看
            </td>
            <td width="74%" align="left" class="mhead">
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tbody>
                    <tr>
                        <td align="left">
                            &nbsp;
                            <input type="button" class="button" id="button"
                                   onclick="checkForm();" value="传阅"> &nbsp;
                            <input type="button" class="button" id="button"
                                   onclick="history.back()" value="返回">
                            &nbsp;
                        </td>
                    </tr>
                    </tbody>
                </table>
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td>
                <%--固定表头DIV--%>
                <div id="scrollDiv"
                     style="width: 1000px; overflow: auto; cursor: default; display: inline; position: absolute; height: 200px;">
                    <table width="100%" border="0" align="center" cellpadding="0"
                           cellspacing="0" class="mtabtab" id="mtabtab">
                        <tr>
                            <td nowrap="nowrap" width="120" class="head_left">
                                来文时间
                            </td>
                            <td class="head_right" align="left" style="text-align: left">
                                <%=StringUtil.parseNull(document.getLwsj(),"") %> &nbsp;&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap" width="120" class="head_left">
                                来文单位
                            </td>
                            <td class="head_right" align="left" style="text-align: left">
                                <%=StringUtil.parseNull(document.getLwdw(),"") %> &nbsp;&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap" width="120" class="head_left">
                                文件编号
                            </td>
                            <td class="head_right" align="left" style="text-align: left">

                                <%=StringUtil.parseNull(document.getWjbh(),"") %> &nbsp;&nbsp;
                            </td>
                        </tr>

                        <tr>
                            <td nowrap="nowrap" width="120" class="head_left">
                                文件名称
                            </td>
                            <td class="head_right" align="left" style="text-align: left">

                                <%=StringUtil.parseNull(document.getWjmc(),"") %> &nbsp;&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap" width="120" class="head_left">
                                传阅人
                            </td>
                            <td class="head_right" align="left" style="text-align: left">
                                <%=checkman%>
                                <input type="button" id="checkman" name="checkman"  class="button"
                                       value="传阅人">
                                &nbsp;
                            </td>
                        </tr>
                        <%if(hasFileList!=null && hasFileList.size()>0){ %>
                        <tr>
                            <td nowrap="nowrap" width="120" class="head_left">
                                已有附件
                            </td>
                            <td class="head_right" align="left" id="hasFile" style="text-align: left">

                                <%
                                    for(int i=0; i<hasFileList.size(); i++){
                                        OfficeFile beanFile = (OfficeFile)hasFileList.get(i);%>
                                <a href="<%=request.getContextPath()%>/officeFileDownload?pkid=<%=beanFile.getPkid() %>" >
                                    <img src="<%=request.getContextPath()%>/fileIco/<%=beanFile.getWjlx() %>.png" onerror="this.src='<%=request.getContextPath()%>/fileIco/other.png'" style="cursor: pointer;" border="0" alt="<%=beanFile.getWjm() %>(<%=StringUtil.getFileSize(beanFile.getWjcc().doubleValue()) %>)"><%=beanFile.getWjm() %>
                                </a>&nbsp;&nbsp;&nbsp;
                                <%}%>&nbsp;&nbsp;
                            </td>
                        </tr>
                        <%} %>
                        <tr>
                            <td   class="head_left" colspan="2">
                                注：传阅人名字颜色为绿色表示该人已经完成传阅，红色为尚未传阅。
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>

    </table>
</form>
</body>
</html>