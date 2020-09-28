package utils;
import java.util.List;
public class Page<T> {   
	private int total;    // 总条�?
	private int page;     // 当前�?
	private int size;     // 每页�?
	private List<T> rows; // 结果�?
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}
	public List<T> getRows() {
		return rows;
	}
	public void setRows(List<T> rows) {
		this.rows = rows;
	}  
}
