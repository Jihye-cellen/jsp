package model;

public class PurchaseVO extends UserVO {
	private String pid;
	private int sum;
	private String pdate;
	private int status;
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
	}
	public String getPdate() {
		return pdate;
	}
	public void setPdate(String pdate) {
		this.pdate = pdate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "PurchaseVO [pid=" + pid + ", sum=" + sum + ", pdate=" + pdate + ", status=" + status + ", getPhone()="
				+ getPhone() + ", getAddress1()=" + getAddress1() + ", getAddress2()=" + getAddress2() + ", getUid()="
				+ getUid() + ", getUname()=" + getUname() + "]";
	}
	
}
