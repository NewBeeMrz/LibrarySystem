package controller;

import java.io.File;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

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
public class admin_controller {
	// 依赖注入
	@Autowired
	@Qualifier("userService")
	private UserService userService;

	// 依赖注入
	@Autowired
	@Qualifier("bookService")
	private BookService bookService;

	// 依赖注入
	@Autowired
	@Qualifier("categoryService")
	private CategoryService categoryService;

	// 依赖注入
	@Autowired
	@Qualifier("borrowService")
	private BorrowService borrowService;

	// 主界面跳转
	@RequestMapping(value = "admin/home.action")
	public String User_home(Model model, HttpSession session) {
		return "Admin_page";
	}

	// 查看图书列表
	@RequestMapping(value = "admin/booklist.action")
	public String View(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer rows,
			Model model, HttpSession session) {
		Page<Book> books = bookService.getBookList(page, rows);
		model.addAttribute("page", books);

		List<Category> catelist = categoryService.getCateList();
		model.addAttribute("catelist", catelist);
		return "Admin_book";
	}

	// 查看图书详情
	@RequestMapping(value = "admin/book_detail.action")
	public String book_detail(Model model, HttpSession session, HttpServletRequest request) {
		String book_id = request.getParameter("book_id");
		User user = (User) session.getAttribute("USER_SESSION");
		Book book = bookService.getBookbyID(Integer.parseInt(book_id));
		model.addAttribute("book", book);
		model.addAttribute("rank", user.getUser_rank());
		return "Book_detail";
	}

	// 搜索图书
	@RequestMapping(value = "admin/search_book.action")
	public String search(@RequestParam(defaultValue = "1") Integer page,
			@RequestParam(defaultValue = "10") Integer rows, Model model, HttpSession session,
			HttpServletRequest request) {
		String search_content = request.getParameter("search_content");
		String c_id = request.getParameter("cateSource");
		if (c_id == null || c_id == "")
			c_id = "0";
		if (search_content != "" || Integer.parseInt(c_id) > 0) {
//			System.out.println(Integer.parseInt(c_id));
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
		return "Admin_book";
	}

	// 新建书籍
	@RequestMapping("admin/create_book.action")
	@ResponseBody
	public String userUpdate(HttpServletRequest request, @RequestParam(value = "photo") CommonsMultipartFile file,
			HttpSession session, @RequestParam(value = "book_name") String book_name,
			@RequestParam(value = "type_id") Integer type_id, @RequestParam(value = "author") String author,
			@RequestParam(value = "price") double price, @RequestParam(value = "position") String position,
			@RequestParam(value = "intro") String intro, @RequestParam(value = "press") String press,
			@RequestParam(value = "number") Integer number) {

		String photourl = "";
//		System.out.print(type_id);
		// 判断所上传文件是否存在
		if (!file.isEmpty() && file.getSize() > 0) {
			// 循环输出上传的文件
			// 获取上传文件的原始名称
			String originalFilename = file.getOriginalFilename();
			// 设置上传文件的保存地址目录（本地地址）
			String dirPath = "E:\\Program Files\\eclipse-workspace\\LibrarySystem\\WebContent\\images\\";
			// 设置上传文件的保存地址目录（服务器）
//				String dirPath = 
//						request.getServletContext().getRealPath("/images/");
			File filePath = new File(dirPath);
			// 如果保存文件的地址不存在，就先创建目录
			if (!filePath.exists()) {
				filePath.mkdirs();
			}
			// 查询分类下的图书个数
			Integer count = bookService.getBookByType(type_id) + 1;
//				 重新命名上传的文件名称
			String newFilename = String.valueOf(type_id) + "_" + String.valueOf(count) + ".jpg";
			photourl = "\\images\\" + newFilename;
			try {
				// 使用MultipartFile接口的方法完成文件上传到指定位置
				file.transferTo(new File(dirPath + newFilename));
			} catch (Exception e) {
				e.printStackTrace();
				return "error";
			}
		}
		Book book = new Book();
		book.setBook_name(book_name);
		book.setAuthor(author);
		book.setIntro(intro);
		book.setPrice(price);
		book.setPhotourl(photourl);
		book.setPosition(position);
		book.setPress(press);
		book.setNumber(number);
		book.setType_id(type_id);
		int rows = bookService.createBook(book);
		if (rows > 0) {
			return "true";
		} else {
			return "false";
		}
	}
	
	// 修改书籍
	@RequestMapping("admin/update_book.action")
	@ResponseBody
	public String update_book(HttpServletRequest request, 
			@RequestParam(value = "photo") CommonsMultipartFile file,
			HttpSession session, 
			@RequestParam(value = "book_name") String book_name,
			@RequestParam(value = "book_id") Integer book_id,
			@RequestParam(value = "type_id") Integer type_id, @RequestParam(value = "author") String author,
			@RequestParam(value = "price") double price, @RequestParam(value = "position") String position,
			@RequestParam(value = "intro") String intro, @RequestParam(value = "press") String press,
			@RequestParam(value = "number") Integer number) {
		//获取图片相对路径
		String photourl = this.bookService.getBookbyID(book_id).getPhotourl();
//		System.out.print(type_id);
		// 判断所上传文件是否存在
		if (!file.isEmpty() && file.getSize() > 0) {
			// 循环输出上传的文件
			// 获取上传文件的原始名称
			String originalFilename = file.getOriginalFilename();
			// 设置上传文件的保存地址目录（本地地址）
			String dirPath = "E:\\Program Files\\eclipse-workspace\\LibrarySystem\\WebContent\\images\\";
			// 设置上传文件的保存地址目录（服务器）
//				String dirPath = 
//						request.getServletContext().getRealPath("/images/");
			File filePath = new File(dirPath);
			// 如果保存文件的地址不存在，就先创建目录
			if (!filePath.exists()) {
				filePath.mkdirs();
			}
//				 重新命名上传的文件名称
			String newFilename = photourl.substring(8);
			try {
				// 使用MultipartFile接口的方法完成文件上传到指定位置
				file.transferTo(new File(dirPath + newFilename));
			} catch (Exception e) {
				e.printStackTrace();
				return "error";
			}
		}
		Book book = new Book();
		book.setBook_id(book_id);
		book.setBook_name(book_name);
		book.setAuthor(author);
		book.setIntro(intro);
		book.setPrice(price);
		book.setPhotourl(photourl);
		book.setPosition(position);
		book.setPress(press);
		book.setNumber(number);
		book.setType_id(type_id);
		int rows = bookService.updateBook(book);
		if (rows > 0) {
			return "true";
		} else {
			return "false";
		}
	}

	// 删除书籍
	@RequestMapping(value = "admin/book_delete.action")
	@ResponseBody
	public String book_delete(Integer book_id) {
		int rows = bookService.deleteBookByID(book_id);
		if (rows > 0) {
			return "OK";
		} else {
			return "FAIL";
		}
	}

	// 通过ID查询书籍信息
	@RequestMapping(value = "admin/getBookByID.action")
	@ResponseBody
	public Book getBookByID(Integer book_id) {
		Book book = bookService.getBookbyID(book_id);
		return book;
	}

	// 跳转至分类管理页面
	@RequestMapping(value = "admin/categorylist.action")
	public String categorylist(Model model, HttpSession session) {
		List<Category> categorylist=categoryService.getCateList();
		model.addAttribute("categorylist",categorylist);
		return "Admin_category";
	}
	
	//创建分类
	@RequestMapping(value = "admin/category_careate.action")
	@ResponseBody
	public String category_careate(Category category,Model model, HttpSession session) {
		int rows = categoryService.careateCategory(category);
//		System.out.println(rows);
		if(rows > 0) {
			return "OK";
		}else {
			return "FAIL";
		}
	}
	
	//删除分类
	@RequestMapping(value = "admin/category_delete.action")
	@ResponseBody
	public String category_delete(Integer c_id,Model model, HttpSession session) {
		int rows = categoryService.deleteCategory(c_id);
//		System.out.println(rows);
		if(rows > 0) {
			return "OK";
		}else {
			return "FAIL";
		}
	}

	//根据id获取修改的分类信息
	@RequestMapping(value = "admin/getCategorybyID.action")
	@ResponseBody
	public Category getCategorybyID(Integer c_id) {
		Category category = categoryService.getCategorybyID(c_id);
		return category;
	}
	
	//修改分类信息
	@RequestMapping(value = "admin/category_update.action")
	@ResponseBody
	public String category_update(Category category,Model model, HttpSession session) {
		int rows = categoryService.updateCategory(category);
		if(rows > 0) {
			return "OK";
		}else {
			return "FAIL";
		}
	}
	
	// 搜索分类
	@RequestMapping(value = "admin/category_search.action")
	public String category_search( Model model, HttpSession session,
			HttpServletRequest request) {
		String search_content = request.getParameter("search_content");
		if (search_content != "" || search_content != null) {
			List<Category> categorys = categoryService.getCsearchList(search_content);
			model.addAttribute("categorylist", categorys);

		} else {
			List<Category> categorys = categoryService.getCateList();
			model.addAttribute("categorylist", categorys);
		}
		model.addAttribute("search_content", search_content);
		return "Admin_category";
	}
	
	// 跳转至用户管理页面
	@RequestMapping(value = "admin/userlist.action")
	public String userlist(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer rows,
			Model model, HttpSession session) {
		Page<User> users = userService.getUserList(page, rows);
		model.addAttribute("page", users);
		return "Admin_user";
	}
	
	//创建用户
	@RequestMapping(value = "admin/user_careate.action")
	@ResponseBody
	public String user_careate(User user,Model model, HttpSession session) {
		int rows = userService.createUser(user);
		if(rows > 0) {
			return "OK";
		}else {
			return "FAIL";
		}
	}
	
	//根据id查询用户信息
	@RequestMapping(value = "admin/getUserById.action")
	@ResponseBody
	public User getUserById(Integer user_id,HttpServletRequest request, Model model, HttpSession session) {
		User user = userService.getUser(user_id);
		return user;
	}
	
	//执行修改用户信息操作
	@RequestMapping(value = "admin/user_update.action")
	@ResponseBody
	public String user_update(User user,Model model, HttpSession session) {
		int rows = userService.updateUser(user);
		if(rows > 0) {
			return "OK";
		}else {
			return "FAIL";
		}
	}
	
	//删除用户
	@RequestMapping(value = "admin/user_delete.action")
	@ResponseBody
	public String user_delete(Integer user_id,Model model, HttpSession session) {
		int rows = userService.deleteUser(user_id);
		if(rows > 0) {
			return "OK";
		}else {
			return "FAIL";
		}
	}
	
	// 搜索用户
	@RequestMapping(value = "admin/search_user.action")
	public String search_user(@RequestParam(defaultValue = "1") Integer page,
			@RequestParam(defaultValue = "10") Integer rows, Model model, HttpSession session,
			HttpServletRequest request) {
		String search_content = request.getParameter("search_content");
		String user_rank = request.getParameter("rankSource");
		if (user_rank == null || user_rank == "")
			user_rank = "-1";
		if (search_content != "" || Integer.parseInt(user_rank) != -1) {
			Page<User> users = userService.getSearchList(Integer.parseInt(user_rank), search_content, page, rows);
			model.addAttribute("page", users);

		} else {
			Page<User> users = userService.getUserList(page, rows);
			model.addAttribute("page", users);
		}
		model.addAttribute("search_content", search_content);
		model.addAttribute("user_rank", user_rank);
		return "Admin_user";
	}
	
	// 跳转至借阅记录管理页面
	@RequestMapping(value = "admin/borrowlist.action")
	public String borrowlist(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer rows,
			Model model, HttpSession session) {
		Page<Borrowtable> borrowtables = borrowService.getBorrowtableList(page, rows);
		model.addAttribute("page", borrowtables);
		return "Admin_borrow";
	}
	
	//创建借阅记录
	@RequestMapping(value = "admin/borrowtable_careate.action")
	@ResponseBody
	public String borrow_careate(Borrowtable borrowtable,Model model, HttpSession session) {

		SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date borrow_date = new Date(System.currentTimeMillis());
		borrowtable.setBorrow_date(formatter.format(borrow_date).toString());
		borrowtable.setStatus("未归还");
		//获取书籍并减少库存
		Book book = this.bookService.getBookbyID(borrowtable.getBook_id());
		int number = book.getNumber();
		book.setNumber(number-1);
		int count = this.bookService.updateBook(book);
		//创建借阅记录
		int rows = this.borrowService.createBorrow(borrowtable);
		if(rows > 0 && count > 0) {
			return "OK";
		}else {
			return "FAIL";
		}
	}
	
	//还书
	@RequestMapping(value = "admin/return_Book.action")
	@ResponseBody
	public String return_Book(Integer user_id,Integer book_id,Model model, HttpSession session) {
		SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date return_date = new Date(System.currentTimeMillis());
		Borrowtable borrowtable = new Borrowtable();
		borrowtable.setReturn_date(formatter.format(return_date).toString());
		borrowtable.setStatus("已归还");
		borrowtable.setUser_id(user_id);
		borrowtable.setBook_id(book_id);
		//获取书籍并增加库存
		Book book = this.bookService.getBookbyID(borrowtable.getBook_id());
		int number = book.getNumber();
		book.setNumber(number+1);
		int count = this.bookService.updateBook(book);
		
		int rows = this.borrowService.returnBook(borrowtable);
		if(rows > 0 && count > 0) {
			return "OK";
		}else {
			return "FAIL";
		}
	}
	
	// 搜索借阅记录
	@RequestMapping(value = "admin/search_borrow.action")
	public String search_borrow(@RequestParam(defaultValue = "1") Integer page, HttpServletRequest request,
			@RequestParam(defaultValue = "10") Integer rows, Model model, HttpSession session) throws ParseException {
		String search_date = (String) request.getParameter("search_date");
		String status = request.getParameter("statusSource");
		String search_content = request.getParameter("search_content");
//			Date date = new Date();//时间类型
		if (search_date != "" || status!="" || search_content !="") {
//				date = new SimpleDateFormat("yyyy-MM-dd").parse(search_content);//将String转换为date类型
			Page<Borrowtable> borrowtables = borrowService.getSearchList(-1, page, rows, search_date,status,search_content);
			if (borrowtables.getTotal() > 0) {
				model.addAttribute("msg", "");
			} else {
				model.addAttribute("msg", "当天暂无借还记录！");
			}
			model.addAttribute("page", borrowtables);
		} else {
			Page<Borrowtable> borrowtables = borrowService.getBorrowtableList(page, rows);
			model.addAttribute("msg", "");
			model.addAttribute("page", borrowtables);
		}
		model.addAttribute("time", search_date);
		model.addAttribute("status", status);
		model.addAttribute("search_content", search_content);
		return "Admin_borrow";
	}
}
