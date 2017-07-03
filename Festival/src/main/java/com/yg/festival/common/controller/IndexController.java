package com.yg.festival.common.controller;

import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yg.festival.festival.bean.FestivalBasicBean;
import com.yg.festival.festival.bean.FestivalBean;
import com.yg.festival.festival.bean.FestivalFileBean;
import com.yg.festival.festival.dao.FestivalDao;
import com.yg.festival.festival.service.FestivalService;

@Controller
public class IndexController {
	@Autowired
	private FestivalDao festivalDao;
	@Autowired
	private FestivalService festivalService;

	// 관리자 - 축제 한건 정보 페이지 이동
	@RequestMapping("/index")
	public String index(FestivalBean fBean, FestivalBasicBean fBBean, Model model) {
		try {
			int res1 = festivalService.updateFestivalDate(fBBean);
			int res2 = festivalService.updateFestivalEnd(fBBean);
			if (res1 <= 0 && res2 <= 0) {
				return "/errorPage500";
			}
			List<FestivalBean> fRstar = festivalService.selectRatingStar(fBean);
			model.addAttribute("fFBeanList", fRstar);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/index";
	}
}
