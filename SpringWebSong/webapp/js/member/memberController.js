'use strict';

memberApp.controller('MemberController', MemberController);

MemberController.$inject = ['$rootScope', '$scope', 'MemberService'];

function MemberController($rootScope, $scope, MemberService) {
	
	//회원가입 빈객체 생성
    $scope.memberBean = {
    	memberId: "newyork",
        memberName : "NewYork",
        ageList : [],
        memberAge: 19,
        memberSex: "F"
    };
    
    //회원가입 클릭 이벤트
    $scope.insertMemberClick = function() {
    	
    	//회원가입
    	MemberService.insertMemberProcAjax($scope.memberBean).then(function(data) {
    		alert(data.resultMsg);	
    	});
    	
    };
    
    //회원의 목록을 조회한다.
    $scope.selectMemberList = function(pageNo) {
    	
    	if( $scope.pBean == undefined ) {
    		$scope.pBean = {};
    	}
    	
    	$scope.pBean.pageNo = pageNo;
    	
    	MemberService.selectMemberListAjax($scope.pBean).then(function(data) {
    		
    		console.log( JSON.stringify(data) );
    		
    		$scope.memberList = data.memberList; //리스트 정보
    		$scope.pBean = data.pagingBean; //페이징 정보
    		
    	});
    	
    };
    
    
    //배열 생성 함수
    $scope.getArr = function(num) {
    	return new Array(num);
    };
	
	
};//end controller