<%--
  /**
  * Class Name : 
  * Description : 
  * Modification Information
  *
  *   수정일                   수정자                      수정내용
  *  -------    --------    ---------------------------
  *  2020. 3. 10.            최초 생성
  *
  * author 실행환경 개발팀
  * since 2009.01.06
  *
  * Copyright (C) 2009 by KandJang  All right reserved.
  */
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set  var="hContext" value="${pageContext.request.contextPath }"></c:set>
<c:if test="${maxPageNo == null}"><c:set var="maxPageNo" value="1"></c:set></c:if>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>회원관리</title>
    
	<link rel="shortcut icon" type="image/x-icon" href="${hContext}/resources/img/main/favicon.ico">
    <!-- 부트스트랩 -->  
    <link href="${hContext}/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
    <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
  	<!-- div container -->
  	<div class="container">
  	    <!-- div title -->
  	    <div class="page-header">
  	    	<h1>회원관리</h1>
  	    </div>
  	    <!--// div title -->
  	    <!-- 검색영역 -->
    	<div class="row">
    		<div class="col-md-12 text-right">
	    		<form action="${hContext}/member/do_retrieve.do" name="member_frm" method="get" class="form-inline">
	    			<!-- pageNum -->
	    			<input type="hidden" name="pageNum" id="pageNum" value="${param.pageNum }">
	    			<div class="form-group">
	    				<select name="pageSize" id="pageSize" class="form-control input-sm">
	    					<option value="10"
	    						<c:if test="${param.pageSize =='10' }"> selected ="selected"</c:if> >10
	    					</option>
	    					<option value="20" 
	    						<c:if test="${param.pageSize =='20' }"> selected ="selected"</c:if> >20
	    					</option>
	    					<option value="50" 
	    						<c:if test="${param.pageSize =='50' }"> selected ="selected"</c:if> >50
	    					</option>
	    					<option value="100" 
	    						<c:if test="${param.pageSize =='100' }"> selected ="selected"</c:if> >100
	    					</option>
	    				</select>
	    				<select name="searchDiv" id="searchDiv" class="form-control input-sm">
	    					<option value="">전체</option>
	    					<option value="10"
	    						<c:if test="${param.searchDiv == '10' }"> selected ="selected"</c:if> >ID
	    					</option>
	    					<option value="20"
	    						<c:if test="${param.searchDiv == '20' }"> selected ="selected"</c:if> >이름
	    					</option>
	    				</select>
	    				<input type="text"  class="form-control input-sm"  
	    				id="searchWord" value="${param.searchWord }" name="searchWord" placeholder="검색어">
	    				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
	    				<button type="button" onclick="javascript:doRetrieve();" class="btn btn-primary btn-sm">조회</button> 
	    				<button type="button" class="btn btn-primary btn-sm">등록</button> 				
	    			</div>
	    		</form>
    		</div>
    	</div>
    	<!--// 검색영역 -->
    	<form action="${hContext}/portfolio/do_select_one.spring" id="selectOne_frm" name="selectOne_frm" method="post">
    		<input type="hidden" name="hiddenId" id="hiddenId">
    	</form>
    	<!-- Grid영역 -->
    	<div class="table-responsive">
    		<table class="table table-striped table-bordered" id="memberTable">
    		    <!-- hidden-sm hidden-xs 숨기기 -->
    			<thead class="bg-primary">
	    				<th>사진</th>
	    				<th>ID</th>
	    				<th>이름</th>
	    				<th>생년월일</th>
	    				<th>이메일</th>
	    				<th>핸드폰번호</th>
    			</thead>
    			<tbody>
    				<!-- Data있는 경우 -->
    				<c:choose>
    					<c:when test="${list.size()>0 }">
    						<c:forEach var="i" begin="0" end="${list.size()-1}">
		    					<tr>
			    					<td class="text-center"><img src="../resources/images/${fileList.get(i).saveNm}.${fileList.get(i).ext}" width="100" height="100" /></td>
			    					<td class="text-left">${list.get(i).memberId}</td>
			    					<td class="text-left">${list.get(i).name }</td>
			    					<td class="text-left hidden-sm hidden-xs">${list.get(i).birth }</td>
			    					<td class="text-left hidden-sm hidden-xs">${list.get(i).email }</td>
			    					<td class="text-center hidden-sm hidden-xs">${list.get(i).phone }</td>
		    					</tr>
	    					</c:forEach>
    					</c:when>
    					<c:otherwise>
    						<tr><td colspan="99">등록된 게시글이 없습니다.</td></tr>
    					</c:otherwise>
    				</c:choose>
    			</tbody>
    		</table>
    	</div>
    	<!--// Grid영역 -->    	
      <!-- pagenation -->
           <div id="content">Dynamic Content goes here</div>
    		<div id="page-selection" class="text-center">Pagination goes here</div>
      <!--// pagenation -->    	
    </div>
    <!--// div container -->
    
    <!-- 입력 form -->
    <div class="container">
        <div class="col-lg-12"></div>
        <div class="col-lg-12"></div>
        <div class="panel panel-default"></div>
        
        <!-- Button Area -->
        <div class="row">
            <div class="col-lg-10 col-sm-10 col-xs-10">
                <div class="text-right">
                    <button type="button" class="btn btn-default btn-sm" id="doInit" >초기화</button>
                	<button type="button" class="btn btn-default btn-sm" id="doInsert" >등록</button>
                	<button type="button" class="btn btn-default btn-sm" id="doUpdate" >수정</button>
                	<button type="button" class="btn btn-default btn-sm" id="doDelete" >삭제</button>
                </div>
            </div>
        </div>    
        <!--// Button Area -->
        ${hContext}
        <!-- 입력 From -->
        <form action="${hContext}/member/do_update.do" name="member_edit" method="post" class="form-horizontal">
        	<!-- 아이디 -->
			<div class="form-group">
				<label for="memberId" class="col-lg-4 col-sm-4 col-xs-4 control-label">ID</label>
				<div class="col-lg-6 col-sm-6 col-xs-6">
					<input type="text" maxlength="20" class="form-control input-sm" id="memberId" name="memberId" placeholder="아이디" disabled="disabled"/>
				</div>
			</div>
			<!--// 아이디 -->
			<!-- 이름 -->
			<div class="form-group">
				<label for="name" class="col-lg-4 col-sm-4 col-xs-4 control-label">이름</label>
				<div class="col-lg-6 col-sm-6 col-xs-6">
					<input type="text" maxlength="50" class="form-control input-sm" id="name" name="name" placeholder="이름" />
				</div>
			</div>
			<!--// 이름 -->
			<!-- 비번 -->
			<div class="form-group">
				<label for="password" class="col-lg-4 col-sm-4 col-xs-4 control-label">비밀번호</label>
				<div class="col-lg-6 col-sm-6 col-xs-6">
					<input type="password" maxlength="50" class="form-control input-sm" id="password" name="password" placeholder="비밀번호" />
				</div>
			</div>
			<!--// 비번 -->
			<!-- 로그인 횟수-->
			<div class="form-group">
				<label for="phone" class="col-lg-4 col-sm-4 col-xs-4 control-label">폰번호</label>
				<div class="col-lg-6 col-sm-6 col-xs-6">
					<input type="text" numberOnly maxlength="7" class="form-control input-sm" id="phone" name="phone" placeholder="폰번호" />
				</div>
			</div>
			<!--// 로그인 횟수-->
			<!-- 추천 횟수-->
			<div class="form-group">
				<label for="birth" class="col-lg-4 col-sm-4 col-xs-4 control-label">생년월일</label>
				<div class="col-lg-6 col-sm-6 col-xs-6">
					<input type="text" numberOnly maxlength="7" class="form-control input-sm" id="birth" name="birth" placeholder="생년월일" />
				</div>
			</div>
			<!--// 추천 횟수-->
			<!-- 이메일-->
			<div class="form-group">
				<label for="email" class="col-lg-4 col-sm-4 col-xs-4 control-label">이메일</label>
				<div class="col-lg-6 col-sm-6 col-xs-6">
					<input type="text" maxlength="350" class="form-control input-sm" id="email" name="email" placeholder="이메일" />
				</div>
			</div>
			<!--// 이메일-->
			<!-- 등록일-->
			<div class="form-group">
				<label for="authority" class="col-lg-4 col-sm-4 col-xs-4 control-label">권한</label>
				<div class="col-lg-6 col-sm-6 col-xs-6">
					<input type="text" maxlength="20" class="form-control input-sm" id="authority" name="authority" placeholder="권한" disabled="disabled"/>
				</div>
			</div>
			<!--// 등록일-->
			
        </form>
        <!--// 입력 From -->
        
        
    </div>
    <!--// 입력 form -->
    
    
    <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="${hContext}/resources/js/bootstrap.min.js"></script>
    <!-- page -->
    <script src="${hContext}/resources/js/jquery.bootpag.min.js"></script>
    
    <script type="text/javascript">
		
		// init bootpag
	    $('#page-selection').bootpag({
	        total: ${maxPageNo}, <!-- total pages -->
	        page: $("#pageNum").val(),	 <!-- current pages -->
	        maxVisible: 5,		 <!-- bottom pages -->
	        leaps: true,		 
	        firstLastUse: true,
	        first: '←',
	        last: '→',
	        wrapClass: 'pagination',
	        activeClass: 'active',
	        disabledClass: 'disabled',
	        nextClass: 'next',
	        prevClass: 'prev',
	        lastClass: 'last',
	        firstClass: 'first'
	    }).on("page", function(event, num){
	        alert("Page " + num); // or some ajax content loading...
	        doSelectPage(num);
	    });

		//등록
		$("#doInsert").on("click", function(){
			//console.log("#doUpdate");

			//값  Null check
			if($("#u_id").val() == "" || $("#u_id").val() == false){
				alert("아아디를 입력 하세요.");
				$("#u_id").focus();
				return;
			}

			if($("#name").val() == "" || $("#name").val() == false){
				alert("이름을 입력 하세요.");
				$("#name").focus();
				return;
			}

			if($("#passwd").val() == "" || $("#passwd").val() == false){
				alert("비밀번호를 입력 하세요.");
				$("#passwd").focus();
				return;
			}

			if($("#login").val() == "" || $("#login").val() == false){
				alert("로그인 횟수를 입력 하세요.");
				$("#login").focus();
				return;
			}

			if($("#recommend").val() == "" || $("#recommend").val() == false){
				alert("추천 횟수를 입력 하세요.");
				$("#recommend").focus();
				return;
			}
			
			//confirm
			if(confirm("수정 하시겠습니까?")==false)return;
			
			//ajax
			$.ajax({
			   type:"POST",
			   url:"${hContext}/member/add.do",
			   dataType:"html",
			   data:{
				   "u_id": $("#u_id").val(),
				   "name": $("#name").val(),
				   "passwd": $("#passwd").val(),
				   "login": $("#login").val(),
				   "level": $("#level").val(),
				   "recommend": $("#recommend").val(),
				   "email": $("#email").val()
			   },
			   success:function(data){ //성공
			      console.log("data:"+data);
			      var parseData = $.parseJSON(data);
			      if(parseData.msgId == "1"){
					 alert(parseData.msgMsg);
					 doRetrieve();
				  }else{
					 alert(parseData.msgMsg);
				  }
			      
			   },
			   error:function(xhr,status,error){
			      alert("error:"+error);
			   },
			   complete:function(data){
			   
			   }   
			   
			});//--ajax
			
		});
	
		//초기화
    	$("#doInit").on("click", function(){
			console.log("doInit");
			//contorll 초기화: ""
			$("#u_id").val("");
			$("#name").val("");
			$("#passwd").val("");
			$("#login").val("");
			$("#level").val("BASIC");
			$("#recommend").val("");
			$("#email").val("");
			
			//버튼제어: 등록, 수정, 삭제(disable)
			//enable 등록,$("#u_id")
			//수정,삭제(disable)
			$("#u_id").prop("disabled",false);
			$("#doUpdate").prop("disabled",true);
			$("#doDelete").prop("disabled",true);
			$("#doInsert").prop("disabled",false);
			
			
        });
        	
		//숫자만 입력:text numberOnly    
	    $("input:text[numberOnly]").on("keyup", function() {
	        $(this).val($(this).val().replace(/[^0-9]/g,""));
	    });

		//수정
		$("#doUpdate").on("click",function(){
			console.log("#doUpdate");

			//값  Null check
			if($("#u_id").val() == "" || $("#u_id").val() == false){
				alert("삭제 데이터를 선택 하세요.");
				$("#u_id").focus();
				return;
			}

			if($("#name").val() == "" || $("#name").val() == false){
				alert("이름을 입력 하세요.");
				$("#name").focus();
				return;
			}

			if($("#passwd").val() == "" || $("#passwd").val() == false){
				alert("비밀번호를 입력 하세요.");
				$("#passwd").focus();
				return;
			}

			if($("#login").val() == "" || $("#login").val() == false){
				alert("로그인 횟수를 입력 하세요.");
				$("#login").focus();
				return;
			}

			if($("#recommend").val() == "" || $("#recommend").val() == false){
				alert("추천 횟수를 입력 하세요.");
				$("#recommend").focus();
				return;
			}
			
			//confirm
			if(confirm("수정 하시겠습니까?")==false)return;
			
			//ajax
			$.ajax({
			   type:"POST",
			   url:"${hContext}/member/do_update.do",
			   dataType:"html",
			   data:{
				   "u_id": $("#u_id").val(),
				   "name": $("#name").val(),
				   "passwd": $("#passwd").val(),
				   "login": $("#login").val(),
				   "level": $("#level").val(),
				   "recommend": $("#recommend").val(),
				   "email": $("#email").val()
			   },
			   success:function(data){ //성공
			      console.log("data:"+data);
			      var parseData = $.parseJSON(data);
			      if(parseData.msgId == "1"){
					 alert(parseData.msgMsg);
					 doRetrieve();
				  }else{
					 alert(parseData.msgMsg);
				  }
			      
			   },
			   error:function(xhr,status,error){
			      alert("error:"+error);
			   },
			   complete:function(data){
			   
			   }   
			   
			});//--ajax
			
		});
    
    	//삭제
    	$("#doDelete").on("click", function(){
			//console.log("#doDelete");

			//u_id null chect
			console.log("#u_id"+$("#u_id").val());
			if($("#u_id").val() == "" || $("#u_id").val() == false){
				alert("삭제 데이터를 선택 하세요.");
				return;
			}

			//confirm
			if(confirm("삭제 하시겠습니까?")==false)return;
			
			//ajax
			$.ajax({
			   type:"POST",
			   url:"${hContext}/member/do_delete.do",
			   dataType:"html", 
			   data:{
				   "u_id": $("#u_id").val()
			   },
			   success:function(data){ //성공
			      console.log("data:"+data);
			      var parseData = $.parseJSON(data);
			      if(parseData.msgId == "1"){
					 alert(parseData.msgMsg);
					 doRetrieve();
				  }else{
					 alert(parseData.msgMsg);
				  }
			      
			   },
			   error:function(xhr,status,error){
			      alert("error:"+error);
			   },
			   complete:function(data){
			   
			   }   
			   
			});//--ajax
			
        });
		//그리드 click: ID값을 서버로 ajax 전송:/member/do_select_one.do
		$("#memberTable>tbody").on("click","tr", function(){
			console.log("#memberTable>tbody"+ $(this));
			var tds = $(this).children();
			//console.log("tds:"+ tds.text());
			var memberId = tds.eq(1).text();
			console.log("memberId:"+ memberId);

			var frm = document.selectOne_frm;
			frm.hiddenId.value = memberId;
			
			frm.submit();

			
		});

		function doSelectPage(pageNo){
			var frm = document.member_frm;
			frm.pageNum.value = pageNo;
			frm.action = "${hContext}/member/do_retrieve.do";
			frm.submit();
		}
    	
		function doRetrieve(){
			//console.log('doRetrieve');
			var frm = document.member_frm;
			frm.pageNum.value = 1;
			frm.action = "${hContext}/portfolio/do_retrieve.spring";
			frm.submit();
		}

		
		
		$("#searchWord").on("keydown",function(key) {
			console.log('searchWord keydown:'+key.keyCode);
			if(key.keyCode ==13){
				doRetrieve();
			}
		});
	
    </script>
  </body>
</html>