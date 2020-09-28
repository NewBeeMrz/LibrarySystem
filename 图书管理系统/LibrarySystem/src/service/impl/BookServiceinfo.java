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
	// ����DAO���Բ�ע��
	@Autowired
	private BookDao bookDao;
	
	@Override
	public Page<Book> getBookList(Integer page, Integer rows) {
		// ����ͼ�����
        Book book = new Book();

		// ��ǰҳ
        book.setStart((page-1) * rows) ;
		// ÿҳ��
        book.setRows(rows);
		// ��ѯͼ���б�
		List<Book> books = 
				bookDao.getBookList(book);
		// ��ѯ��Ʒ�б��ܼ�¼��
		Integer count = bookDao.getBookListCount(book);
		// ����Page���ض���
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
		// ����ͼ�����
        Book book = new Book();

		// ��ǰҳ
        book.setStart((page-1) * rows) ;
		// ÿҳ��
        book.setRows(rows);
        
        book.setSearch_content(search_content);
        
        book.setType_id(c_id);
		// ��ѯͼ���б�
		List<Book> books = 
				bookDao.getSearchList(book);
		// ��ѯ��Ʒ�б��ܼ�¼��
		Integer count = bookDao.getSearchListCount(book);
		
		// ����Page���ض���
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
