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
	// 依赖注入
	@Autowired
	@Qualifier("userService")
	private UserService userService;

	/**
	 * 用户登录
	 */
	@RequestMapping(value = "/login.action", method = RequestMethod.POST)
	public String login(String username, String password, Model model, HttpServletRequest request,
			HttpSession session) {
		String rank = request.getParameter("rank");
		User temp = new User();
		temp.setUser_name(username);
		temp.setPassword(password);
		temp.setUser_rank(Integer.parseInt(rank));
		// 通过账号和密码查询用户
		User user = userService.findUser(temp);
		if (user != null) {
			// 将用户对象添加到Session
			session.setAttribute("USER_SESSION", user);
			model.addAttribute("user_name",user.getUser_name());
			if (rank.equals(String.valueOf(user.getUser_rank())) && rank.equals("0")) {
				// 跳转到主页面
				return "User_page";
			} else if (rank.equals(String.valueOf(user.getUser_rank())) && rank.equals("1")) {
				// 跳转到主页面
				return "Admin_page";
			} else {
				model.addAttribute("msg", "身份信息错误，请重新输入！");
				// 返回到登录页面
				return "login";
			}

		}
		model.addAttribute("msg", "账号或密码错误，请重新输入！");
		// 返回到登录页面
		return "login";
	}

	/**
	 * 退出登录
	 */
	@RequestMapping(value = "/logout.action")
	public String logout(HttpSession session) {
		// 清除Session
		session.invalidate();
		// 重定向到登录页面的跳转方法
		return "redirect:login.action";
	}

	/**
	 * 向用户登陆页面跳转
	 */
	@RequestMapping(value = "/login.action")
	public String toLogin(HttpSession session) {
		return "login";
	}

	/**
	 * 向用户注册页面跳转
	 */
	@RequestMapping(value = "/register.action")
	public String register(HttpSession session) {
		return "register";
	}
	
	/**
	 * 向用户登录页面跳转
	 */
	@RequestMapping(value = "/return_login.action")
	public String return_login(HttpSession session) {
		return "login";
	}
}
