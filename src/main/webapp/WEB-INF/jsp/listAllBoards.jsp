<%@ page import="com.domain.Board" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@taglib prefix="html" tagdir="/WEB-INF/tags" %><!--定义前置与tag文件位置-->
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>板块专区</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">

    <!-- Main Style Sheet -->
    <link rel="stylesheet" href="<c:url value="/css/main.css"/>">
    <!--<link href="css/signin.css" rel="stylesheet">-->
    <!-- Modernizr -->
    <script src="<c:url value="/js/vendor/modernizr-2.6.2.min.js" />"></script>
    <!-- Respond.js for IE 8 or less only -->
    <!--[if (lt IE 9) & (!IEMobile)]>
    <![endif]-->
    <script src="<c:url value=" /js/vendor/respond.min.js" />"></script>
</head>
</head>
<body style="background-color: gainsboro">



<header role="banner">
    <nav role="navigation" class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="<c:url value="/index.html"/>"><img src="<c:url value="/img/logo.png"/>" alt="ThisUsCommunity'" width="200px"></a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li><a href="<c:url value="/index.html"/> "><span class="glyphicon glyphicon-home"></span>主页</a></li>
                    <li><a href="#"><span class="glyphicon glyphicon-plus"></span>注册</a></li>
                    <li><a href="#"><span class="glyphicon glyphicon-user"></span>登录</a></li>
                    <li class="active"><a href="#"><span class="glyphicon glyphicon-list-alt"></span>社区版块</a></li>
                    <li><a href="#"><span class="glyphicon glyphicon-tag"></span>社区话题</a></li>
                </ul>
                <form class="navbar-form navbar-left" role="search">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Search">
                    </div>
                    <button type="submit" class="btn btn-default">Submit</button>
                </form>
            </div><!--/.nav-collapse -->
        </div><!--/.container -->
    </nav>
</header>

<div class="panel panel-default">
    <!-- Default panel contents -->
    <div class="panel-heading">欢迎访问ThisIsUsCommunity</div>
    <div class="panel-body">
        <p>proudly present by you!</p>
    </div>

    <!-- Table -->
    <table  class="table">
        <tr>
            <td colspan="3" bgcolor="#EEEEEE">所有论坛版块</td>
        </tr>
        <tr>
        <tr>
            <c:if test="${USER_CONTEXT.userType == 2}">
                <td>
                    <script>
                        function switchSelectBox(){
                            var selectBoxs = document.all("boardIds");
                            if(!selectBoxs) return ;
                            if(typeof(selectBoxs.length) == "undefined"){//only one checkbox
                                selectBoxs.checked = event.srcElement.checked;
                            }else{//many checkbox ,so is a array
                                for(var i = 0 ; i < selectBoxs.length ; i++){
                                    selectBoxs[i].checked = event.srcElement.checked;
                                }
                            }
                        }
                    </script>
                    <input type="checkbox" onclick="switchSelectBox()"/>
                </td>
            </c:if>
            <td width="20%">版块名称</td>
            <td width="70%">版块简介</td>
            <td width="10%">主题帖数</td>
        </tr>



        <c:forEach var="board" items="${boards}">
            <tr>
                <c:if test="${USER_CONTEXT.userType == 2}">
                    <td><input type="checkbox" name="boardIds" value="${board.boardId}"/></td>
                </c:if>
                <td><a href="<c:url value="/board/listBoardTopics-${board.boardId}.html"/>">${board.boardName}</a></td>
                <td>${board.boardDesc}</td>
                <td>${board.topicNum}</td>
            </tr>
        </c:forEach>
    </table>
</div>

<c:if test="${USER_CONTEXT.userType == 2 || isboardManager}">
    <script>
        function getSelectedBoardIds(){
            var selectBoxs = document.all("boardIds");
            if(!selectBoxs) return null;
            if(typeof(selectBoxs.length) == "undefined" && selectBoxs.checked){
                return selectBoxs.value;
            }else{//many checkbox ,so is a array
                var ids = "";
                var split = ""
                for(var i = 0 ; i < selectBoxs.length ; i++){
                    if(selectBoxs[i].checked){
                        ids += split+selectBoxs[i].value;
                        split = ",";
                    }
                }
                return ids;
            }
        }
        function deleteBoards(){
            var ids = getSelectedBoardIds();
            if(ids){
                var url = "<c:url value="/board/removeBoard.html"/>?boardIds="+ids+"";
                //alert(url);
                location.href = url;
            }
        }

    </script>
    <input type="button" value="删除" onclick="deleteBoards()">
</c:if>


<script src="<c:url value="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"/>"></script>
<script>window.jQuery || document.write('<script src="<c:url value="/js/vendor/jquery-1.10.2.min.js"/>"><\/script>')</script>
<script src="<c:url value="/js/plugins.js"/>"></script>
<script src="<c:url value="/js/main.js"/>"></script>

<!-- Google Analytics: change UA-XXXXX-X to be your site's ID. -->
<script>
    var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
    (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
        g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
        s.parentNode.insertBefore(g,s)}(document,'script'));
</script>

</body>
</html>