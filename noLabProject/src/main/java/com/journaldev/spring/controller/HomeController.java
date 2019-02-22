package com.journaldev.spring.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.journaldev.spring.model.Calendar;
import com.journaldev.spring.model.DetailBox;
import com.journaldev.spring.model.addSchedule;
import com.journaldev.spring.model.helloBox;
import com.journaldev.spring.model.showPost;

@Controller
public class HomeController {

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		System.out.println("Home Page Requested, locale = " + locale);
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "home";
	}

	@RequestMapping(value = "/DetailBox",  method = {RequestMethod.GET, RequestMethod.POST})
	public String detailbox(@Validated DetailBox detailbox, Model model) {
		System.out.println("Page Requested_detailbox");
		
		return "DetailBox";
	}
	
	@RequestMapping(value = "/Calendar",  method = {RequestMethod.GET, RequestMethod.POST})
	public String calendar(@Validated Calendar calendar, Model model) {
		System.out.println("Page Requested_Calendar");
		
		return "Calendar";
	}
	@RequestMapping(value = "/helloBox",  method = {RequestMethod.GET, RequestMethod.POST})
	public String hellobox(@Validated helloBox hellobox, Model model) {
		System.out.println("Page Requested_Calendar");
		
		return "helloBox";
	}
	@RequestMapping(value = "/addSchedule",  method = {RequestMethod.GET, RequestMethod.POST})
	public String addschedule(@Validated addSchedule addschedule, Model model) {
		System.out.println("Page Requested_addSchedule");
		
		return "addSchedule";
	}
	@RequestMapping(value = "/showPost",  method = {RequestMethod.GET, RequestMethod.POST})
	public String showpost(@Validated showPost showpost, Model model) {
		System.out.println("Page Requested_Calendar");
		
		return "showPost";
	}
}
