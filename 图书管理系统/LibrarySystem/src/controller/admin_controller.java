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
	@RequestMapping(value = "admin/home.action")
	public String User_home(Model model, HttpSession session) {
		return "Admin_page";
	}

	// �鿴ͼ���б�
	@RequestMapping(value = "admin/booklist.action")
	public String View(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer rows,
			Model model, HttpSession session) {
		Page<Book> books = bookService.getBookList(page, rows);
		model.addAttribute("page", books);

		List<Category> catelist = categoryService.getCateList();
		model.addAttribute("catelist", catelist);
		return "Admin_book";
	}

	// �鿴ͼ������
	@RequestMapping(value = "admin/book_detail.action")
	public String book_detail(Model model, HttpSession session, HttpServletRequest request) {
		String book_id = request.getParameter("book_id");
		User user = (User) session.getAttribute("USER_SESSION");
		Book book = bookService.getBookbyID(Integer.parseInt(book_id));
		model.addAttribute("book", book);
		model.addAttribute("rank", user.getUser_rank());
		return "Book_detail";
	}

	// ����ͼ��
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

	// �½��鼮
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
		// �ж����ϴ��ļ��Ƿ����
		if (!file.isEmpty() && file.getSize() > 0) {
			// ѭ������ϴ����ļ�
			// ��ȡ�ϴ��ļ���ԭʼ����
			String originalFilename = file.getOriginalFilename();
			// �����ϴ��ļ��ı����ַĿ¼�����ص�ַ��
			String dirPath = "E:\\Program Files\\eclipse-workspace\\LibrarySystem\\WebContent\\images\\";
			// �����ϴ��ļ��ı����ַĿ¼����������
//				String dirPath = 
//						request.getServletContext().getRealPath("/images/");
			File filePath = new File(dirPath);
			// ��������ļ��ĵ�ַ�����ڣ����ȴ���Ŀ¼
			if (!filePath.exists()) {
				filePath.mkdirs();
			}
			// ��ѯ�����µ�ͼ�����
			Integer count = bookService.getBookByType(type_id) + 1;
//				 ���������ϴ����ļ�����
			String newFilename = String.valueOf(type_id) + "_" + String.valueOf(count) + ".jpg";
			photourl = "\\images\\" + newFilename;
			try {
				// ʹ��MultipartFile�ӿڵķ�������ļ��ϴ���ָ��λ��
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
	
	// �޸��鼮
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
		//��ȡͼƬ���·��
		String photourl = this.bookService.getBookbyID(book_id).getPhotourl();
//		System.out.print(type_id);
		// �ж����ϴ��ļ��Ƿ����
		if (!file.isEmpty() && file.getSize() > 0) {
			// ѭ������ϴ����ļ�
			// ��ȡ�ϴ��ļ���ԭʼ����
			String originalFilename = file.getOriginalFilename();
			// �����ϴ��ļ��ı����ַĿ¼�����ص�ַ��
			String dirPath = "E:\\Program Files\\eclipse-workspace\\LibrarySystem\\WebContent\\images\\";
			// �����ϴ��ļ��ı����ַĿ¼����������
//				String dirPath = 
//						request.getServletContext().getRealPath("/images/");
			File filePath = new File(dirPath);
			// ��������ļ��ĵ�ַ�����ڣ����ȴ���Ŀ¼
			if (!filePath.exists()) {
				filePath.mkdirs();
			}
//				 ���������ϴ����ļ�����
			String newFilename = photourl.substring(8);
			try {
				// ʹ��MultipartFile�ӿڵķ�������ļ��ϴ���ָ��λ��
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

	// ɾ���鼮
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

	// ͨ��ID��ѯ�鼮��Ϣ
	@RequestMapping(value = "admin/getBookByID.action")
	@ResponseBody
	public Book getBookByID(Integer book_id) {
		Book book = bookService.getBookbyID(book_id);
		return book;
	}

	// ��ת���������ҳ��
	@RequestMapping(value = "admin/categorylist.action")
	public String categorylist(Model model, HttpSession session) {
		List<Category> categorylist=categoryService.getCateList();
		model.addAttribute("categorylist",categorylist);
		return "Admin_category";
	}
	
	//��������
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
	
	//ɾ������
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

	//����id��ȡ�޸ĵķ�����Ϣ
	@RequestMapping(value = "admin/getCategorybyID.action")
	@ResponseBody
	public Category getCategorybyID(Integer c_id) {
		Category category = categoryService.getCategorybyID(c_id);
		return category;
	}
	
	//�޸ķ�����Ϣ
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
	
	// ��������
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
	
	// ��ת���û�����ҳ��
	@RequestMapping(value = "admin/userlist.action")
	public String userlist(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer rows,
			Model model, HttpSession session) {
		Page<User> users = userService.getUserList(page, rows);
		model.addAttribute("page", users);
		return "Admin_user";
	}
	
	//�����û�
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
	
	//����id��ѯ�û���Ϣ
	@RequestMapping(value = "admin/getUserById.action")
	@ResponseBody
	public User getUserById(Integer user_id,HttpServletRequest request, Model model, HttpSession session) {
		User user = userService.getUser(user_id);
		return user;
	}
	
	//ִ���޸��û���Ϣ����
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
	
	//ɾ���û�
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
	
	// �����û�
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
	
	// ��ת�����ļ�¼����ҳ��
	@RequestMapping(value = "admin/borrowlist.action")
	public String borrowlist(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer rows,
			Model model, HttpSession session) {
		Page<Borrowtable> borrowtables = borrowService.getBorrowtableList(page, rows);
		model.addAttribute("page", borrowtables);
		return "Admin_borrow";
	}
	
	//�������ļ�¼
	@RequestMapping(value = "admin/borrowtable_careate.action")
	@ResponseBody
	public String borrow_careate(Borrowtable borrowtable,Model model, HttpSession session) {

		SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date borrow_date = new Date(System.currentTimeMillis());
		borrowtable.setBorrow_date(formatter.format(borrow_date).toString());
		borrowtable.setStatus("δ�黹");
		//��ȡ�鼮�����ٿ��
		Book book = this.bookService.getBookbyID(borrowtable.getBook_id());
		int number = book.getNumber();
		book.setNumber(number-1);
		int count = this.bookService.updateBook(book);
		//�������ļ�¼
		int rows = this.borrowService.createBorrow(borrowtable);
		if(rows > 0 && count > 0) {
			return "OK";
		}else {
			return "FAIL";
		}
	}
	
	//����
	@RequestMapping(value = "admin/return_Book.action")
	@ResponseBody
	public String return_Book(Integer user_id,Integer book_id,Model model, HttpSession session) {
		SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date return_date = new Date(System.currentTimeMillis());
		Borrowtable borrowtable = new Borrowtable();
		borrowtable.setReturn_date(formatter.format(return_date).toString());
		borrowtable.setStatus("�ѹ黹");
		borrowtable.setUser_id(user_id);
		borrowtable.setBook_id(book_id);
		//��ȡ�鼮�����ӿ��
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
	
	// �������ļ�¼
	@RequestMapping(value = "admin/search_borrow.action")
	public String search_borrow(@RequestParam(defaultValue = "1") Integer page, HttpServletRequest request,
			@RequestParam(defaultValue = "10") Integer rows, Model model, HttpSession session) throws ParseException {
		String search_date = (String) request.getParameter("search_date");
		String status = request.getParameter("statusSource");
		String search_content = request.getParameter("search_content");
//			Date date = new Date();//ʱ������
		if (search_date != "" || status!="" || search_content !="") {
//				date = new SimpleDateFormat("yyyy-MM-dd").parse(search_content);//��Stringת��Ϊdate����
			Page<Borrowtable> borrowtables = borrowService.getSearchList(-1, page, rows, search_date,status,search_content);
			if (borrowtables.getTotal() > 0) {
				model.addAttribute("msg", "");
			} else {
				model.addAttribute("msg", "�������޽軹��¼��");
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
