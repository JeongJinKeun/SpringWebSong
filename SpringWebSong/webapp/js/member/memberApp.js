'use strict';

var memberApp = angular.module('memberApp', []);

//게시판 서비스 정의
memberApp.factory("MemberService", function($http) {
	
	var service = {};
	
	service.loginProcAjax = loginProcAjax;
	service.selectMemberAjax = selectMemberAjax;
	service.insertMemberProcAjax = insertMemberProcAjax;
	service.selectMemberListAjax = selectMemberListAjax;
	service.updateMemberProcAjax = updateMemberProcAjax;
	service.memberDeleteAjax = memberDeleteAjax;
	
	return service;
	
	//로그인
	function loginProcAjax(objParam) {
		return $http({
			url: "/member/loginProcAjax.do",
			method: "post",
			data : json2PostParams(objParam),
			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
		}).then(handleSuccess, handleError);
	};
	
	//회원조회 1명
	function selectMemberAjax(objParam) {
		return $http({
			url: "/member/selectMemberAjax.do",
			method: "post",
			data : json2PostParams(objParam),
			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
		}).then(handleSuccess, handleError);
	};
	
	//회원가입
	function insertMemberProcAjax(objParam) {
		return $http({
			url: "/member/insertMemberProcAjax.do",
			method: "post",
			data :  json2PostParams(objParam),
			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
		}).then(handleSuccess, handleError);
	};
	
	//회원가입
	function selectMemberListAjax(objParam) {
		return $http({
			url: "/member/selectMemberListAjax.do",
			method: "post",
			data : json2PostParams(objParam),
			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
		}).then(handleSuccess, handleError);
	};
	//회원가입
	function updateMemberProcAjax(objParam) {
		return $http({
			url: "/member/updateMemberProcAjax.do",
			method: "post",
			data : json2PostParams(objParam),
			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
		}).then(handleSuccess, handleError);
	};
	
	//회원가입
	function memberDeleteAjax(objParam) {
		return $http({
			url: "/member/memberDeleteAjax.do",
			method: "post",
			data : json2PostParams(objParam),
			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
		}).then(handleSuccess, handleError);
	};
	
	function handleSuccess(res) {
		return res.data;
	}
	
	function handleError(res) {
		return res.data;
	}
	
});