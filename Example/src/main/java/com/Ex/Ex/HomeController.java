package com.Ex.Ex;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
		
		List<MemberVO> boardList = service.selectAll();
		model.addAttribute("boardList", boardList);
		
		logger.info("Welcome home! The client locale is {}.", locale);

		return "home";
	}
	
	@RequestMapping(value = "/search")
	public String search(@ModelAttribute("memberVO") MemberVO memberVO, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("Page search");

	    // 인코딩
	    request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html;charset=UTF-8");

		int length = Integer.parseInt(request.getParameter("length"));
		String v= request.getParameter("value");
		String value="";

		if (v.length() == 0) {
			List<MemberVO> memberList = service.selectAll();
			model.addAttribute("memberList", memberList);
			return "redirect:/";
		} else {
			value = "%"+v+"%";
			List<MemberVO> boardList = service.selectAll();
			model.addAttribute("boardList", boardList);
			List<MemberVO> memberList = service.selectSearch(value);
			model.addAttribute("memberList", memberList);
			return "home";
		}
	}

	@RequestMapping(value = "/viewForm")
	public String viewForm(@ModelAttribute("memberVO") MemberVO memberVO, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("Page viewForm");

	    // 인코딩
	    request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html;charset=UTF-8");
	    
		int code = Integer.parseInt(request.getParameter("num"));
		memberVO.setNum(code);
		//전체 게시물
		List<MemberVO> boardList = service.selectAll();
		model.addAttribute("boardList", boardList);
		//개인 정보 DB
		List<UserVO> userList = service.selectUser();
		model.addAttribute("userList", userList);
		//해당 번호의 게시물
		List<MemberVO> memberList = service.selectView(code);
		model.addAttribute("memberList", memberList);

		return "viewForm";
	}

	@RequestMapping(value = "/delete")
	public String delete(@ModelAttribute("memberVO") MemberVO memberVO, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("Page database delete");
		
	    // 인코딩
	    request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html;charset=UTF-8");

		int code = Integer.parseInt(request.getParameter("num"));
		memberVO.setNum(code);
		int length = Integer.parseInt(request.getParameter("length"));
		
		service.deleteBoard(code);
		
		for(int i=code+1; i<=length; i++)
			service.updateNum(i);

		List<MemberVO> memberList = service.selectAll();
		model.addAttribute("memberList", memberList);
		
		memberList = service.selectAll();
		model.addAttribute("memberList", memberList);

		return "redirect:/";
	}

	@RequestMapping(value = "/updateForm")
	public String updateForm(@ModelAttribute("memberVO") MemberVO memberVO, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("Page updateForm");

	    // 인코딩
	    request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html;charset=UTF-8");

	    int code = Integer.parseInt(request.getParameter("num"));
		memberVO.setNum(code);
		
		List<MemberVO> memberList = service.selectView(code);
		model.addAttribute("memberList", memberList);

		return "updateForm";
	}

	@RequestMapping(value = "/update")
	public String update(@ModelAttribute("memberVO") MemberVO memberVO, Model model, MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("Page datebase update");
		
	    // 인코딩
	    request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html;charset=UTF-8");

		int num = Integer.parseInt(request.getParameter("num"));
		String title = multipartRequest.getParameter("title");
		String content = multipartRequest.getParameter("content");
		String type = multipartRequest.getParameter("type");
		memberVO.setNum(num);
		memberVO.setTitle(title);
		memberVO.setContent(content);
		memberVO.setType(type);
		
		service.updateBoard(memberVO);

		List<MemberVO> memberList = service.selectAll();
		model.addAttribute("memberList", memberList);

		return "redirect:/";
	}

	@RequestMapping(value = "/write")
	public String write(@ModelAttribute("memberVO") MemberVO memberVO, Model model, MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("Page database insert");

	    // 인코딩
	    request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html;charset=UTF-8");
	    
	    int num = Integer.parseInt(multipartRequest.getParameter("length"));
		String title = multipartRequest.getParameter("title");
		String writer = multipartRequest.getParameter("writer");
		String content = multipartRequest.getParameter("content");
		String type = multipartRequest.getParameter("type");
		memberVO.setNum(num);
		memberVO.setTitle(title);
		memberVO.setWriter_name(writer);
		memberVO.setContent(content);
		memberVO.setType(type);

		service.insertBoard(memberVO);
		return "redirect:/";
	}

	@RequestMapping(value = "/writeForm")
	public String writeForm(Model model) throws Exception {
		System.out.println("Page writeForm");


		List<MemberVO> memberList = service.selectAll();
		model.addAttribute("memberList", memberList);
		
		List<UserVO> userList = service.selectUser();
		model.addAttribute("userList", userList);

		return "writeForm";
	}
}
