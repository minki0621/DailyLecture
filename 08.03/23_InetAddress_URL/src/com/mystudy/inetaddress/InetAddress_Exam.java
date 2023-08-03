package com.mystudy.inetaddress;

import java.net.InetAddress;
import java.net.UnknownHostException;

public class InetAddress_Exam {

	public static void main(String[] args) throws UnknownHostException {
		// IentAddress : IP주소 관련 클래스
		InetAddress iaddr = InetAddress.getLocalHost();
		System.out.println("iaddr : " + iaddr);
		System.out.println("호스트명 : " + iaddr.getHostName());
		System.out.println("호스트 IP주소 : " + iaddr.getHostAddress());
		
		System.out.println("---- 도메인명으로 주소 검색 ----");
		InetAddress naver = InetAddress.getByName("www.naver.com");
		System.out.println("naver : " + naver);
		
		System.out.println("---- 네이버 IP 주소들 검색 -----");
		InetAddress[] iaArray = InetAddress.getAllByName("www.naver.com");
		for (InetAddress ia : iaArray) {
			System.out.println("호스트명 : " + ia.getHostName());
			System.out.println("호스트 IP주소 : " + ia.getHostAddress());
			
		}
		
	}

}
