/*--cookie插件--*/
jQuery.cookie = function(name, value, options) {
    if (typeof value != 'undefined') { // name and value given, set cookie
        options = options || {};
        if (value === null) {
            value = '';
            options.expires = -1;
        }
        var expires = '';
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
            var date;
            if (typeof options.expires == 'number') {
                date = new Date();
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
            } else {
                date = options.expires;
            }
            expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
        }
        var path = options.path ? '; path=' + options.path : '';
        var domain = options.domain ? '; domain=' + options.domain : '';
        var secure = options.secure ? '; secure' : '';
        document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
    } else { // only name given, get cookie
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                // Does this cookie string begin with the name we want?
                if (cookie.substring(0, name.length + 1) == (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
};

/*--session插件--*/
(function($){

    $.session = {

        _id: null,

        _cookieCache: undefined,

        _init: function()
        {
            if (!window.name) {
                window.name = Math.random();
            }
            this._id = window.name;
            this._initCache();

            // See if we've changed protcols

            var matches = (new RegExp(this._generatePrefix() + "=([^;]+);")).exec(document.cookie);
            if (matches && document.location.protocol !== matches[1]) {
               this._clearSession();
               for (var key in this._cookieCache) {
                   try {
                   window.sessionStorage.setItem(key, this._cookieCache[key]);
                   } catch (e) {};
               }
            }

            document.cookie = this._generatePrefix() + "=" + document.location.protocol + ';path=/;expires=' + (new Date((new Date).getTime() + 120000)).toUTCString();

        },

        _generatePrefix: function()
        {
            return '__session:' + this._id + ':';
        },

        _initCache: function()
        {
            var cookies = document.cookie.split(';');
            this._cookieCache = {};
            for (var i in cookies) {
                var kv = cookies[i].split('=');
                if ((new RegExp(this._generatePrefix() + '.+')).test(kv[0]) && kv[1]) {
                    this._cookieCache[kv[0].split(':', 3)[2]] = kv[1];
                }
            }
        },

        _setFallback: function(key, value, onceOnly)
        {
            var cookie = this._generatePrefix() + key + "=" + value + "; path=/";
            if (onceOnly) {
                cookie += "; expires=" + (new Date(Date.now() + 120000)).toUTCString();
            }
            document.cookie = cookie;
            this._cookieCache[key] = value;
            return this;
        },

        _getFallback: function(key)
        {
            if (!this._cookieCache) {
                this._initCache();
            }
            return this._cookieCache[key];
        },

        _clearFallback: function()
        {
            for (var i in this._cookieCache) {
                document.cookie = this._generatePrefix() + i + '=; path=/; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
            }
            this._cookieCache = {};
        },

        _deleteFallback: function(key)
        {
            document.cookie = this._generatePrefix() + key + '=; path=/; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
            delete this._cookieCache[key];
        },

        get: function(key)
        {
            return window.sessionStorage.getItem(key) || this._getFallback(key);
        },

        set: function(key, value, onceOnly)
        {
            try {
                window.sessionStorage.setItem(key, value);
            } catch (e) {}
            this._setFallback(key, value, onceOnly || false);
            return this;
        },
        
        'delete': function(key){
            return this.remove(key);
        },

        remove: function(key)
        {
            try {
            window.sessionStorage.removeItem(key);
            } catch (e) {};
            this._deleteFallback(key);
            return this;
        },

        _clearSession: function()
        {
          try {
                window.sessionStorage.clear();
            } catch (e) {
                for (var i in window.sessionStorage) {
                    window.sessionStorage.removeItem(i);
                }
            }
        },

        clear: function()
        {
            this._clearSession();
            this._clearFallback();
            return this;
        }

    };

    $.session._init();

})(jQuery);

//base64Encode
!function () {
    //下面是64个基本的编码
    var base64EncodeChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    var base64DecodeChars = new Array(
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63,
        52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1,
        -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
       15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1,
        -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
        41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1);
    //编码的方法
    function base64encode(str) {
        var out, i, len;
        var c1, c2, c3;
        len = str.length;
        i = 0;
        out = "";
        while (i < len) {
            c1 = str.charCodeAt(i++) & 0xff;
            if (i == len) {
                out += base64EncodeChars.charAt(c1 >> 2);
                out += base64EncodeChars.charAt((c1 & 0x3) << 4);
                out += "==";
                break;
            }
            c2 = str.charCodeAt(i++);
            if (i == len) {
                out += base64EncodeChars.charAt(c1 >> 2);
                out += base64EncodeChars.charAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4));
                out += base64EncodeChars.charAt((c2 & 0xF) << 2);
                out += "=";
                break;
            }
            c3 = str.charCodeAt(i++);
            out += base64EncodeChars.charAt(c1 >> 2);
            out += base64EncodeChars.charAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4));
            out += base64EncodeChars.charAt(((c2 & 0xF) << 2) | ((c3 & 0xC0) >> 6));
            out += base64EncodeChars.charAt(c3 & 0x3F);
        }
        return out;
    }

    //解码的方法
    function base64decode(str) {
        var c1, c2, c3, c4;
        var i, len, out;
        len = str.length;
        i = 0;
        out = "";
        while (i < len) {

            do {
                c1 = base64DecodeChars[str.charCodeAt(i++) & 0xff];
            } while (i < len && c1 == -1);
            if (c1 == -1)
                break;

            do {
                c2 = base64DecodeChars[str.charCodeAt(i++) & 0xff];
            } while (i < len && c2 == -1);
            if (c2 == -1)
                break;
            out += String.fromCharCode((c1 << 2) | ((c2 & 0x30) >> 4));

            do {
                c3 = str.charCodeAt(i++) & 0xff;
                if (c3 == 61)
                    return out;
                c3 = base64DecodeChars[c3];
            } while (i < len && c3 == -1);
            if (c3 == -1)
                break;
            out += String.fromCharCode(((c2 & 0XF) << 4) | ((c3 & 0x3C) >> 2));

            do {
                c4 = str.charCodeAt(i++) & 0xff;
                if (c4 == 61)
                    return out;
                c4 = base64DecodeChars[c4];
            } while (i < len && c4 == -1);
            if (c4 == -1)
                break;
            out += String.fromCharCode(((c3 & 0x03) << 6) | c4);
        }
        return out;
    }
    function utf16to8(str) {
        var out, i, len, c;
        out = "";
        len = str.length;
        for (i = 0; i < len; i++) {
            c = str.charCodeAt(i);
            if ((c >= 0x0001) && (c <= 0x007F)) {
                out += str.charAt(i);
            } else if (c > 0x07FF) {
                out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));
                out += String.fromCharCode(0x80 | ((c >> 6) & 0x3F));
                out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
            } else {
                out += String.fromCharCode(0xC0 | ((c >> 6) & 0x1F));
                out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
            }
        }
        return out;
    }
    function utf8to16(str) {
        var out, i, len, c;
        var char2, char3;
        out = "";
        len = str.length;
        i = 0;
        while (i < len) {
            c = str.charCodeAt(i++);
            switch (c >> 4) {
                case 0: case 1: case 2: case 3: case 4: case 5: case 6: case 7:
                    // 0xxxxxxx
                    out += str.charAt(i - 1);
                    break;
                case 12: case 13:
                    // 110x xxxx   10xx xxxx
                    char2 = str.charCodeAt(i++);
                    out += String.fromCharCode(((c & 0x1F) << 6) | (char2 & 0x3F));
                    break;
                case 14:
                    // 1110 xxxx  10xx xxxx  10xx xxxx
                    char2 = str.charCodeAt(i++);
                    char3 = str.charCodeAt(i++);
                    out += String.fromCharCode(((c & 0x0F) << 12) |
                                   ((char2 & 0x3F) << 6) |
                                   ((char3 & 0x3F) << 0));
                    break;
            }
        }
        return out;
    }
    window.base64encode = base64encode;
    window.base64decode = base64decode;
    window.utf16to8 = utf16to8;
    window.utf8to16 = utf8to16;
}();

/*--panda项目插件--*/
window.check = {
    cell:function(input){
        var val = input.val();
        var reg = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
        if(val!="" && !reg.test(val)){
            check.error.alert(input,check.error.errorInfo.celltype);
            return false;
        }
        return true;
    },
    checkcode:function(input){
        var val = input.val();
        var reg = /^\d{6}$/;
        if(val!="" && !reg.test(val)){
            check.error.alert(input,check.error.errorInfo.checkcodetype);
            return false;
        }
        return true;
    },
    name:function(input){
        var val = input.val();
        var reg = /^[a-zA-Z\/\u4e00-\u9fa5]{1,30}$/;
        if(val!="" && !reg.test(val)){
            check.error.alert(input,check.error.errorInfo.nametype);
            return false;
        }
        return true;
    },
    organame:function(input){
        var val = input.val();
        var reg = /^[a-zA-Z\/\u4e00-\u9fa5]{1,50}$/;
        if(val!="" && !reg.test(val)){
            check.error.alert(input,check.error.errorInfo.organametype);
            return false;
        }
        return true;
    },
    mail:function(input){
        var val = input.val();
        var reg = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/;
        if(val!="" && !reg.test(val)){
            check.error.alert(input,check.error.errorInfo.mailtype);
            return false;
        }
        return true;
    },
    select:function(option,input){
        var dataval = input.attr("data-val");
        var idnuminput = input.closest(".form-line").next().next().find('input');
        var idnum = idnuminput.val();
        if(option) dataval = option.attr("data-val");
        var reg = /^[0-9]*$/;
        if(dataval&&parseInt(dataval,10).toString()!="NaN"){
            var outrange = parseInt(dataval,10)<0 || parseInt(dataval,10)>(input.next().find('li').length-1);
            if(outrange || !reg.test(dataval)){
                check.error.alert(input,check.error.errorInfo.selecttype);
                return false;
            }
        }
        if(idnum){
            var checkidno = check.idno(idnuminput,option);
            if(checkidno==false){
                return false;
            }
        }
        return true;
    },
    idno:function(input,option){
        var val = input.val();
        var reg = /^[0]{0}$/;
        var idtypeinput = input.closest(".form-line").prev().prev().find(".input-select");
        var idtype = idtypeinput.attr('data-val');
        if(option){
            idtype = option.attr("data-val");
        }
        if(val!=""){
            if(!idtype) {
                check.error.alert(idtypeinput,check.error.errorInfo.selectnullid);
                return false;
            }
            switch(idtype){
                case "0":
                    reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
                    break;
                case "1":
                    reg = /^1[45][0-9]{7}|G[0-9]{8}|P[0-9]{7}|S[0-9]{7,8}|D[0-9]+$/;
                    break;
                case "2":
                    reg = /^[\sa-zA-Z][a-zA-Z]\d{6}[A-Za-z0-9]$/;
                    break;
                case "3":
                    reg = /^[a-zA-Z0-9]{5,21}$/;
                    break;
                case "4":
                    reg = /^[a-zA-Z0-9]{5,21}$/;
                    break;
                case "5":
                    reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
                    break;
                case "6":
                    reg = /^[a-zA-Z0-9]{5,30}$/;
                    break;
                default:
                    check.select(null,idtypeinput);
                    return false;
            }
            if(!reg.test(val)){
                check.error.alert(input,check.error.errorInfo.idnotype);
                return false;
            }
        } 
        return true;
    },
    string:function(input){
        var length = input.val().trim().length;
        if (length> 100){
            check.error.alert(input,check.error.errorInfo.stringtype);
            return false;
        }
        return true;
    },
    img:function(input){
        var type = input.val().substr(input.val().lastIndexOf(".")).toLowerCase();
        var alertarea =  input.closest('.form-line').next();
        if(type!='.png'&&type!='.jpg'&&type!='.jpeg'&&type!='.gif'&&type!=''){
            check.error.alertrun(alertarea,check.error.errorInfo.imgformattype,0);
            return false;
        };
        if(input[0].files.length>0){
            var size = input[0].files[0].size;
            var filesize = Math.round(size/1024*100)/100;
            if(filesize>500&&type!=''){
                check.error.alertrun(alertarea,check.error.errorInfo.imgsizetype,0);
                return false;
            }
        };
        return true;
    },
    text:function(input){
        var length = input.val().trim().length;
        if (length> 200){
            check.error.alert(input,check.error.errorInfo.texttype);
            return false;
        }
        return true;
    },
    address:function(input){
        var length = input.val().trim().length;
        if (length> 100){
            check.error.alert(input,check.error.errorInfo.addresstype);
            return false;
        }
        return true;
    },
    organo:function(input){
        var val = input.val();
        var reg = /^[a-zA-Z0-9]{5,30}$/;
        if(val!="" && !reg.test(val)){
            check.error.alert(input,check.error.errorInfo.organotype);
            return false;
        }
        return true;
    },
    date:function(input){
        var val = input.val();
        if(val!=""){
            var date = new Date(val).getTime();
            if( date<0){
                check.error.alert(input,check.error.errorInfo.datetype);
                return false;
            }  
        }
        return true;
    },
    money:function(input){
        var val = input.val();
        var reg = /^[1-9]{1}\d{0,4}(.[0-9]{1,2}){0,1}$/;
        if(val!="" && !reg.test(val)){
            check.error.alert(input,check.error.errorInfo.moneytype);
            return false;
        }
        return true;
    },
    checkid:function(input){
        var val = input.val();
        var reg = /^[0-9]{5,30}$/;
        if(val!="" && !reg.test(val)){
            check.error.alert(input,check.error.errorInfo.checkidtype);
            return false;
        }
        return true;
    },
    require:{
        cell:function(input){
            var val = input.val();
            if(val=="") {
                check.error.alert(input,check.error.errorInfo.cellnull);
                return false;
            }
            return true;
        },
        checkcode:function(input){
            var val = input.val();
            if(val=="") {
                check.error.alert(input,check.error.errorInfo.checkcodenull);
                return false;
            }
            return true;
        },
        name:function(input){
            var val = input.val();
            if(val=="") {
                check.error.alert(input,check.error.errorInfo.namenull);
                return false;
            }
            return true;
        },
        mail:function(input){
            var val = input.val();
            if(val=="") {
                check.error.alert(input,check.error.errorInfo.mailnull);
                return false;
            }
            return true;
        },
        select:function(input){
            var dataval = input.attr("data-val");
            if(!dataval) {
                check.error.alert(input,check.error.errorInfo.selectnull);
                return false;
            }
            return true;
        },
        money:function(input){
            var val = input.val();
            if(val=="") {
                check.error.alert(input,check.error.errorInfo.moneynull);
                return false;
            }
            return true;
        },
        date:function(input){
            var val = input.val();
            if(val=="") {
                check.error.alert(input,check.error.errorInfo.datenull);
                return false;
            }
            return true;
        },
        address:function(input){
            var val = input.val();
            if(val=="") {
                check.error.alert(input,check.error.errorInfo.addressnull);
                return false;
            }
            return true;
        },
        checkid:function(input){
            var val = input.val();
            if(val=="") {
                check.error.alert(input,check.error.errorInfo.checkidnull);
                return false;
            }
            return true;
        }
    },
    error:{
        errorInfo:{
            /*--
                type表示格式错误，
                error表示内容错误，
                fail表示返回通信失败，
                success表示返回通信成功，
                null表示内容没有填写。
            --*/
            celltype:"手机号码格式填写有误",
            cellnull:"请填写手机号码",
            checkcodetype:"验证码填写格式写有误",
            checkcodenull:"请填写手机验证码",
            nametype:"姓名格式有误",
            namenull:"请填写姓名",
            mailtype:"邮箱地址格式有误",
            mailnull:"请填写邮箱地址",
            selecttype:"您的选项选值格式有误",
            selectnullid:"请选择证件类型",
            selectnull:"请选择正确的投资人",
            idnotype:"您的证件号码格式有误",
            imgformattype:"请上传图片文件",
            imgsizetype:"图片文件过大，请上传500K以下的图片",
            texttype:"描述文字请误超过200字",
            addresstype:"地址请误超过100字",
            addressnull:"请填写地址",
            organotype:"注册机构号格式有误",
            organametype:"机构名称格式有误",
            datetype:"填写时间格式有误",
            datenull:"请填写到位时间",
            moneytype:"资金最小单位0.01万，且不超过10亿",
            moneynull:"请填写资金",
            stringtype:"字数不能超过100字",
            checkidtype:"购买时证件号码类型有误",
            checkidnull:"请填写购买时证件号码",
            sendcodesuccess:"手机验证码发送成功",
            sendcodefail:"手机验证码发送失败,请再次尝试",
            registersuccess:"绑定成功",
            registerfail:"由于网络原因绑定未成功,请再次尝试",
            creatprofilesuccess:"创建用户成功",
            creatprofilefail:"由于网络原因创建用户未成功,请再次尝试",
            sendmailsuccess:"发送邮件成功",
            sendmailfail:"由于网络原因发送邮件未成功,请再次尝试",
            customercreatpersonalsuccess:"创建个人客户成功",
            customercreatpersonalfail:"由于网络原因创建个人客户未成功,请再次尝试",
            customerupdatepersonalsuccess:"更新个人客户成功",
            customerupdatepersonalfail:"由于网络原因更新个人客户未成功,请再次尝试",
            customercreatorganizalsuccess:"创建机构客户成功",
            customercreatorganizalfail:"由于网络原因发送创建机构客户未成功,请再次尝试",
            customerupdateorganizalsuccess:"更新机构客户成功",
            customerupdateorganizalfail:"由于网络原因更新机构客户未成功,请再次尝试",
            appointmentcreatsuccess:"创建预约成功",
            appointmentcreatfail:"由于网络原因创建预约未成功,请再次尝试",
            appointmentupdatesuccess:"提交更新订单信息成功",
            appointmentupdatefail:"由于网络原因更新订单未成功,请再次尝试",
            appointmentupdateneed:"汇款信息没有填完整",
            appointmentdeletesuccess:"删除订单信息成功",
            appointmentdeletefail:"由于网络原因删除订单未成功,请再次尝试",
            investchecksuccess:"验证信息成功",
            investcheckfail:"由于网络原因验证信息未成功,请再次尝试",
            investcheckerror:"证件号错误",
            profileUpdatesuccess:"更新个人信息成功",
            profileUpdatefail:"由于网络原因更新信息未成功,请再次尝试",
            moneydeletesuccess:"删除报单成功",
            moneydeletefail:"由于网络原因删除报单未成功,请再次尝试"
        },
        alert:function(input,error){
            var id = input.attr('id');
            var box = $($(input).closest('form').find('[role= "alert"][name="' + id + '"]')[0]);
            this.alertrun(box,error,0);
        },
        alertfail:function(inputalert,id,error){
            var id = inputalert.attr('id');
            var box = $($(inputalert).closest('form').find('[role= "alert"][name="' + id + '"]')[0]);
            this.alertrun(box,error,1);
        },
        alertsuccess:function(inputalert,error){
            this.alertrun(inputalert,error,2);
        },
        alertrun:function(inputalert,error,type){
            switch(type){
                /*普通报错不走弹窗流程*/
                case 0:
                    inputalert.html(error).addClass('active');
                    break;
                /*报错信息*/
                case 1:
                    inputalert.html(error).addClass('active');
                    $("#pop").removeClass("hide").find(".pop-test").empty().removeClass('popsub').text(error);
                    pop.appear= setTimeout(function(){
                        $("#pop .pop-alert").addClass('appear');
                    },100);
                    pop.disappear= setTimeout(function(){
                        $("#pop .pop-alert").removeClass('appear');
                    },2500);
                    pop.hide=setTimeout(function(){
                        $("#pop").addClass('hide');
                    },2900);
                    break;
                /*成功信息*/
                case 2:
                    $("#pop").removeClass("hide").find(".pop-test").empty().addClass('popsub').text("提交成功")
                    .prepend('<i class="icon icon-success"></i>').append('<span class="sub"></span>')
                    .find('.sub').text(error);
                    pop.appear=setTimeout(function(){
                        $("#pop .pop-alert").addClass('appear');
                    },100);
                    pop.disappear=setTimeout(function(){
                        $("#pop .pop-alert").removeClass('appear');
                    },2500);
                    pop.hide=setTimeout(function(){
                        $("#pop").addClass('hide');
                    },2900);
                    //3-0.3-0.3-2.2=0.2;
                    break;
                /*确认选择框*/
                //暂时去掉了
            }
        },
        hiderun:function(input){
            $('[role= "alert"][name="' + input.attr('id') + '"]').removeClass('active');
        },
        hide:function(input){
            $(input).removeClass('active');
        },
        hideall:function(input){
            $(input.closest('form').find('[role= "alert"]')).removeClass('active');
        }
    },
    unbind:{
        btn:function(btn,event){
            $(btn).unbind(event);
            $("#form button").bind(event,function(e){
                e.preventDefault();
            });
        }
    },
    load:function(){
        $("#form input[type=text],\
            #form input[type=number],\
            #form input[type=email],\
            #form input[type=date],\
            #form textarea").bind("focus",function(){
            check.error.hiderun($(this));
        });
        $("#form input[type=file]").bind("click",function(){
            var alert = $(this).closest(".form-line").next();
            check.error.hide(alert);
        });
        $("#form button").bind("click",function(e){
            e.preventDefault();
        });
        $("#form .submit-btn").bind("click",function(){
            check.error.hiderun($(this));
        });
        $("#inputCell, #inputCellP, #inputCellO").bind("blur",function(){
            check.cell($(this));
        });
        $("#inputCheckcode").bind("blur",function(){
            check.checkcode($(this));
        });
        $("#inputName, #inputNameP,#inputNickName").bind("blur",function(){
            check.name($(this));
        });
        $("#inputNameO").bind("blur",function(){
            check.organame($(this));
        });
        $("#inputMail").bind("blur",function(){
            check.mail($(this));
        });
        //模拟select的特殊验证
        $("#inputId_typeP+.select-ul li").bind("click",function(){
            check.select($(this),$(this).closest('.selectinput').find('.input-select'));
        });
        $("#inputId_noP").bind("blur",function(){
            check.idno($(this));
        });
        //图片格式大小验证
        $("#inputId_frontP,\
        #inputId_backP,\
        #inputBusiness_licensesO,\
        #inputOther,\
        #inputImgSend").bind("blur",function(){
            check.img($(this));
        });
        //图片实时显示
        $("#inputId_frontP,\
        #inputId_backP,\
        #inputBusiness_licensesO,\
        #inputOther,\
        #inputImgSend").bind("change",function(e){
            if(check.img($(this))){
                var input = $(this);
                var f = input[0].files[0];
                var label = input.prev();
                var reader = new FileReader();
                reader.onload=function(e){
                    input.attr('data-code',reader.result);
                    var img = $("<img />").attr('src',reader.result);
                    label.empty().append(img);
                }
                if(f){
                   reader.readAsDataURL(f); 
                }
            }
        });
        $('#inputRemarkP,\
         #inputRemarkO,\
          #inputRemark').bind("blur",function(){
            check.text($(this));
        });
        $('#inputAddress').bind("blur",function(){
            check.address($(this));
        });
        $('#inputOrgan_regO').bind("blur",function(){
            check.organo($(this));
        });
        $('#inputDate').bind("blur",function(){
            check.date($(this));
        });
        $('#inputMoney').bind("blur",function(){
            check.money($(this));
        });
        $("#inputCheckId").bind("blur",function(){
            check.checkid($(this));
        });
    }
};

window.submit = {
    sendRegeistCode:function(btn){
        var form = btn.closest('form');
        if(!this.validate.sendRegeistCode(form))return false;
        var cellNum = form.find('#inputCell').val();
        check.error.hideall(btn);
        check.unbind.btn(btn,"click");
        $.ajax({
            url:getInfo.getUrl.fullurl('api/users/send_code'),
            type:'GET',
            data:{cell:cellNum},
            dataType:"json",
            success:function(data){
                check.error.alertsuccess(btn,check.error.errorInfo.sendcodesuccess);
                var i=180;
                var btnword = btn.html();
                var countTurn = function(){
                    i=i-1;
                    btn.removeClass('blue-btn').addClass('grey-btn').html("还剩"+i+"秒可以再次发送");
                    if(i==0){
                        btn.removeClass('grey-btn').addClass('blue-btn').html(btnword);
                        clearInterval(run);
                        submit.bind.sendRegeistCodeBind();
                    }
                }
                var run = setInterval(countTurn,1000);
            },
            error:function(data){
                check.error.alertfail(btn,"error",check.error.errorInfo.sendcodefail);
                submit.bind.sendRegeistCodeBind();
            }
        });
    },
    registerSubmit:function(btn){
        var form = btn.closest('form');
        if(!this.validate.registerSubmit(form))return false;
        var cellNum = form.find('#inputCell').val();
        var checkCodeNum = form.find('#inputCheckcode').val();
        var ref= window.location.href,
        openidpara = ref.split('?')[1],
        oid = "",
        uid = "";
        if(openidpara){
            if(openidpara.split('?')[0]&&openidpara.split('?')[0].split('=')){
                oid = openidpara.split('?')[0].split('=')[1];
            }
            if(openidpara.split('?')[1]&&openidpara.split('?')[1].split('=')){
                uid = openidpara.split('?')[0].split('=')[1];
            }
        }
        check.error.hideall(btn);
        check.unbind.btn(btn,"click");
        $.ajax({
            url:getInfo.getUrl.fullurl('api/users'),
            type:'POST',
            data:{
                user:
                {
                    cell: cellNum,
                    code: checkCodeNum,
                    open_id: oid
                }
            },
            dataType:"json",
            success:function(data){
                if(data.user && data.user.id>0){
                    check.error.alertsuccess(btn,check.error.errorInfo.registersuccess);
                    setTimeout(function(){
                        getInfo.setSession('HIMS_APP_STORE',data.user);
                        getInfo.turnprofilemine();
                    },3000);
                }else{
                    check.error.alertfail(btn,"error",check.error.errorInfo.registerfail);
                    submit.bind.registerSubmitBind();
                }
            },
            error:function(data){
                check.error.alertfail(btn,"error",check.error.errorInfo.registerfail);
                submit.bind.registerSubmitBind();
            }
        });
    },
    profileCreatSubmit:function(btn){
        var form = btn.closest('form');
        if(!this.validate.profileCreatSubmit(form))return false;
        var store = getInfo.checkstorage();
        var name = form.find('#inputName').val();
        var mail = form.find('#inputMail').val();
        check.error.hideall(btn);
        check.unbind.btn(btn,"click");
        $.ajax({
            url:getInfo.getUrl.fullurl('api/users/' + store.id),
            type:'PATCH',
            data:{
                user:
                {
                    name: name,
                    id_type : "个人",
                    email: mail
                }
            },
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\""+store.open_id+"\"")
            },
            success:function(data){
                if(data.user && data.user.id>0){
                    check.error.alertsuccess(btn,check.error.errorInfo.creatprofilesuccess);
                    setTimeout(function(){
                        getInfo.setSession('HIMS_APP_STORE',data.user);
                        getInfo.turnmenu("invest-list");
                    },3000);
                }else{
                    check.error.alertfail(btn,"error",check.error.errorInfo.creatprofilefail);
                    submit.bind.profileCreatSubmitBind();
                }
            },
            error:function(data){
                check.error.alertfail(btn,"error",check.error.errorInfo.creatprofilefail);
                submit.bind.profileCreatSubmitBind();
            }
        });
    },
    sendMailProduct:function(btn){
        var form = btn.closest('form');
        if(!this.validate.sendMailProduct(form))return false;
        var pid = getInfo.getUrlPara()[0];
        if(!pid)return false;
        var mail = form.find('#inputMail').val();
        check.error.hideall(btn);
        check.unbind.btn(btn,"click");
        $.ajax({
            url:getInfo.getUrl.fullurl('api/products/' + pid + '/send_mail'),
            type:'GET',
            data:{email:mail},
            dataType:"json",
            success:function(data){
                check.error.alertsuccess(btn,check.error.errorInfo.sendmailsuccess);
                var i=180;
                var btnword = btn.html();
                var countTurn = function(){
                    i=i-1;
                    btn.addClass('grey').html("还剩"+i+"秒<br/>可以再次发送");
                    if(i==0){
                        btn.removeClass('grey').html(btnword);
                        clearInterval(run);
                        submit.bind.sendMailProductBind();
                    }
                }
                var run = setInterval(countTurn,1000);
            },
            error:function(data){
                check.error.alertfail(btn,"error",check.error.errorInfo.sendmailfail);
                submit.bind.sendMailProductBind();
            }
        });
    },
    loginSubmit:function(btn){
        var form = btn.closest('form');
        if(!this.validate.loginSubmit(form))return false;
        var open_id = form.find('#inputOpenid').val();
        var uid = form.find('#inputUid').val();
        check.error.hideall(btn);
        check.unbind.btn(btn,"click");
        $.ajax({
            url:getInfo.getUrl.fullurl('api/users/' + uid),
            type:'GET',
            data:{},
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + open_id + "\"");
            },
            success:function(data){
                if(data.user && data.user.id>0){
                    setTimeout(function(){
                        getInfo.setSession('HIMS_APP_STORE',data.user);
                        getInfo.menu();
                    },3000);
                }else{
                    submit.bind.loginSubmitBind();
                }
            },
            error:function(data){
                submit.bind.loginSubmitBind();
            }
        });
    },
    customerCreatPersonalSubmit:function(btn){
        var form = btn.closest('form');
        var store = getInfo.checkstorage();
        if(!this.validate.customerCreatPersonalSubmit(form))return false;
        var individual = {
            name:form.find('#inputNameP').val(),
            cell:form.find('#inputCellP').val(),
            remark_name:store.name,
            id_type:form.find('#inputId_typeP').val(),
            id_no:form.find('#inputId_noP').val(),
            id_front:form.find('#inputId_frontP').attr('data-code'),
            id_back:form.find('#inputId_backP').attr('data-code'),
            remark:form.find('#inputRemarkP').val().trim()
        };
        check.error.hideall(btn);
        check.unbind.btn(btn,"click");
        $.ajax({
            url:getInfo.getUrl.fullurl('api/individuals'),
            type:'POST',
            data:{
                "individual":individual
            },
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                if(data.individual && data.individual.id>0){
                    check.error.alertsuccess(btn,check.error.errorInfo.customercreatpersonalsuccess);
                    setTimeout(function(){
                        getInfo.turncustomerdetail('individual',data.individual.id);
                    },3000);
                }else{
                    check.error.alertfail(btn,"error",check.error.errorInfo.customercreatpersonalfail);
                    submit.bind.customerCreatPersonalSubmitBind();
                }
            },
            error:function(data){
                check.error.alertfail(btn,"error",check.error.errorInfo.customercreatpersonalfail);
                submit.bind.customerCreatPersonalSubmitBind();
            }
        });
    },
    customerUpdatePersonalSubmit:function(btn){
        var form = btn.closest('form');
        var store = getInfo.checkstorage();
        var pid = btn.attr('data-pid');
        var back = btn.attr('data-back');
        if(!this.validate.customerUpdatePersonalSubmit(form))return false;
        var individual = {
            name:form.find('#inputNameP').val(),
            cell:form.find('#inputCellP').val(),
            remark_name:store.name,
            id_type:form.find('#inputId_typeP').val(),
            id_no:form.find('#inputId_noP').val(),
            id_front:form.find('#inputId_frontP').attr('data-code'),
            id_back:form.find('#inputId_backP').attr('data-code'),
            remark:form.find('#inputRemarkP').val().trim()
        };
        check.error.hideall(btn);
        check.unbind.btn(btn,"click");
        $.ajax({
            url:getInfo.getUrl.fullurl('api/individuals/' + pid),
            type:'PATCH',
            data:{
                "individual":individual
            },
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                if(data.individual && data.individual.id>0){
                    check.error.alertsuccess(btn,check.error.errorInfo.customerupdatepersonalsuccess);
                    setTimeout(function(){
                        if(back){
                            window.history.back();
                        }else{
                            window.location.reload(true);
                        }
                    },3000);
                }else{
                    check.error.alertfail(btn,"error",check.error.errorInfo.customerupdatepersonalfail);
                    submit.bind.customerUpdatePersonalSubmitBind();
                }
            },
            error:function(data){
                check.error.alertfail(btn,"error",check.error.errorInfo.customerupdatepersonalfail);
                submit.bind.customerUpdatePersonalSubmitBind();
            }
        });
    },
    customerCreatOrganizalSubmit:function(btn){
        var form = btn.closest('form');
        var store = getInfo.checkstorage();
        if(!this.validate.customerCreatOrganizalSubmit(form))return false;
        var institution = {
            name:form.find('#inputNameO').val(),
            cell:form.find('#inputCellO').val(),
            remark_name:store.name,
            organ_reg:form.find('#inputOrgan_regO').val(),
            business_licenses:form.find('#inputBusiness_licensesO').attr('data-code'),
            remark:form.find('#inputRemarkO').val().trim()
        };
        check.error.hideall(btn);
        check.unbind.btn(btn,"click");
        $.ajax({
            url:getInfo.getUrl.fullurl('api/institutions'),
            type:'POST',
            data:{
                "institution":institution
            },
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                if(data.institution && data.institution.id>0){
                    check.error.alertsuccess(btn,check.error.errorInfo.customercreatorganizalsuccess);
                    setTimeout(function(){
                        getInfo.turncustomerdetail('institution',data.institution.id);
                    },3000);
                }else{
                    check.error.alertfail(btn,"error",check.error.errorInfo.customercreatorganizalfail);
                    submit.bind.customerCreatOrganizalSubmitBind();
                }
            },
            error:function(data){
                check.error.alertfail(btn,"error",check.error.errorInfo.customercreatorganizalfail);
                submit.bind.customerCreatOrganizalSubmitBind();
            }
        });
    },
    customerUpdateOrganizalSubmit:function(btn){
        var form = btn.closest('form');
        var store = getInfo.checkstorage();
        var oid = btn.attr('data-oid');
        var back = btn.attr('data-back');
        if(!this.validate.customerUpdateOrganizalSubmit(form))return false;
        var institution = {
            name:form.find('#inputNameO').val(),
            cell:form.find('#inputCellO').val(),
            remark_name:store.name,
            organ_reg:form.find('#inputOrgan_regO').val(),
            business_licenses:form.find('#inputBusiness_licensesO').attr('data-code'),
            remark:form.find('#inputRemarkO').val().trim()
        };
        check.error.hideall(btn);
        check.unbind.btn(btn,"click");
        $.ajax({
            url:getInfo.getUrl.fullurl('api/institutions/' + oid),
            type:'PATCH',
            data:{
                "institution":institution
            },
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                if(data.institution && data.institution.id>0){
                    check.error.alertsuccess(btn,check.error.errorInfo.customerupdateorganizalsuccess);
                    setTimeout(function(){
                        if(back){
                            window.history.back();
                        }else{
                            window.location.reload(true); 
                        }
                    },3000);
                }else{
                    check.error.alertfail(btn,"error",check.error.errorInfo.customerupdateorganizalfail);
                    submit.bind.customerUpdatePersonalSubmitBind();
                }
            },
            error:function(data){
                check.error.alertfail(btn,"error",check.error.errorInfo.customerupdateorganizalfail);
                submit.bind.customerUpdatePersonalSubmitBind();
            }
        });
    },
    appointmentCreatSubmit:function(btn){
        var form = btn.closest('form');
        var store = getInfo.checkstorage();
        if(!store.name || !store.email){
            getInfo.turnprofilemine();
        }
        var pid = btn.attr('data-pid');
        if(!this.validate.appointmentCreatSubmit(form))return false;
        var order = {
            investable_id:form.find('#inputInvesterSelect').attr('data-val'),
            product_id:pid,
            amount:form.find('#inputMoney').val(),
            due_date:form.find('#inputDate').val(),
            mail_address:form.find('#inputAddress').val(),
            other:form.find('#inputOther').attr('data-code'),
            remark:form.find('#inputRemark').val().trim()
        };
        check.error.hideall(btn);
        check.unbind.btn(btn,"click");
        $.ajax({
            url:getInfo.getUrl.fullurl('api/orders'),
            type:'POST',
            data:{
                order:order
            },
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                if(data.order && data.order.id>0){
                    check.error.alertsuccess(btn,check.error.errorInfo.appointmentcreatsuccess);
                    setTimeout(function(){
                         getInfo.turnappointmentdetailstep1(data.order.id)
                    },3000);
                }else{
                    check.error.alertfail(btn,"error",check.error.errorInfo.appointmentcreatfail);
                    submit.bind.appointmentCreatSubmitBind();
                }
            },
            error:function(data){
                check.error.alertfail(btn,"error",check.error.errorInfo.appointmentcreatfail);
                submit.bind.appointmentCreatSubmitBind();
            }
        });
    },
    appointmentUpdateSubmit:function(btn){
        var form = btn.closest('form');
        var store = getInfo.checkstorage();
        var oid = btn.attr('data-oid');
        if(!this.validate.appointmentUpdateSubmit(form))return false;
        //订单更新
        var orderUpdate = {
            deliver:form.find("#inputSendState").val(),
            remark:form.find("#inputRemark").val()
        };
        //报单提交
        var infoSubmit={};
        var infolist = form.find("#infoForm :not(.finished) [id^=info]");
        if (infolist && infolist.length>0){
            var t=0;
            for(var i=0;i<infolist.length;i++){
                var id = $(infolist[i]).attr('data-id');
                var type = $(infolist[i]).attr('data-field_type');
                infoSubmit[id] = {};
                if(type=="photo"){
                    if($(infolist[i]).attr('data-code')){
                        infoSubmit[id][type] = $(infolist[i]).attr('data-code')
                    }
                }else{
                    infoSubmit[id][type] = $(infolist[i]).val();
                }
                if(!infoSubmit[id][type]){
                    delete infoSubmit[id];
                }else{
                    t++;
                }
            }
            infoSubmit = t>0?infoSubmit:null;
        }
        //汇款提交
        var  moneySubmit = {
            order_id:oid,
            attach: form.find("#inputImgSend").attr('data-code'),
            amount: form.find("#inputMoney").val(),
            date:form.find("#inputDate").val(),
        }
        if(moneySubmit.amount||moneySubmit.date){
            if(!moneySubmit.amount||!moneySubmit.date){
                check.error.alertfail(btn,"error",check.error.errorInfo.appointmentupdateneed);
                return false;
            }
        }
        var states = true;
        check.error.hideall(btn);
        check.unbind.btn(btn,"click");
        $.ajax({
            url:getInfo.getUrl.fullurl('api/orders/'+oid),
            type:'PATCH',
            async: false,
            data:{
                order:orderUpdate
            },
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
            },
            error:function(data){
                states=false;
            }
        });
        if(infoSubmit){
            $.ajax({
                url:getInfo.getUrl.fullurl('api/orders/'+ oid + '/update_infos'),
                type:'PATCH',
                async: false,
                data:{
                    infos:infoSubmit
                },
                dataType:"json",
                beforeSend:function(XMLHttpRequest){
                    XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
                },
                success:function(data){
                },
                error:function(data){
                    states=false;
                }
            });
        }
        if(moneySubmit.attach || moneySubmit.amount || moneySubmit.date){
           $.ajax({
                url:getInfo.getUrl.fullurl('api/orders/'+ oid + '/money_receipts'),
                type:'POST',
                async: false,
                data:{
                    money_receipt:moneySubmit
                },
                dataType:"json",
                beforeSend:function(XMLHttpRequest){
                    XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
                },
                success:function(data){
                },
                error:function(data){
                    states=false;
                }
            }); 
        }
        if(states==true){
            check.error.alertsuccess(btn,check.error.errorInfo.appointmentupdatesuccess);
            setTimeout(function(){
                 window.location.reload(true);
            },3000);
        }else{
            check.error.alertfail(btn,"error",check.error.errorInfo.appointmentupdatefail);
            submit.bind.appointmentUpdateSubmitBind();
        }
    },
    appointmentDeleteSubmit:function(btn){
        var store = getInfo.checkstorage();
        var oid = btn.attr('data-oid');
        check.error.hideall(btn);
        check.unbind.btn(btn,"click");
        $.ajax({
            url:getInfo.getUrl.fullurl('api/orders/'+ oid),
            type:'DELETE',
            data:{},
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                check.error.alertsuccess(btn,check.error.errorInfo.appointmentdeletesuccess);
                setTimeout(function(){
                    getInfo.turnappointmentmine();
                },3000);
            },
            error:function(data){
                check.error.alertfail(btn,"error",check.error.errorInfo.appointmentdeletefail);
                submit.bind.appointmentDeleteSubmitBind();
            }
        });
    },
    investCheckSubmit:function(btn){
        var form = btn.closest('form');
        var store = getInfo.checkstorage();
        var checkid = $('#inputCheckId').val();
        if(!this.validate.investCheckSubmit(form))return false;
        $.ajax({
            url:getInfo.getUrl.fullurl('api/orders/by_number'),
            type:'GET',
            data:{'number':checkid},
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                if(data&&data.length>0){
                    check.error.alertsuccess(btn,check.error.errorInfo.investchecksuccess);
                    window.localStorage.setItem("HIMS_APP_CHECKID",checkid);
                    setTimeout(function(){
                        getInfo.turninvestmineinvestor(checkid);
                    },3000);
                }else{
                    check.error.alertfail(btn,"error",check.error.errorInfo.investcheckerror);
                    submit.bind.appointmentDeleteSubmitBind();
                }
            },
            error:function(data){
                check.error.alertfail(btn,"error",check.error.errorInfo.investcheckfail);
                submit.bind.appointmentDeleteSubmitBind();
            }
        });
    },
    profileUpdateSubmit:function(btn){
        var form = btn.closest('form');
        var store = getInfo.checkstorage();
        var uid = store.id;
        if(!this.validate.profileUpdateSubmit(form))return false;
        var user={
            name: $("#inputName").val(),
            email: $("#inputMail").val(),
            id_type: $("#type-select").val(),
            nickname: $("#inputNickName").val(),
            gender: $("#inputRender").val(),
            address: $("#inputAddress").val(),
            card_type: $("#inputId_typeP").val(),
            card_no: $("#inputId_noP").val(),
            card_front: $("#inputId_frontP").attr("data-code"),
            card_back: $("#inputId_backP").attr("data-code"),
            remark: $("#inputRemarkP").val()
        };
        check.error.hideall(btn);
        check.unbind.btn(btn,"click");
        $.ajax({
            url:getInfo.getUrl.fullurl('api/users/'+uid),
            type:'PATCH',
            data:{'user':user},
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                if(data.user && data.user.id>0){
                    check.error.alertsuccess(btn,check.error.errorInfo.profileUpdatesuccess);
                    setTimeout(function(){
                        window.history.back();
                    },3000);
                }else{
                    check.error.alertfail(btn,"error",check.error.errorInfo.profileUpdatefail);
                    submit.bind.profileUpdateSubmitBind();
                }
            },
            error:function(data){
                check.error.alertfail(btn,"error",check.error.errorInfo.profileUpdatefail);
                submit.bind.profileUpdateSubmitBind();
            }
        });
    },
    moneyDeleteSubmit:function(btn){
        var form = btn.closest('form');
        var store = getInfo.checkstorage();
        var oid = btn.attr("data-oid");
        var mid = btn.attr("data-mid");
        check.error.hideall(btn);
        check.unbind.btn(btn,"click");
        $.ajax({
            url:getInfo.getUrl.fullurl('api/orders/' + oid + '/money_receipts/' + mid),
            type:'DELETE',
            data:{},
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                check.error.alertsuccess(btn,check.error.errorInfo.moneydeletesuccess);
                setTimeout(function(){
                    window.location.reload(true);
                },3000);
            },
            error:function(data){
                check.error.alertfail(btn,"error",check.error.errorInfo.moneydeletefail);
                submit.bind.profileUpdateSubmitBind();
            }
        });
    },
    validate:{
        sendRegeistCode:function(form){
            if(!check.require.cell(form.find('#inputCell'))){
                return false;
            }
            if(!check.cell(form.find('#inputCell'))){
                return false;
            }
            return true;
        },
        registerSubmit:function(form){
            if(!check.require.cell(form.find('#inputCell'))){
                return false;
            }
            if(!check.require.checkcode(form.find('#inputCheckcode'))){
                return false;
            }
            if(!check.cell(form.find('#inputCell'))){
                return false;
            }
            if(!check.checkcode(form.find('#inputCheckcode'))){
                return false;
            }
            return true;
        },
        profileCreatSubmit:function(form){
            if(!check.require.name(form.find('#inputName'))){
                return false;
            }
            if(!check.require.mail(form.find('#inputMail'))){
                return false;
            }
            if(!check.name(form.find('#inputName'))){
                return false;
            }
            if(!check.mail(form.find('#inputMail'))){
                return false;
            }
            return true;
        },
        sendMailProduct:function(form){
            if(!check.require.mail(form.find('#inputMail'))){
                return false;
            }
            if(!check.mail(form.find('#inputMail'))){
                return false;
            }
            return true;
        },
        loginSubmit:function(form){
            //目前未做验证；
            return true;
        },
        customerCreatPersonalSubmit:function(form){
            if(!check.require.name(form.find('#inputNameP'))){
                return false;
            }
            if(!check.require.cell(form.find('#inputCellP'))){
                return false;
            }
            if(!check.name(form.find('#inputNameP'))){
                return false;
            }
            if(!check.cell(form.find('#inputCellP'))){
                return false;
            }
            if(!check.select(null,form.find('#inputId_typeP'))){
                return false;
            }
            if(!check.idno(form.find('#inputId_noP'))){
                return false;
            }
            if(!check.img(form.find('#inputId_frontP'))){
                return false;
            }
            if(!check.img(form.find('#inputId_backP'))){
                return false;
            }
            if(!check.text(form.find('#inputRemarkP'))){
                return false;
            }
            return true;
        },
        customerUpdatePersonalSubmit:function(form){
            if(!check.require.name(form.find('#inputNameP'))){
                return false;
            }
            if(!check.require.cell(form.find('#inputCellP'))){
                return false;
            }
            if(!check.name(form.find('#inputNameP'))){
                return false;
            }
            if(!check.cell(form.find('#inputCellP'))){
                return false;
            }
            if(!check.select(null,form.find('#inputId_typeP'))){
                return false;
            }
            if(!check.idno(form.find('#inputId_noP'))){
                return false;
            }
            if(!check.img(form.find('#inputId_frontP'))){
                return false;
            }
            if(!check.img(form.find('#inputId_backP'))){
                return false;
            }
            if(!check.text(form.find('#inputRemarkP'))){
                return false;
            }
            return true;
        },
        customerCreatOrganizalSubmit:function(form){
            if(!check.require.name(form.find('#inputNameO'))){
                return false;
            }
            if(!check.require.cell(form.find('#inputCellO'))){
                return false;
            }
            if(!check.name(form.find('#inputNameO'))){
                return false;
            }
            if(!check.cell(form.find('#inputCellO'))){
                return false;
            }
            if(!check.organo(form.find('#inputOrgan_regO'))){
                return false;
            }
            if(!check.img(form.find('#inputBusiness_licensesO'))){
                return false;
            }
            if(!check.text(form.find('#inputRemarkO'))){
                return false;
            }
            return true;
        },
        customerUpdateOrganizalSubmit:function(form){
            if(!check.require.name(form.find('#inputNameO'))){
                return false;
            }
            if(!check.require.cell(form.find('#inputCellO'))){
                return false;
            }
            if(!check.name(form.find('#inputNameO'))){
                return false;
            }
            if(!check.cell(form.find('#inputCellO'))){
                return false;
            }
            if(!check.organo(form.find('#inputOrgan_regO'))){
                return false;
            }
            if(!check.img(form.find('#inputBusiness_licensesO'))){
                return false;
            }
            if(!check.text(form.find('#inputRemarkO'))){
                return false;
            }
            return true;
        },
        appointmentCreatSubmit:function(form){
            if(!check.require.select(form.find('#inputInvesterSelect'))){
                return false;
            }
            if(!check.require.money(form.find('#inputMoney'))){
                return false;
            }
            if(!check.require.date(form.find('#inputDate'))){
                return false;
            }
            if(!check.require.address(form.find('#inputAddress'))){
                return false;
            }
            if(!check.money(form.find('#inputMoney'))){
                return false;
            }
            if(!check.date(form.find('#inputDate'))){
                return false;
            }
            if(!check.address(form.find('#inputAddress'))){
                return false;
            }
            if(!check.img(form.find('#inputOther'))){
                return false;
            }
            if(!check.text(form.find('#inputRemark'))){
                return false;
            }
            return true;
        },
        appointmentUpdateSubmit:function(form){
            if(!check.money(form.find('#inputMoney'))){
                return false;
            }
            if(!check.date(form.find('#inputDate'))){
                return false;
            }
            if(!check.img(form.find('#inputImgSend'))){
                return false;
            }
            if(!check.text(form.find('#inputRemark'))){
                return false;
            }
            if(form.find('#infoForm input[type="text"]').length>0){
                var list = form.find('#infoForm input[type="text"]');
                for(var i=0;i<list.length;i++){
                    if(!check.string($(list[i]))){
                        return false;
                    }
                }
            }
            if(form.find('#infoForm textarea').length>0){
                var list = form.find('#infoForm textarea');
                for(var i=0;i<list.length;i++){
                    if(!check.text($(list[i]))){
                        return false;
                    }
                }
            }
            if(form.find('#infoForm input[type=file]').length>0){
                var list = form.find('#infoForm input[type=file]');
                for(var i=0;i<list.length;i++){
                    if(!check.img($(list[i]))){
                        return false;
                    }
                }
            }
            return true;
        },
        investCheckSubmit:function(form){
            if(!check.require.checkid(form.find('#inputCheckId'))){
                return false;
            }
            if(!check.checkid(form.find('#inputCheckId'))){
                return false;
            }
            return true;
        },
        profileUpdateSubmit:function(form){
            if(!check.require.name(form.find('#inputName'))){
                return false;
            }
            if(!check.require.select(form.find('#type-select'))){
                return false;
            }
            if(!check.require.cell(form.find('#inputCell'))){
                return false;
            }
            if(!check.require.mail(form.find('#inputMail'))){
                return false;
            }
            if(!check.name(form.find('#inputName'))){
                return false;
            }
            if(!check.name(form.find('#inputNickName'))){
                return false;
            }
            if(!check.cell(form.find('#inputCell'))){
                return false;
            }
            if(!check.mail(form.find('#inputMail'))){
                return false;
            }
            if(!check.address(form.find('#inputAddress'))){
                return false;
            }
            if(!check.idno(form.find('#inputId_noP'))){
                return false;
            }
            if(!check.img(form.find('#inputId_frontP'))){
                return false;
            }
            if(!check.img(form.find('#inputId_backP'))){
                return false;
            }
            if(!check.text(form.find('#inputRemarkP'))){
                return false;
            }
            return true;
        },
    },
    bind:{
        sendRegeistCodeBind:function(){
            $('#sendRegeistBtn').bind('click',function(){
                submit.sendRegeistCode($(this));
            });
        },
        registerSubmitBind:function(){
            $('#submitBtn[name="register"]').bind('click',function(){
                submit.registerSubmit($(this));
            });
        },
        profileCreatSubmitBind:function(){
            $('#submitBtn[name="profileCreat"]').bind('click',function(){
                submit.profileCreatSubmit($(this));
            });
        },
        sendMailProductBind:function(){
            $('#sendMailProduct').bind('click',function(){
                submit.sendMailProduct($(this));
            });
        },
        loginSubmitBind:function(){
            $('#submitBtn[name="login"]').bind('click',function(){
                submit.loginSubmit($(this));
            });
        },
        customerCreatPersonalSubmitBind:function(){
            $('#submitBtnCreatCustomerP').bind('click',function(){
                submit.customerCreatPersonalSubmit($(this));
            });
        },
        customerUpdatePersonalSubmitBind:function(){
            $('#submitBtnUpdateCustomerP').bind('click',function(){
                submit.customerUpdatePersonalSubmit($(this));
            });
        },
        customerCreatOrganizalSubmitBind:function(){
            $('#submitBtnCreatCustomerO').bind('click',function(){
                submit.customerCreatOrganizalSubmit($(this));
            });
        },
        customerUpdateOrganizalSubmitBind:function(){
            $('#submitBtnUpdateCustomerO').bind('click',function(){
                submit.customerUpdateOrganizalSubmit($(this));
            });
        },
        appointmentCreatSubmitBind:function(){
            $('#submitBtn[name="appointmentCreat"]').bind('click',function(){
                submit.appointmentCreatSubmit($(this));
            });
        },
        appointmentUpdateSubmitBind:function(){
            $('#submitBtn[name="appointmentUpdate"]').bind('click',function(){
                submit.appointmentUpdateSubmit($(this));
            });
        },
        appointmentDeleteSubmitBind:function(){
            $('#deleteBtn[name="appointmentDelete"]').bind('click',function(){
                submit.appointmentDeleteSubmit($(this));
            });
        },
        investCheckSubmitBind:function(){
            $('#submitBtn[name="investcheck"]').bind('click',function(){
                submit.investCheckSubmit($(this));
            });
        },
        profileUpdateSubmitBind:function(){
            $('#submitBtn[name="update-profile"]').bind('click',function(){
                submit.profileUpdateSubmit($(this));
            });
        },
        moneyDeleteSubmitBind:function(){
            $('#moneydeleteBtn[name="moneyDelete"]').bind('click',function(){
                submit.moneyDeleteSubmit($(this));
            });
        }   
    },
    load:function(){
        this.bind.sendRegeistCodeBind();
        this.bind.registerSubmitBind();
        this.bind.profileCreatSubmitBind();
        this.bind.sendMailProductBind();
        //模拟登录获取openid
        this.bind.loginSubmitBind();
        this.bind.customerCreatPersonalSubmitBind();
        this.bind.customerUpdatePersonalSubmitBind();
        this.bind.customerCreatOrganizalSubmitBind();
        this.bind.customerUpdateOrganizalSubmitBind();
        this.bind.appointmentCreatSubmitBind();
        this.bind.appointmentUpdateSubmitBind();
        this.bind.appointmentDeleteSubmitBind();
        this.bind.investCheckSubmitBind();
        this.bind.profileUpdateSubmitBind();
        this.bind.moneyDeleteSubmitBind();
    },
}

window.getInfo = {
    getopenid:function(state){
        var result = false;
        $.ajax({
            url:'http://wx.hehuifunds.com/auth/wechat?state='+state,
            async: false,
            type:'GET',
            data:{},
            dataType:"json",
            success:function(data){
            },
            error:function(data){
            }
        });
    },
    checkstorage:function(){
        if($.session.get('HIMS_APP_STORE')!=undefined){
            return this.getSession('HIMS_APP_STORE');
        }else if($.cookie('HIMS_APP_STORE')!=undefined){
            return this.getCookie('HIMS_APP_STORE');
        }else if(window.localStorage.getItem("HIMS_APP_STORE")){
            var value = window.localStorage.getItem("HIMS_APP_STORE");
            var result = JSON.parse(unescape(value));
            return result;
        }else{
            return false;
        }
    },
    setCookie:function(name,value){
        $.cookie(name,escape(JSON.stringify(value)),{ expires: 30 });
    },
    setSession:function(name,value){
        $.session.set(name,escape(JSON.stringify(value)));
        //localStorage也存了
        window.localStorage.setItem(name,escape(JSON.stringify(value)));
    },
    deleteCookie:function(name){
        $.cookie(name,"",{ expires: -1 });
    },
    deleteSession:function(name){
        $.session.remove(name);
    },
    getCookie:function(name){
        return JSON.parse(unescape($.cookie(name)));
    },
    getSession:function(name){
        return JSON.parse(unescape($.session.get(name)));
    },
    turnregister:function(){
        window.location.href=getInfo.getSiteUrl.fullurl("register.html");
    },
    turnprofilecreat:function(){
        window.location.href=getInfo.getSiteUrl.fullurl("profile-creat.html");
    },
    turnprofilemine:function(){
        window.location.href=getInfo.getSiteUrl.fullurl("profile-mine.html");
    },
    turnmenu:function(para){
        window.location.href=getInfo.getSiteUrl.fullurl("menu.html" + (para?("#" + para):""));
        var href = window.location.href;
        var subhref = getInfo.getSiteUrl.host+href.substring(href.lastIndexOf('/')+1,href.length);
        subhref = subhref.split("#")[0];
        if(subhref==getInfo.getSiteUrl.fullurl("menu.html")){
            window.location.reload(true);
        }
    },
    turnproductliststep1:function(){
        window.location.href=getInfo.getSiteUrl.fullurl("product-list-step1.html");
    },
    turnproductliststep2:function(fid){
        window.location.href=getInfo.getSiteUrl.fullurl("product-list-step2.html#"+fid);
    },
    turnproductdetail:function(pid){
        window.location.href=getInfo.getSiteUrl.fullurl("product-detail.html#"+pid);
    },
    turnappointmentcreat:function(pid){
        window.location.href=getInfo.getSiteUrl.fullurl("appointment-creat.html#"+pid);
    },
    turnappointmentmine:function(){
        window.location.href=getInfo.getSiteUrl.fullurl("appointment-mine.html");
    },
    turncustomermine:function(){
        window.location.href=getInfo.getSiteUrl.fullurl("customer-mine.html");
    },
    turncustomercreat:function(){
        window.location.href=getInfo.getSiteUrl.fullurl("customer-creat.html");
    },
    turncustomerdetail:function(type,id,back){
        if(back){
            window.location.href=getInfo.getSiteUrl.fullurl("customer-detail.html#" + type + "," + id + ","+ back);
        }else{
            window.location.href=getInfo.getSiteUrl.fullurl("customer-detail.html#" + type + "," + id);
        }
    },
    turnappointmentdetailstep1:function(orderid){
        window.location.href=getInfo.getSiteUrl.fullurl("appointment-detail-step1.html#" + orderid);
    },
    turnappointmentdetailstep2:function(pid){
        window.location.href=getInfo.getSiteUrl.fullurl("appointment-detail-step2.html#" + pid);
    },
    turninvestmineprofessor:function(){
        window.location.href=getInfo.getSiteUrl.fullurl("invest-mine-professor.html");
    },
    turninvestmineinvestor:function(num){
        window.location.href=getInfo.getSiteUrl.fullurl("invest-mine-investor.html#"+num);
    },
    turninvestminecheck:function(){
        window.location.href=getInfo.getSiteUrl.fullurl("invest-mine-check.html");
    },
    turninvestdetail:function(pid){
        window.location.href=getInfo.getSiteUrl.fullurl("invest-detail.html#" + pid);
    },
    turncustomersearch:function(){
        window.location.href=getInfo.getSiteUrl.fullurl("customer-search.html");
    },
    getUrlPara:function(){
        var url =window.location.href;
        var paraStr = url.split('#')[1];
        var para = [paraStr];
        if(paraStr)para = paraStr.split(',');
        return para;
    },
    getFundList:function(){
        var result = false;
        $.ajax({
            url:getInfo.getUrl.fullurl('api/funds/'),
            async: false,
            type:'GET',
            data:{},
            dataType:"json",
            success:function(data){
                result = data;
            },
            error:function(data){
                result =  false;
            }
        });
        return result;
    },
    getProductList:function(){
        var result = false,
        fid = getInfo.getUrlPara()[0];
        if(!fid)return false;
        $.ajax({
            url:getInfo.getUrl.fullurl('api/funds/' + fid + '/products'),
            async: false,
            type:'GET',
            data:{},
            dataType:"json",
            success:function(data){
                result = data;
            },
            error:function(data){
                result =  false;
            }
        });
        return result;
    },
    getProductDetail:function(){
        var result = false,
        pid = getInfo.getUrlPara()[0];
        if(!pid)return false;
        $.ajax({
            url:getInfo.getUrl.fullurl('api/products/' + pid),
            async: false,
            type:'GET',
            data:{},
            dataType:"json",
            success:function(data){
                result = data;
            },
            error:function(data){
                result =  false;
            }
        });
        return result;
    },
    getCustomerDetail:function(){
        var para = getInfo.getUrlPara();
        if(!(para && para.length>1)) return false;
        if(para[0].toLowerCase()=="individual"){
            return this.getCustomerPersonalDetail(para[1]);
        }else if(para[0].toLowerCase()=="institution"){
            return this.getCustomerOrganizalDetail(para[1]);
        }else{
            return false;
        }
    },
    getCustomerPersonalDetail:function(iid){
        var result = false,
        store = getInfo.checkstorage();
        if(!iid)return false;
        $.ajax({
            url:getInfo.getUrl.fullurl('api/individuals/' + iid),
            async: false,
            type:'GET',
            data:{},
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                result = data;
            },
            error:function(data){
                result =  false;
            }
        });
        return result;
    },
    getCustomerOrganizalDetail:function(iid){
        var result = false,
        store = getInfo.checkstorage();
        if(!iid)return false;
        $.ajax({
            url:getInfo.getUrl.fullurl('api/institutions/' + iid),
            async: false,
            type:'GET',
            data:{},
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                result = data;
            },
            error:function(data){
                result =  false;
            }
        });
        return result;
    },
    getCustomerMine:function(){
        var store = getInfo.checkstorage();
        var personal = this.getCustomerPersonalMine(store.open_id);
        var organizal = this.getCustomerOrganizalMine(store.open_id);
        var result = {
            "personal":personal,
            "organizal":organizal
        }
        return result;
    },
    getCustomerPersonalMine:function(openid){
        var result = false;
        $.ajax({
            url:getInfo.getUrl.fullurl('api/individuals'),
            async: false,
            type:'GET',
            data:{},
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + openid + "\"");
            },
            success:function(data){
                result = data;
            },
            error:function(data){
                result =  false;
            }
        });
        return result;
    },
    getCustomerOrganizalMine:function(openid){
        var result = false;
        $.ajax({
            url:getInfo.getUrl.fullurl('api/institutions'),
            async: false,
            type:'GET',
            data:{},
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + openid + "\"");
            },
            success:function(data){
                result = data;
            },
            error:function(data){
                result =  false;
            }
        });
        return result;
    },
    getCustomerList:function(){
        var result = false,
        store = getInfo.checkstorage();
        $.ajax({
            url:getInfo.getUrl.fullurl('api/users/all_investors'),
            async: false,
            type:'GET',
            data:{},
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                result = data;
            },
            error:function(data){
                result =  false;
            }
        });
        return result;
    },
    getOrderInfo:function(){
        var result = false,
        oid = getInfo.getUrlPara()[0];
        if(!oid)return false;
        store = getInfo.checkstorage();
        var data = {};
        var lsid = window.localStorage.getItem("HIMS_APP_CHECKID");
        if(lsid){
            data = {"number":lsid}
        }
        $.ajax({
            url:getInfo.getUrl.fullurl('api/orders/'+oid),
            async: false,
            type:'GET',
            data:data,
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                result = data;
            },
            error:function(data){
                result =  false;
            }
        });
        return result;
    },
    getOrderMine:function(){
        var result = false,
        byState,
        byProduct,
        store = getInfo.checkstorage();
        $.ajax({
            url:getInfo.getUrl.fullurl('api/orders/by_state'),
            async: false,
            type:'GET',
            data:{},
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                byState = data;
            },
            error:function(data){
            }
        });
        $.ajax({
            url:getInfo.getUrl.fullurl('api/orders/by_product'),
            async: false,
            type:'GET',
            data:{},
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                byProduct = data;
            },
            error:function(data){
            }
        });
        if(byState||byProduct){
            result = {
                'byState':byState,
                'byProduct':byProduct
            }
        }
        return result;
    },
    getInvestMine:function(){
        var store = getInfo.checkstorage();
        $.ajax({
            url:getInfo.getUrl.fullurl('api/products/my'),
            async: false,
            type:'GET',
            data:{},
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                result = data;
            },
            error:function(data){
                result = false;
            }
        });
        return result;
    },
    getInvestDetail:function(){
        var store = getInfo.checkstorage(),
        pid = getInfo.getUrlPara()[0];
        if(!pid)return false;
        $.ajax({
            url:getInfo.getUrl.fullurl('api/products/' + pid + '/ordered'),
            async: false,
            type:'GET',
            data:{},
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                result = data;
            },
            error:function(data){
                result = false;
            }
        });
        return result;
    },
    getNewUserInfo:function(openid,uid){
        $.ajax({
            url:getInfo.getUrl.fullurl('api/users/'+uid),
            async: false,
            type:'GET',
            data:{},
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + openid + "\"");
            },
            success:function(data){
                getInfo.setSession('HIMS_APP_STORE',data.user);
            },
            error:function(data){
            }
        });
    },
    getUserInfo:function(){
        var store = getInfo.checkstorage(),
        uid= store.id;
        $.ajax({
            url:getInfo.getUrl.fullurl('api/users/'+uid),
            async: false,
            type:'GET',
            data:{},
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                result = data;
            },
            error:function(data){
                result = false;
            }
        });
        return result;
    },
    getInvesterInvest:function(){
        var store = getInfo.checkstorage(),
        number = getInfo.getUrlPara()[0];
        $.ajax({
            url:getInfo.getUrl.fullurl('api/orders/by_number'),
            async: false,
            type:'GET',
            data:{'number':number},
            dataType:"json",
            beforeSend:function(XMLHttpRequest){
                XMLHttpRequest.setRequestHeader("Authorization","Token token=\"" + store.open_id + "\"");
            },
            success:function(data){
                result = data;
            },
            error:function(data){
                result = false;
            }
        });
        return result;
    },
    getUrl:{
        host:"http://58.96.173.224/",
        fullurl:function(url){
            return getInfo.getUrl.host+url;
        }
    },
    getSiteUrl:{
        host:"./",
        fullurl:function(url){
            return getInfo.getSiteUrl.host+url;
        }
    },
    turnBind:{
        bindregister:function(){
            $("[data-turn=register]").on('click',function(){getInfo.turnregister()});
        },
        bindprofilecreat:function(){
            $("[data-turn=profilecreat]").on('click',function(){getInfo.turnprofilecreat()});
        },
        bindmenu:function(){
            $("[data-turn=menu]").on('click',function(){getInfo.turnmenu($(this).attr('data-para')||"")});
        },
        bindturnproductliststep1:function(){
            $("[data-turn=product-list-step1]").on('click',function(){getInfo.turnproductliststep1()});
        },
        bindturnproductliststep2:function(){
            $("[data-turn=product-list-step2]").on('click',function(){
                var fid = $(this).attr("data-fid");
                getInfo.turnproductliststep2(fid);
            });
        },
        bindturnproductdetail:function(){
            $("[data-turn=product-detail]").on('click',function(){
                var pid = $(this).attr("data-pid");
                getInfo.turnproductdetail(pid);
            });
        },
        bindturnappointmentcreat:function(){
            $("[data-turn=appointment-creat]").on('click',function(){
                var pid = $(this).attr("data-pid");
                getInfo.turnappointmentcreat(pid);
            });
        },
        bindturnappointmentmine:function(){
            $("[data-turn=appointment-mine]").on('click',function(){getInfo.turnappointmentmine()});
        },
        bindturncustomermine:function(){
            $("[data-turn=customer-mine]").on('click',function(){getInfo.turncustomermine()});
        },
        bindturncustomercreat:function(){
            $("[data-turn=customer-creat]").on('click',function(){getInfo.turncustomercreat()});
        },
        bindturncustomerdetail:function(){
            $("[data-turn=customer-detail]").on('click',function(){
                var type = $(this).attr('data-type'),
                    cid = $(this).attr('data-cid');
                    back = $(this).attr('data-back');
                if(back){
                    getInfo.turncustomerdetail(type,cid,back);
                }else{
                    getInfo.turncustomerdetail(type,cid);
                }
            });
        },
        bindturnappointmentdetailstep:function(){
            $("[data-turn=appointment-detail-step1]").on('click',function(){
                var oid = $(this).attr('data-oid');
                getInfo.turnappointmentdetailstep1(oid);
            });
        },
        bindturnappointmentdetailstep2:function(){
            $("[data-turn=appointment-detail-step2]").on('click',function(){
                var pid = $(this).attr('data-pid');
                getInfo.turnappointmentdetailstep2(pid);
            });
        },
        bindturninvestminecheck:function(){
            $("[data-turn=invest-mine-check]").on('click',function(){
                getInfo.turninvestminecheck();
            });
        },
        bindturninvestmineinvestor:function(){
            $("[data-turn=invest-mine-investor]").on('click',function(){
                getInfo.turninvestmineinvestor();
            });
        },
        bindturninvestmineprofessor:function(){
            $("[data-turn=invest-mine-professor]").on('click',function(){
                getInfo.turninvestmineprofessor();
            });
        },
        bindturninvestdetail:function(){
            $("[data-turn=invest-detail]").on('click',function(){
                var pid = $(this).attr('data-pid');
                getInfo.turninvestdetail(pid);
            });
        },
        bindturnprofilemine:function(){
            $("[data-turn=profile-mine]").on('click',function(){
                getInfo.turnprofilemine();
            });
        },
        bindturncustomersearch:function(){
            $("[data-turn=customer-search]").on('click',function(){
                getInfo.turncustomersearch();
            });
        }
    },
    load:function(){
        this.turnBind.bindregister();
        this.turnBind.bindprofilecreat();
        this.turnBind.bindmenu();
        this.turnBind.bindturnproductliststep1();
        this.turnBind.bindturnproductliststep2();
        this.turnBind.bindturnproductdetail();
        this.turnBind.bindturnappointmentcreat();
        this.turnBind.bindturnappointmentmine();
        this.turnBind.bindturnappointmentmine();
        this.turnBind.bindturncustomermine();
        this.turnBind.bindturncustomercreat();
        this.turnBind.bindturncustomerdetail();
        this.turnBind.bindturninvestminecheck();
        this.turnBind.bindturninvestmineinvestor();
        this.turnBind.bindturninvestmineprofessor();
        this.turnBind.bindturninvestdetail();
        this.turnBind.bindturnprofilemine();
        this.turnBind.bindturncustomersearch();
        this.turnBind.bindturnappointmentdetailstep();
        this.turnBind.bindturnappointmentdetailstep2();
    }
}

window.pop={
    appear:{},
    disappear:{},
    hide:{},
    bind:function(){
        $("#pop").bind("click",function(){
            clearTimeout(pop.disappear);
            clearTimeout(pop.hide);
            $("#pop").unbind('click');
            pop.disappear = setTimeout(function(){
                $("#pop").find(".pop-alert").removeClass('appear');
            },100);
            pop.hide = setTimeout(function(){
                $("#pop").addClass('hide');
                pop.bind();
            },500);
        });
    },
    load:function(){
        this.bind();
    }
}

window.tabs={
    control:{
        selectTab:function(btn){
            /*--tab切换--*/
            var i = btn.index();
            btn.closest(".select-tab").find('li').removeClass('current');
            btn.addClass("current");
            $(".block-tab").addClass('hide');
            $($(".block-tab")[i]).removeClass('hide');
        },
        inputSelect:function(input){
            /*--select下拉菜单出现--*/
            input.closest('.form-line').addClass('current').siblings().removeClass('current');
            $('.form-line:not(.current) .select-ul').removeClass('current');
            input.closest('.selectinput:not(.finished)').find('.select-ul').toggleClass("current");
        },
        selectulli:function(li){
            /*--select下拉菜单li点击--*/
            li.closest('.form-line').addClass('current').siblings().removeClass('current');
            li.closest('.select-ul').find('li').removeClass('current');
            li.addClass('current');
            li.closest('.selectinput').find('.input-select').attr('data-val',li.attr("data-val")).val(li.text());
            li.closest('.select-ul').removeClass('current');
            li.closest('.selectinput').click();
        },
        typeselect:function(li){
            /*--个人机构选择框--*/
            var i = parseInt(li.attr('data-val'),10);
            $('#type-select').parent().addClass("finished");
            $(".hideblock").addClass('hide');
            $($(".hideblock")[i]).removeClass('hide');
        },
        foldtoggle:function(dt){
            var dl = $(dt).closest('dl');
            if(dl.height()==32){
                dl.find('.icon-arrow').removeClass('right').addClass('down');
                var hei = dl.find('.appoitment').length*156+32;
                dl.height(hei);
            }else{
                dl.find('.icon-arrow').removeClass('down').addClass('right');
                dl.height(32);
            }
        },
        foldslide:function(div){
            var ul = $(div).next();
            if(ul.height() == 86){
                div.find('.icon-arrow').removeClass('down').addClass('right');
                var hei= ul.find('li').length*43;
                ul.height(hei);
            }else{
                div.find('.icon-arrow').removeClass('right').addClass('down');
                ul.height(86);
            }
        }
    },
    bind:{
        selectTab:function(){
            $("#select-tab li").bind('click',function(){
                tabs.control.selectTab($(this));
            });
        },
        inputSelect:function(){
            $(".selectinput .input-select").bind('click',function(){
                tabs.control.inputSelect($(this));
            });
        },
        selectulli:function(){
            $(".select-ul li").bind('click',function(){
                tabs.control.selectulli($(this));
            });
        },
        typeselect:function(){
            $("#type-select+.select-ul li").bind('click',function(){
                tabs.control.typeselect($(this));
            });
        },
        foldtoggle:function(){
            $(".fold-dl dt").bind('click',function(){
                tabs.control.foldtoggle($(this));
            });
        },
        foldslide:function(){
            $(".fold-list").bind('click',function(){
                tabs.control.foldslide($(this));
            });
        }
    },
    load:function(){
        this.bind.selectTab();
        this.bind.inputSelect();
        this.bind.selectulli();
        this.bind.typeselect();
        this.bind.foldtoggle();
        this.bind.foldslide();
    }
}
/*--initial--*/
$(function(){
    check.load();
    submit.load();
    getInfo.load();
    pop.load();
    tabs.load();
});

String.prototype.toHtmlEncode = function()
{
    var str = this;
        str=str.replace(/&/g,"&amp;");
        str=str.replace(/</g,"&lt;");
        str=str.replace(/>/g,"&gt;");
        str=str.replace(/\'/g,"&apos;");
        str=str.replace(/\"/g,"&quot;");
        str=str.replace(/\n/g,"<br>");
        str=str.replace(/\ /g,"&nbsp;");
        str=str.replace(/\t/g,"&nbsp;&nbsp;&nbsp;&nbsp;");
    return str;
}