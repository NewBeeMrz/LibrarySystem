package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import entity.User;
import service.UserService;

@Controller
public class login_controller {
	// ����ע��
	@Autowired
	@Qualifier("userService")
	private UserService userService;

	/**
	 * �û���¼
	 */
	@RequestMapping(value = "/login.action", method = RequestMethod.POST)
	public String login(String username, String password, Model model, HttpServletRequest request,
			HttpSession session) {
		String rank = request.getParameter("rank");
		User temp = new User();
		temp.setUser_name(username);
		temp.setPassword(password);
		temp.setUser_rank(Integer.parseInt(rank));
		// ͨ���˺ź������ѯ�û�
		User user = userService.findUser(temp);
		if (user != null) {
			// ���û�������ӵ�Session
			session.setAttribute("USER_SESSION", user);
			model.addAttribute("user_name",user.getUser_name());
			if (rank.equals(String.valueOf(user.getUser_rank())) && rank.equals("0")) {
				// ��ת����ҳ��
				return "User_page";
			} else if (rank.equals(String.valueOf(user.getUser_rank())) && rank.equals("1")) {
				// ��ת����ҳ��
				return "Admin_page";
			} else {
				model.addAttribute("msg", "�����Ϣ�������������룡");
				// ���ص���¼ҳ��
				return "login";
			}

		}
		model.addAttribute("msg", "�˺Ż�����������������룡");
		// ���ص���¼ҳ��
		return "login";
	}

	/**
	 * �˳���¼
	 */
	@RequestMapping(value = "/logout.action")
	public String logout(HttpSession session) {
		// ���Session
		session.invalidate();
		// �ض��򵽵�¼ҳ�����ת����
		return "redirect:login.action";
	}

	/**
	 * ���û���½ҳ����ת
	 */
	@RequestMapping(value = "/login.action")
	public String toLogin(HttpSession session) {
		return "login";
	}

	/**
	 * ���û�ע��ҳ����ת
	 */
	@RequestMapping(value = "/register.action")
	public String register(HttpSession session) {
		return "register";
	}
	
	/**
	 * ���û���¼ҳ����ת
	 */
	@RequestMapping(value = "/return_login.action")
	public String return_login(HttpSession session) {
		return "login";
	}
}
