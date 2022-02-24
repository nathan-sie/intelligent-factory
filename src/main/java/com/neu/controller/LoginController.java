package com.neu.controller;

import com.neu.codeutil.IVerifyCodeGen;
import com.neu.codeutil.SimpleCharVerifyCodeGenImpl;
import com.neu.codeutil.VerifyCode;
import com.neu.po.User;
import com.neu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;
    @GetMapping("/login")
    public String login(){
        return "login";
    }

    /**
     * 获取验证码方法
     * @param request
     * @param response
     */
    @RequestMapping("/verifyCode")
    public void verifyCode(HttpServletRequest request, HttpServletResponse response) {
        IVerifyCodeGen iVerifyCodeGen = new SimpleCharVerifyCodeGenImpl();
        try {
            //设置长宽
            VerifyCode verifyCode = iVerifyCodeGen.generate(80, 28);
            String code = verifyCode.getCode();
//            LOGGER.info(code);
            //将VerifyCode绑定session
            request.getSession().setAttribute("VerifyCode", code);
            //设置响应头
            response.setHeader("Pragma", "no-cache");
            //设置响应头
            response.setHeader("Cache-Control", "no-cache");
            //在代理服务器端防止缓冲
            response.setDateHeader("Expires", 0);
            //设置响应内容类型
            response.setContentType("image/jpeg");
            response.getOutputStream().write(verifyCode.getImgBytes());
            response.getOutputStream().flush();
        } catch (IOException e) {
//            LOGGER.info("", e);
            System.out.println("异常处理");
        }
    }

    @RequestMapping("/loginIn")
    public String logIn(HttpServletRequest request, Model model){
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String code = request.getParameter("captcha");
        String type=request.getParameter("type");

        HttpSession session=request.getSession();
        if(session==null){
            model.addAttribute("msg","登录超时");
            return "login";
        }



        //验证码是否正确
        String realCode= (String) session.getAttribute("VerifyCode");

        if(realCode.equals(null)){
            model.addAttribute("msg","验证码不能为空");
            return "login";
        }
        else if(!realCode.toLowerCase().equals(code.toLowerCase())){
            model.addAttribute("msg","验证码不正确");
            return "login";
        }

        if(type.equals("1")) {
            User admin = userService.queryUserByNameAndPassword(username, password);
            if (admin == null) {//该用户不存在
                model.addAttribute("msg", "用户名或密码错误");
                return "login";
            }
            session.setAttribute("user", admin);
            session.setAttribute("type","admin");
        } else if(type.equals("2")){
            User owner = userService.queryUserByNameAndPassword(username,password);
            if(owner == null){
                model.addAttribute("msg", "用户名或密码错误");
                return "login";
            }
            session.setAttribute("user",owner);
            session.setAttribute("type","owner");
        } else if(type.equals("3")){
            User dealer = userService.queryUserByNameAndPassword(username,password);
            if(dealer == null){
                model.addAttribute("msg", "用户名或密码错误");
                return "login";
            }
            session.setAttribute("user",dealer);
            session.setAttribute("type","dealer");
        }
        return "index";
    }


    @GetMapping("/loginOut")
    public String loginOut(HttpServletRequest request){
        HttpSession session=request.getSession();
        session.invalidate();;
        return "/login";
    }

}
