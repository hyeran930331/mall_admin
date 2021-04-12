package gdu.mall.vo;

public class Ebook {
	private int ebookNo;
	
	private String categoryName;
	private String ebookISBN;
	private String ebookTitle;
	private String ebookAuthor;
	private String ebookDate;
	
	public int getEbookNo() {
		return ebookNo;
	}
	public void setEbookNo(int ebookNo) {
		this.ebookNo = ebookNo;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getEbookISBN() {
		return ebookISBN;
	}
	public void setEbookISBN(String ebookISBN) {
		this.ebookISBN = ebookISBN;
	}
	public String getEbookTitle() {
		return ebookTitle;
	}
	public void setEbookTitle(String ebookTitle) {
		this.ebookTitle = ebookTitle;
	}
	public String getEbookAuthor() {
		return ebookAuthor;
	}
	public void setEbookAuthor(String ebookAuthor) {
		this.ebookAuthor = ebookAuthor;
	}
	public String getEbookDate() {
		return ebookDate;
	}
	public void setEbookDate(String ebookDate) {
		this.ebookDate = ebookDate.substring(0,10);
	}
	public int getEbookPrice() {
		return ebookPrice;
	}
	public void setEbookPrice(int ebookPrice) {
		this.ebookPrice = ebookPrice;
	}
	public String getEbookCompany() {
		return ebookCompany;
	}
	public void setEbookCompany(String ebookCompany) {
		this.ebookCompany = ebookCompany;
	}
	public int getEbookPageCount() {
		return ebookPageCount;
	}
	public void setEbookPageCount(int ebookPageCount) {
		this.ebookPageCount = ebookPageCount;
	}
	public String getEbookSummary() {
		return ebookSummary;
	}
	public void setEbookSummary(String ebookSummary) {
		this.ebookSummary = ebookSummary;
	}
	public String getEbookState() {
		return ebookState;
	}
	public void setEbookState(String ebookState) {
		this.ebookState = ebookState;
	}
	public String getEbookImg() {
		return ebookImg;
	}
	public void setEbookImg(String ebookImg) {
		this.ebookImg = ebookImg;
	}
	private int ebookPrice;
	
	private String ebookCompany;
	private int ebookPageCount;
	private String ebookSummary;
	private String ebookState;
	private String ebookImg;
}
