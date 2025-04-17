package com.fort4.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fort4.mapper.MemberMapper;

@Controller
public class MemberController extends BaseController {
	
	@Autowired 
	private MemberMapper memberMapper;
	
//	@GetMapping("/delete")
//	public String delete(HttpSession session, Model model) {
//		
//	}
	
	
	/*
	 * // 마이 페이지
	 * 
	 * @GetMapping("/mypage") public String myPage(HttpSession session, Model model)
	 * { MemberDTO user = getLoginUser(session); if (user == null) { return
	 * "redirect:/index"; } model.addAttribute("user", user); return
	 * render("mypage/mypage", model); }
	 * 
	 * // 비밀번호 변경 폼
	 * 
	 * @GetMapping("/mypage/password") public String changePasswordForm(Model model)
	 * { return render("mypage/changePassword", model); }
	 * 
	 * @PostMapping("/mypage/password") public String changePassword(@RequestParam
	 * String currentPw,
	 * 
	 * @RequestParam String newPw, HttpSession session, RedirectAttributes
	 * redirectAttrs) {
	 * 
	 * MemberDTO user = getLoginUser(session); MemberDTO check =
	 * memberMapper.login(user.getUsername(), currentPw); if (check == null) {
	 * redirectAttrs.addFlashAttribute("errorMsg", "현재 비밀번호가 일치하지 않습니다."); return
	 * "redirect:/mypage/password"; }
	 * 
	 * memberMapper.updatePassword(user.getUsername(), newPw);
	 * redirectAttrs.addFlashAttribute("successMsg", "비밀번호가 변경되었습니다."); return
	 * "redirect:/mypage"; }
	 * 
	 * // 회원 탈퇴 폼
	 * 
	 * @GetMapping("/mypage/delete") public String deleteAccountForm(Model model) {
	 * return render("mypage/deleteAccount", model); }
	 * 
	 * @PostMapping("/mypage/delete") public String deleteAccount(@RequestParam
	 * String password, HttpSession session, RedirectAttributes redirectAttrs) {
	 * 
	 * MemberDTO user = getLoginUser(session); MemberDTO check =
	 * memberMapper.login(user.getUsername(), password); if (check == null) {
	 * redirectAttrs.addFlashAttribute("errorMsg", "비밀번호가 일치하지 않습니다."); return
	 * "redirect:/mypage/delete"; }
	 * 
	 * memberMapper.deleteMember(user.getUsername()); session.invalidate(); return
	 * "redirect:/index"; }
	 * 
	 * // 아이디 찾기
	 * 
	 * @GetMapping("/find-id") public String findIdForm(Model model) { return
	 * render("member/findId", model); }
	 * 
	 * @PostMapping("/find-id") public String findId(@RequestParam String name,
	 * 
	 * @RequestParam String birthDate, Model model) { String username =
	 * memberMapper.findUsername(name, birthDate); if (username == null) {
	 * model.addAttribute("errorMsg", "일치하는 회원 정보가 없습니다."); } else {
	 * model.addAttribute("foundId", username); } return render("member/findId",
	 * model); }
	 */
}
