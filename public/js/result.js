var $ysc = jQuery.noConflict();
new Vue({
    el: '#result',
    data: {
        scroe:"" ,
        typeUser: "",
        typeProduct:""
    },
    ready: function() {
    	var self=this;
        $ysc.ajax({
            url: "result.json",
            type: "get",
            dataType: "json",
            success: function(data) {
                self.scroe = data[0].scroe;
                self.typeUser=data[0].typeUser;
                self.typeProduct=data[0].typeProduct;
            },
            error: function(msg) {
                alert("网络错误");
            }
        });
    }
})
