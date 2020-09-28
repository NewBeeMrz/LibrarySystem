package service;

import java.util.Date;
import java.util.List;

import entity.Book;
import entity.Borrowtable;
import utils.Page;

public interface BorrowService {
	public Page<Borrowtable> getborrowtableByUser(Integer user_id,Integer page, Integer rows);
	public Page<Borrowtable> getSearchList(Integer user_id,Integer page, Integer rows,String search_date,String status,String search_content);
	public Page<Borrowtable> getBorrowtableList(Integer page, Integer rows);
	public Integer createBorrow(Borrowtable borrowtable);
	public Integer returnBook(Borrowtable borrowtable);
}
