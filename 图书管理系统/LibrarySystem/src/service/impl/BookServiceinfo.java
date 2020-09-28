package service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dao.BookDao;
import entity.Book;
import entity.Borrowtable;
import service.BookService;
import utils.Page;

@Service("bookService")
@Transactional
public class BookServiceinfo implements BookService{
	// 声明DAO属性并注入
	@Autowired
	private BookDao bookDao;
	
	@Override
	public Page<Book> getBookList(Integer page, Integer rows) {
		// 创建图书对象
        Book book = new Book();

		// 当前页
        book.setStart((page-1) * rows) ;
		// 每页数
        book.setRows(rows);
		// 查询图书列表
		List<Book> books = 
				bookDao.getBookList(book);
		// 查询商品列表总记录数
		Integer count = bookDao.getBookListCount(book);
		// 创建Page返回对象
		Page<Book> result = new Page<>();
		result.setPage(page);
		result.setRows(books);
		result.setSize(rows);
		result.setTotal(count);
		return result;
	}

	@Override
	public Book getBookbyID(Integer book_id) {
		Book book = bookDao.getBookbyID(book_id);
		return book;
	}

	@Override
	public Page<Book> getSearchList(Integer c_id,String search_content, Integer page, Integer rows) {
		// 创建图书对象
        Book book = new Book();

		// 当前页
        book.setStart((page-1) * rows) ;
		// 每页数
        book.setRows(rows);
        
        book.setSearch_content(search_content);
        
        book.setType_id(c_id);
		// 查询图书列表
		List<Book> books = 
				bookDao.getSearchList(book);
		// 查询商品列表总记录数
		Integer count = bookDao.getSearchListCount(book);
		
		// 创建Page返回对象
		Page<Book> result = new Page<>();
		result.setPage(page);
		result.setRows(books);
		result.setSize(rows);
		result.setTotal(count);
		return result;
	}

	@Override
	public Integer createBook(Book book) {
		return this.bookDao.createBook(book);
	}

	@Override
	public Integer getBookByType(Integer type_id) {
		// TODO Auto-generated method stub
		return this.bookDao.getBookByType(type_id);
	}

	@Override
	public Integer deleteBookByID(Integer book_id) {
		// TODO Auto-generated method stub
		return this.bookDao.deleteBookByID(book_id);
	}


	@Override
	public Integer updateBook(Book book) {
		// TODO Auto-generated method stub
		return this.bookDao.updateBook(book);
	}

	
}
