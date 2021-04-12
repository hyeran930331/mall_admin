/*
 * src 패키지 폴더 안에 
 * gdu.mall.vo 패키지 안에
 * Client.java
 */
package gdu.mall.vo;

public class Client {
	private int clientNo;
	private String clientMail;
	private String clientPw;
	private String clientDate;
	
	public int getClientNo() {
		return clientNo;
	}
	public void setClientNo(int clientNo) {
		this.clientNo = clientNo;
	}
	public String getClientMail() {
		return clientMail;
	}
	public void setClientMail(String clientMail) {
		this.clientMail = clientMail;
	}
	public String getClientPw() {
		return clientPw;
	}
	public void setClientPw(String clientPw) {
		this.clientPw = clientPw;
	}
	public String getClientDate() {
		return clientDate;
	}
	public void setClientDate(String clientDate) {
		this.clientDate = clientDate.substring(0,10);
	}
}