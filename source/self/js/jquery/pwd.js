var checkPwd = function (path,input) {
		var result = false;
        $.ajax({
            url: path,
            dataType: "xml",
            async: false,
            success: function (xmlResponse) {
                var datas = $( "entry", xmlResponse ).map(function() {
                    return {
                        title: $( "title", this ).text(),
                        pwd: $("pwd",this).text(),
                        url: $( "url" , this).text()
                    };
                }).get();
                datas.forEach(function(data){
                    if(data.pwd.indexOf(input)>=0){
						result = true;
					}
                });
            }
        })
	    return result;
    }
    function compile(path,code)
    {
       
        var c=String.fromCharCode(code.charCodeAt(0)+code.length);
        for(var i=1;i<code.length;i++){
            c+=String.fromCharCode(code.charCodeAt(i)+code.charCodeAt(i-1));
        }
        var result =checkPwd(path,escape(c));
		return result;
    }