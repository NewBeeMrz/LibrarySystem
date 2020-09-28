package dao;

import java.util.List;

import entity.Book;

public interface BookDao {
	public List<Book> getBookList(Book book);
	public Integer getBookListCount(Book book);
	public Book getBookbyID(int book_id);
	public List<Book> getSearchList(Book book);
	public Integer getSearchListCount(Book book);
	public Integer createBook(Book book);
	public Integer getBookByType(Integer type_id);
	public Integer deleteBookByID(Integer book_id);
	public Integer updateBook(Book book);
}
