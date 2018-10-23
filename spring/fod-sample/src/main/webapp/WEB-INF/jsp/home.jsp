<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            $("button").click(function () {
                $.ajax({
                    type: 'post',
                    contentType: 'application/json',
                    url: "http://localhost:4041/lang",
                    data: JSON.stringify({"language": "EL", "defaultFlag": "N", "createdBy": "0"}),
                    success: function (result, status, xhr) {
                        $("span").html(JSON.stringify(result));
                    }
                });
            });
        });
    </script>
</head>
<body>

<p>Start typing a name in the input field below:</p>
First name:

<input type="text">
<button>Button 1</button>

<p>Suggestions: <span></span></p>
<span></span>
</body>
</html>
