package dao;

import java.util.List;

import entity.Book;
import entity.Borrowtable;

public interface BorrowDao {
	public List<Borrowtable> getborrowtableByUser(Borrowtable borrowtable);
	public Integer getborrowtableByUserCount(Borrowtable borrowtable);
	public List<Borrowtable> getSearchList(Borrowtable borrowtable);
	public Integer getSearchListCount(Borrowtable borrowtable);
	public List<Borrowtable> getBorrowtableList(Borrowtable borrowtable);
	public Integer getBorrowtableListCount(Borrowtable borrowtable);
	public Integer createBorrow(Borrowtable borrowtable);
	public Integer returnBook(Borrowtable borrowtable);
}	
