package controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import entity.Book;
import entity.Borrowtable;
import entity.Category;
import entity.User;
import service.BookService;
import service.BorrowService;
import service.CategoryService;
import service.UserService;
import utils.Page;

@Controller
public class user_controller {
	// ����ע��
	@Autowired
	@Qualifier("userService")
	private UserService userService;

	// ����ע��
	@Autowired
	@Qualifier("bookService")
	private BookService bookService;

	// ����ע��
	@Autowired
	@Qualifier("categoryService")
	private CategoryService categoryService;

	// ����ע��
	@Autowired
	@Qualifier("borrowService")
	private BorrowService borrowService;

	// ��������ת
	@RequestMapping(value = "user/home.action")
	public String User_home(Model model, HttpSession session) {
		return "User_page";
	}

	// ���ͼ��
	@RequestMapping(value = "user/view.action")
	public String View(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer rows,
			Model model, HttpSession session) {
		Page<Book> books = bookService.getBookList(page, rows);
		model.addAttribute("page", books);

		List<Category> catelist = categoryService.getCateList();
		model.addAttribute("catelist", catelist);
		return "User_view";
	}

	// �鿴ͼ������
	@RequestMapping(value = "user/book_detail.action")
	public String book_detail(Model model, HttpSession session, HttpServletRequest request) {
		String book_id = request.getParameter("book_id");
		User user = (User) session.getAttribute("USER_SESSION");
		Book book = bookService.getBookbyID(Integer.parseInt(book_id));
		model.addAttribute("book", book);
		model.addAttribute("rank", user.getUser_rank());
		return "Book_detail";
	}

	// ����ͼ��
	@RequestMapping(value = "user/search_book.action")
	public String search(@RequestParam(defaultValue = "1") Integer page,
			@RequestParam(defaultValue = "10") Integer rows, Model model, HttpSession session,
			HttpServletRequest request) {
		String search_content = request.getParameter("search_content");
		String c_id = request.getParameter("cateSource");
		if (c_id == null || c_id == "")
			c_id = "0";
		if (search_content != "" || Integer.parseInt(c_id) > 0) {
//				System.out.println(Integer.parseInt(c_id));
			Page<Book> books = bookService.getSearchList(Integer.parseInt(c_id), search_content, page, rows);
			model.addAttribute("page", books);

		} else {
			Page<Book> books = bookService.getBookList(page, rows);
			model.addAttribute("page", books);
		}
		List<Category> catelist = categoryService.getCateList();
		model.addAttribute("catelist", catelist);
		model.addAttribute("search_content", search_content);
		model.addAttribute("c_id", c_id);
		return "User_view";
	}

	// �鿴���ļ�¼
	@RequestMapping(value = "user/borrow.action")
	public String borrow(@RequestParam(defaultValue = "1") Integer page,
			@RequestParam(defaultValue = "10") Integer rows, Model model, HttpSession session) {
		User user = (User) session.getAttribute("USER_SESSION");
		Integer user_id = user.getUser_id();
		Page<Borrowtable> borrowtables = borrowService.getborrowtableByUser(user_id, page, rows);
		model.addAttribute("page", borrowtables);
		return "User_borrow";
	}

	// �������ļ�¼
	@RequestMapping(value = "user/search_borrow.action")
	public String search_borrow(@RequestParam(defaultValue = "1") Integer page, HttpServletRequest request,
			@RequestParam(defaultValue = "10") Integer rows, Model model, HttpSession session) throws ParseException {

		User user = (User) session.getAttribute("USER_SESSION");
		Integer user_id = user.getUser_id();
		String search_date = (String) request.getParameter("search_date");
		String status = request.getParameter("statusSource");
//			Date date = new Date();//ʱ������
		if (search_date != "" || status!="") {
//				date = new SimpleDateFormat("yyyy-MM-dd").parse(search_content);//��Stringת��Ϊdate����
			Page<Borrowtable> borrowtables = borrowService.getSearchList(user_id, page, rows, search_date,status,"");
			if (borrowtables.getTotal() > 0) {
				model.addAttribute("msg", "");
			} else {
				model.addAttribute("msg", "�������޽軹��¼��");
			}
			model.addAttribute("page", borrowtables);
		} else {
			Page<Borrowtable> borrowtables = borrowService.getborrowtableByUser(user_id, page, rows);
			model.addAttribute("msg", "");
			model.addAttribute("page", borrowtables);
		}
		model.addAttribute("time", search_date);
		model.addAttribute("status", status);
		return "User_borrow";
	}

	// �鿴��������
	@RequestMapping(value = "user/profile.action")
	public String View_profile(@RequestParam(defaultValue = "1") Integer page, HttpServletRequest request,
			@RequestParam(defaultValue = "10") Integer rows, Model model, HttpSession session) {
		User user = (User) session.getAttribute("USER_SESSION");
		model.addAttribute("user", user);
		return "User_profile";
	}

	// ͨ��id��ѯ�û���Ϣ
	@RequestMapping(value = "user/getUser.action")
	@ResponseBody
	public User getUserById(HttpServletRequest request, Model model, HttpSession session) {
		User user = (User) session.getAttribute("USER_SESSION");
		return user;
	}

	/*
	 * �����û���Ϣ
	 */
	@RequestMapping("user/update.action")
	@ResponseBody
	public String userUpdate(User user, HttpSession session) {
		int rows = userService.updateUser(user);
		User Now_user = userService.getUser(user.getUser_id());
		session.setAttribute("USER_SESSION", Now_user);
		if (rows > 0) {
			return "OK";
		} else {
			return "FAIL";
		}
	}

	// �û�ע��
	@RequestMapping("user/add.action")
	@ResponseBody
	public String register(User user, HttpServletRequest request, HttpSession session) {
		int rows = userService.registerUser(user);
		if (rows > 0) {
			return "OK";
		} else {
			return "FAIL";
		}
	}
	
	
}
