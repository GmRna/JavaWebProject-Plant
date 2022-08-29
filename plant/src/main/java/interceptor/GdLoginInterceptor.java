package interceptor;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;
public class GdLoginInterceptor implements HandlerInterceptor {
	/*
	 preHandle :  컨트롤러 실행전
	 postHandle : 컨트롤러 실행후(뷰리턴전)
	 afterCompletion : 뷰 실행 후
	 */
	@Override
	public boolean preHandle (HttpServletRequest req, HttpServletResponse res, Object handler) throws IOException{
		// 세션 객체에서 loginInfo 이름으로 꺼내서 있으면 (로그인 상태이면) return true
		// 아니면 (로그아웃) return false
		HttpSession sess = req.getSession();
		if(sess.getAttribute("loginGdInfo") == null) {	// 로그아웃 상태			
			//// 이거 인코딩 젤 첨에 써야 인코딩 제대로 됨
			res.setContentType("text/html;charset=utf-8"); // 한글일 경우 써야 안깨져서 나옴
			PrintWriter out = res.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 사용 가능!!!!!')");
			out.println("location.href='/plant/gd/login.do';");
			out.println("</script>");
			out.flush();
			return false;
		}else {			
			return true;
		}
		
	}
}