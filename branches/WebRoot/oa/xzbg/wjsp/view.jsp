<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ include file="../../../import.jsp"%>
<%

    CUser cUser = (CUser)session.getAttribute("cUser");
    cUser = cUser == null?new CUser():cUser;
    String orgId = cUser.getOrgnaId();
    Map paramMap = new HashMap();
    paramMap.put("orgnaId",orgId);
    COrgnization cOrgnization = orgnizationDAO.queryForBean(paramMap);
    String documentid = StringUtil.parseNull(request.getParameter("documentid"),"");
    Map map1 = new HashMap();
    map1.put("documentid",documentid);
    OfficeWjsp wjsp = officeWjspDAO.queryForBean(map1);
    List hasFileList = officeFileDAO.getByFk(documentid);
    wjsp = wjsp == null?new OfficeWjsp():wjsp;
    List userList  = dao.getAllUser();
    List orgTreeList = dao.getSelectOrgTrees();
    orgTreeList = orgTreeList == null?new ArrayList():orgTreeList;
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
    <link href="<%=request.getContextPath()%>/css/css.css" rel="stylesheet" type="text/css">
    <link href="<%=request.getContextPath()%>/images/css.css" rel="stylesheet" type="text/css">
    <link href="<%=request.getContextPath()%>/js/ext/resources/css/ext-all.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" charset="GB2312"
            src="<%=request.getContextPath()%>/js/date/WdatePicker.js" defer="true"></script>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/js/ckeditor/ckeditor.js"></script>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/js/ext/adapter/ext/ext-base.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/ext/ext-all.js"></script>


    <script type="text/javascript">
        function _resizeNoPage() {
            document.getElementById("scrollDiv").style.width = document.body.clientWidth - 18;
            document.getElementById("scrollDiv").style.height = document.body.clientHeight - 50;
        }

        function CheckDateTime(object){
            var rr=/^(?:19|20)[0-9][0-9]-(?:(?:0[1-9])|(?:1[0-2]))-(?:(?:[0-2][1-9])|(?:[1-3][0-1])) (?:(?:[0-2][0-3])|(?:[0-1][0-9])):[0-5][0-9]$/
            if(!rr.test(object.value)){
                object.focus();
                return false;
            }
            return true;
        }
        function CheckDate(object){
            var rr=/^(?:19|20)[0-9][0-9]-(?:(?:0[1-9])|(?:1[0-2]))-(?:(?:[0-2][1-9])|(?:[1-3][0-1]))$/
            if(!rr.test(object.value)){
                object.focus();
                return false;
            }
            return true;
        }

        function checkForm(){
            if(document.form1.bt.value==""){
                document.form1.bt.focus();
                alert("请输入文件标题！");
                return;
            }
            if(document.getElementById("checked").checked){
                document.all.dxtx.value="1";
            }else if(!document.getElementById("checked").checked){
                document.all.dxtx.value="0";
            }
            document.form1.submit();
        }
        function startup(){
            if(document.form1.bt.value==""){
                document.form1.bt.focus();
                alert("请输入文件标题！");
                return;
            }
            if(document.getElementById("checked").checked){
                document.all.dxtx.value="1";
            }else if(!document.getElementById("checked").checked){
                document.all.dxtx.value="0";
            }
            document.all.flag.value="startup";
            document.form1.submit();
        }
        function doAddAttachRow(tid){
            var tbl = document.getElementById(tid);
            var rows = tbl.rows;
            var len = rows.length;
            var newTr = tbl.insertRow();
            var newTd = newTr.insertCell(0);
            newTd.align="center";
            newTd.className="NormalDataColumn";
            newTd.appendChild(document.createTextNode(len));
            newTd = newTr.insertCell(1);
            newTd.className="NormalDataColumn";
            newTd.appendChild(document.createTextNode("文件："));
            var node = document.createElement("input");

            node.type = "file";
            node.size = "60";
            node.name = "fjlist";
            newTd.appendChild(node);
            newTd = newTr.insertCell(2);
            newTd.align="center";
            newTd.className="NormalDataColumn";
            var node = document.createElement("a");
            node.href="javascript:void(0)";
            node.onclick= function (){
                doDeleteRow(this);
            };
            node.appendChild(document.createTextNode("[删除]"));
            newTd.appendChild(node);
        }
        function doDeleteRow(t,uuid){
            if( uuid != undefined && uuid != null && uuid != ''){
                if(!confirm("确定要删除此附件信息么?")){
                    return ;
                }
            }
            var row = t.parentElement.parentElement;
            var index = row.rowIndex;
            //通过Ajax删除附件记录
            document.getElementById("attachTab").deleteRow(row.rowIndex);
            var rows = document.getElementById("attachTab").rows;
            var len = rows.length;
            for(var i=1; i<len; i++){
                var r = rows[i];
                var c = r.cells[0];
                c.innerText = i;
            }
        }
    </script>
</head>
<body onload="_resizeNoPage();">
<form action="edit.jsp" name="form1" method="post" enctype="multipart/form-data">
    <input type="hidden" name="flag" value=""/>
    <input type="hidden" name="dxtx" value=""/>
    <input type="hidden" name="documentid" value="<%=documentid%>"/>
    <table width="100%" height="25" border="0" cellpadding="0"
           cellspacing="0"
           background="<%=request.getContextPath()%>/images/mhead.jpg">
        <tr>
            <td width="3%" align="center">
                <img src="<%=request.getContextPath()%>/images/mlogo.jpg" width="11"
                     height="11">
            </td>
            <td width="15%" class="mhead">
                查看文件审批信息
            </td>
            <td width="74%" align="left" class="mhead">
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tbody>
                    <tr>
                        <td align="left">
                            <input type="button" class="button" id="button1"
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
                                文件标题
                            </td>
                            <td class="head_right" style="text-align: left">
                                <%=StringUtil.parseNull(wjsp.getBt(),"")%>&nbsp;
                                <%--<input type="checkbox" name="checked" id="checked" value="" <%if(!"0".equals(wjsp.getDxtx())){ %>checked<%}%>>短信提醒--%>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap" width="120" class="head_left">
                                发文类型
                            </td>
                            <td class="head_right" style="text-align: left">
                                <%=StringUtil.parseNull(wjsp.getLb(),"")%>&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap" width="120" class="head_left">
                                文件编号
                            </td>
                            <td class="head_right" style="text-align: left">
                                <%=StringUtil.parseNull(wjsp.getWjbh(),"")%>&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap" width="120" class="head_left">
                                密级
                            </td>
                            <td class="head_right" style="text-align: left">
                                <%=StringUtil.parseNull(wjsp.getMmcd(),"")%>&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap" width="120" class="head_left">
                                缓急时限
                            </td>
                            <td class="head_right" style="text-align: left">
                                <%=StringUtil.parseNull(wjsp.getHjsx(),"")%>&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap" width="120" class="head_left">
                                签发日期
                            </td>
                            <td class="head_right" style="text-align: left">
                                <%=DateUtil.format(wjsp.getQfrq(),"yyyy-MM-dd") %>&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap" width="120" class="head_left">
                                拟稿部门
                            </td>
                            <td class="head_right" style="text-align: left">
                                <%
                                    String ngbm = StringUtil.parseNull(wjsp.getNgbm(),"");
                                    paramMap.put("orgnaId",ngbm);
                                    COrgnization yyOrgnization = orgnizationDAO.queryForBean(paramMap);
                                    yyOrgnization = yyOrgnization ==null?new COrgnization():yyOrgnization;
                                %>
                                <%=yyOrgnization.getOrgnaName()%>&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap" width="120" class="head_left">
                                备注
                            </td>
                            <td class="head_right" style="text-align: left">
                                <%=StringUtil.parseNull(wjsp.getBz(),"")%>&nbsp;
                            </td>
                        </tr>
                        <%if(hasFileList!=null && hasFileList.size()>0){ %>
                        <tr>
                            <td nowrap="nowrap" width="120" class="head_left">
                                已有附件
                            </td>
                            <td class="head_right" style="text-align: left">
                                <%
                                    for(int i=0; i<hasFileList.size(); i++){
                                        OfficeFile beanFile = (OfficeFile)hasFileList.get(i);%>
                                <a href="<%=request.getContextPath()%>/officeFileDownload?pkid=<%=beanFile.getPkid() %>" >
                                    <img src="<%=request.getContextPath()%>/fileIco/<%=beanFile.getWjlx() %>.png" onerror="this.src='<%=request.getContextPath()%>/fileIco/other.png'" style="cursor: pointer;" border="0" alt="<%=beanFile.getWjm() %>(<%=StringUtil.getFileSize(beanFile.getWjcc().doubleValue()) %>)"><%=beanFile.getWjm() %>
                                </a>&nbsp;&nbsp;&nbsp;</br>
                                <%}%>
                            </td>
                        </tr>
                        <%} %>
                    </table>
                </div>
            </td>
        </tr>

    </table>
</form>
</body>
</html>