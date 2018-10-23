<%--
  Created by IntelliJ IDEA.
  User: h.zare
  Date: 4/23/2018
  Time: 2:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>

</head>
<body onload="document.f.username.focus();">
<div class="container">
    <div class="content">
        <h2>Login with Username and Password</h2>
        <form name="form" action="/login" method="POST">
            <fieldset>
                <input type="text" name="username" value="" placeholder="Username" />
                <input type="password" name="password" placeholder="Password" />
            </fieldset>
            <input type="submit" id="login" value="Login"
                   class="btn btn-primary" />
        </form>
    </div>
</div>
</body>
</html>