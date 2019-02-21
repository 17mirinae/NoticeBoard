package com.Ex.Ex;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.Ex.dto.MemberVO;
import com.Ex.dto.UserVO;
import com.Ex.service.MemberService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Inject
	private MemberService service;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/")
	public String home(Locale locale, Model model) throws Exception {

		logger.info("home");

		List<MemberVO> memberList = service.selectAll();

		model.addAttribute("memberList", memberList);

		logger.info("Welcome home! The client locale is {}.", locale);

		return "home";
	}

	@RequestMapping(value = "/search")
	public String search(@ModelAttribute("memberVO") MemberVO memberVO, Model model, HttpServletRequest request)
			throws Exception {
		System.out.println("Page search");

		String value = request.getParameter("value");

		if (value.length() == 0) {
			List<MemberVO> memberList = service.selectAll();
			model.addAttribute("memberList", memberList);
			return "redirect:/";
		} else {
			List<MemberVO> memberList = service.selectSearch(value);
			model.addAttribute("memberList", memberList);
			return "home";
		}
	}

	@RequestMapping(value = "/viewForm")
	public String viewForm(@ModelAttribute("memberVO") MemberVO memberVO, Model model, HttpServletRequest request)
			throws Exception {
		System.out.println("Page viewForm");
		int code = Integer.parseInt(request.getParameter("num"));
		memberVO.setNum(code);
		List<MemberVO> memberList = service.selectView(code);
		model.addAttribute("memberList", memberList);

		return "viewForm";
	}

	@RequestMapping(value = "/delete")
	public String delete(@ModelAttribute("memberVO") MemberVO memberVO, Model model, HttpServletRequest request)
			throws Exception {
		System.out.println("Page database delete");

		int code = Integer.parseInt(request.getParameter("num"));
		memberVO.setNum(code);
		service.deleteBoard(code);

		List<MemberVO> memberList = service.selectAll();
		model.addAttribute("memberList", memberList);

		return "redirect:/";
	}

	@RequestMapping(value = "/updateForm")
	public String updateForm(@ModelAttribute("memberVO") MemberVO memberVO, Model model, HttpServletRequest request)
			throws Exception {
		System.out.println("Page updateForm");

		int code = Integer.parseInt(request.getParameter("num"));
		memberVO.setNum(code);

		List<MemberVO> memberList = service.selectView(code);
		model.addAttribute("memberList", memberList);

		return "updateForm";
	}

	@RequestMapping(value = "/update")
	public String update(@ModelAttribute("memberVO") MemberVO memberVO, Model model, HttpServletRequest request)
			throws Exception {
		System.out.println("Page datebase update");

		String title = request.getParameter("title");
		memberVO.setTitle(title);
		int num = Integer.parseInt(request.getParameter("num"));
		memberVO.setNum(num);
		String content = request.getParameter("content");
		memberVO.setContent(content);
		String type = request.getParameter("type");
		memberVO.setType(type);
		service.updateBoard(memberVO);

		List<MemberVO> memberList = service.selectAll();
		model.addAttribute("memberList", memberList);

		return "redirect:/";
	}

	@RequestMapping(value = "/write")
	public String write(@ModelAttribute("memberVO") MemberVO memberVO, Model model, HttpServletRequest request)
			throws Exception {
		System.out.println("Page database insert");

		String title = request.getParameter("title");
		String writer = request.getParameter("writer");
		String content = request.getParameter("content");
		String type = request.getParameter("type");
		System.out.println(title + writer + type);
		
		if(type!=null && writer!=null && title!="") {
		memberVO.setTitle(title);
		memberVO.setWriter_name(writer);
		memberVO.setContent(content);
		memberVO.setType(type);
		service.insertBoard(memberVO);

		List<MemberVO> memberList = service.selectAll();
		model.addAttribute("memberList", memberList);
		return "redirect:/";
		}
		else
			return "redirect:/writeForm";
	}

	@RequestMapping(value = "/writeForm")
	public String writeForm(Model model) throws Exception {
		System.out.println("Page writeForm");

		List<UserVO> userList = service.selectUser();

		model.addAttribute("userList", userList);

		return "writeForm";
	}
}
