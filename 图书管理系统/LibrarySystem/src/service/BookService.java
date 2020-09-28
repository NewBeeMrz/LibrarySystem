package service;

import entity.Book;
import utils.Page;

public interface BookService {
	public Page<Book> getBookList(Integer page, Integer rows);
	public Book getBookbyID(Integer book_id);
	public Page<Book> getSearchList(Integer c_id,String search_content,Integer page, Integer rows);
	public Integer createBook(Book book);
	public Integer getBookByType(Integer type_id);
	public Integer deleteBookByID(Integer book_id);
	public Integer updateBook(Book book);
}
