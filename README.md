# hims2
hims rebuild version 2
```
cp config/database.yml.default config/database.yml
cp config/secrets.yml.default config/secrets.yml
```
### send_code
```
curl -X GET -d "cell=11111111111" http://localhost:3000/api/users/send_code
```
```
url:    http://localhost:3000/api/users/send_code
params: {cell: "11111111111"}
response:
        200 or 422
```
### sign_up
```
curl  -X POST -d "user[cell]=11111111&code=111111&open_id=sdfhksdfhu" http://localhost:3000/api/users
```
```
url:    http://localhost:3000/api/users
params:
        {
          user:
          {
            cell: "11111111111",
            code: "666666",
            open_id: "xfsgdgf"
          }
        }
response:
        {
          user:
          {
            id: 1,
            cell: "11111111111",
            open_id: "xfsgdgf",
            name: nil,
            email: nil
          }
        }
```
### user update
```
curl  -X PATCH --header "Authorization: Token token=#{open_id}" -d "user[email]=foobar@example.com&name=xxxxxx" http://localhost:3000/api/users/{#user.id}
```
```
url:    http://localhost:3000/api/users/{user.id}
params:
        {
          user:
          {
            name: "xxxxxx",
            email: "foobar@example.com",
            id_type: "个人",            #只有【个人】或者【机构】
            nickname: "nick name",
            gender: "男",               #只有【男】或者【女】
            address: "address",
            card_type: "身份证",         #选项有["身份证","营业执照","护照","香港永久性居住身份证","台胞证","港澳同胞回乡证","驾照"]
            card_no: "xxxxxxx",
            card_front: "data:image/png;base64,xxxxxxx",
            card_back: "data:image/png;base64,xxxxxxx",
            remark: "remark"
          }
        }
response:
        {
          user:
          {
            id: 1,
            cell: "11111111111",
            open_id: "xfsgdgf",
            name: nil,
            email: nil,
            "id_type"=>"个人", 
            "nickname"=>"new_nickname", 
            "gender"=>"男", 
            "address"=>"new_address", 
            "card_type"=>"身份证", 
            "card_no"=>"new_card_no", 
            "card_front"=>{
              "card_front"=>{
                "url"=>"/uploads/user/card_front/1174/20150927155530.png",
                "thumb"=>{
                  "url"=>"/uploads/user/card_front/1174/thumb_20150927155530.png"
                }
              }
            }, 
            "card_back"=>{
              "card_back"=>{
                "url"=>"/uploads/user/card_back/1174/20150927155530.png", 
                "thumb"=>{
                  "url"=>"/uploads/user/card_back/1174/thumb_20150927155530.png"
                }
              }
            }, 
            "remark"=>"new_remark"
          }
        }
```
### 获取user信息
```
curl  -X GET --header "Authorization: Token token=#{open_id}" http://localhost:3000/api/users/{#user.id}
```
```
url:    http://localhost:3000/api/users/{user.id}
params: no
response: same as above
```
### fund list
```
curl  -X GET http://localhost:3000/api/funds
```
```
url:    http://localhost:3000/api/funds
params: no
response:
        [
          {
            "id"=>26, 
            "name"=>"MyString", 
            "desc"=>"MyString", 
            "title1"=>"MyString", 
            "content1"=>"MyString", 
            "title2"=>"MyString", 
            "content2"=>"MyString", 
            "title3"=>"MyString", 
            "content3"=>"MyString", 
            "progress_bar"=>1,
            "label"=>"每周起息",
            "currency"=>"美元产品"
          },
          ......
        ]
```
### product list
```
curl  -X GET http://localhost:3000/api/funds/{fund.id}/products
```
```
url:    http://localhost:3000/api/funds/{fund.id}/products
params: no
response:
        [
          {
            "fund_name"=>"MyString",
            "id"=>26, 
            "name"=>"MyString", 
            "desc"=>"MyString", 
            "title1"=>"MyString", 
            "content1"=>"MyString", 
            "title2"=>"MyString", 
            "content2"=>"MyString", 
            "title3"=>"MyString", 
            "content3"=>"MyString", 
            "progress_bar"=>1,
            "label"=>"每周起息"
          },
          ......
        ]
```
### product show
```
curl  -X GET http://localhost:3000/api/products/{product.id}
```
```
url:    http://localhost:3000/api/products/{product.id}
params: no
response:
        {
          "id"=>3, 
          "name"=>"MyString",             #产品名称
          "desc"=>"MyString",             #说明
          "abbr"=>"MyString",             #产品简称
          "currency"=>"MyString",         #产品币种
          "amount"=>"MyString",           #目标规模
          "period"=>"MyString",           #存续期
          "paid"=>"MyString",             #收益支付
          "sales_period"=>"MyString",     #销售期
          "block_period"=>"MyString",     #封闭期
          "redeem"=>"MyString",           #申购/赎回
          "entity"=>"MyString",           #基金实体
          "adviser"=>"MyString",          #投资顾问
          "trustee"=>"MyString",          #托管人
          "reg_organ"=>"MyString",        #登记机构
          "website"=>"www.example.com",   #净值网站
          "agency"=>"MyString",           #代销机构
          "regulatory_filing"=>"MyString",#监管备案
          "legal_consultant"=>"MyString", #法律顾问
          "audit"=>"MyString",            #审计师
          "starting_point"=>"MyString",   #认购起点
          "account"=>"MyString",          #募集账户
          "progress"=>"MyString",         #募集进度
          "direction"=>"MyString",        #投资方向
          "risk_control"=>"MyString",     #风控措施 
          "instruction"=>"MyString",      #说明文档 
          "agreement"=>"MyString"         #认购协议
          "rois"=>[
            {
              "id"=>7, 
              "range"=>"MyString",        #认购金额 
              "profit"=>"MyString"        #预期收益
            },
            ....
          ]
        }
```
### 发送产品说明
```
curl -X GET -d "email=foobar@example.com" http://localhost:3000/api/products/#{product.id}/send_mail
```
```
url:    http://localhost:3000/api/products/#{product.id}/send_mail
action: get
params: {email: "foobar@example.com"}
response: {
            message: "success" or "failed"
          }
          200 or 422
```
### 创建个人投资者
```
curl -X POST -d "individual[name]=mysting" --header "Authorization: Token token=#{open_id}" http://localhost:3000/api/individuals
```
```
url:    http://localhost:3000/api/individuals
action: post
params: { 
          "individual": {
            "name": "MyString",
            "cell": "MyString",
            "remark_name", "MyString",
            "id_type": "身份证",
            "id_no": "MyString",
            "id_front": "data:image/png;base64,xxxxxxx",
            "id_back": "data:image/png;base64,xxxxxxx",
            "remark": "MyString"
          }
        }
response: 
        { 
          "individual"=>
          {
            "id"=>23, 
            "name"=>"MyString", 
            "cell"=>"MyString", 
            "remark_name"=>"MyString", 
            "id_type"=>"身份证", 
            "id_no"=>"MyString", 
            "id_front"=>{
              "id_front"=>{
                "url"=>"/uploads/individual/id_front/23/20150924202928.png", 
                "thumb"=>{
                  "url"=>"/uploads/individual/id_front/23/thumb_20150924202928.png"
                }
              }
            }, 
            "id_back"=>{
              "id_back"=>{
                "url"=>"/uploads/individual/id_back/23/20150924202928.png", 
                "thumb"=>{
                  "url"=>"/uploads/individual/id_back/23/thumb_20150924202928.png"
                }
              }
            }, 
            "remark"=>"MyString",
            "created_at"=>"2015-09-25",
            "booking_count"=>0,
            "holding_count"=>0
          }
        }
```
### 获取个人投资者资料
```
curl -X GET --header "Authorization: Token token=#{open_id}" http://localhost:3000/api/individuals/{individual.id}
```
```
url:    http://localhost:3000/api/individuals/{individual.id}
action: get
params: no
response: same as above
```
### 更新个人投资者
```
curl -X PATCH -d "individual[new_name]=mysting" --header "Authorization: Token token=#{open_id}" http://localhost:3000/api/individuals/{individual.id}
```
```
url:    http://localhost:3000/api/individuals/{individual.id}
action: patch
params: { 
          "individual": {
            "name": "MyString",
            "cell": "MyString",
            "remark_name", "MyString",
            "id_type": "身份证",
            "id_no": "MyString",
            "id_front": "data:image/png;base64,xxxxxxx",
            "id_back": "data:image/png;base64,xxxxxxx",
            "remark": "MyString"
          }
        }
response: same as above
```
### 创建机构投资者
```
curl -X POST -d "institution[name]=mysting" --header "Authorization: Token token=#{open_id}" http://localhost:3000/api/institutions
```
```
url:    http://localhost:3000/api/institutions
action: post
params: { 
          "institution": {
            "name": "MyString",
            "cell": "MyString",
            "remark_name", "MyString",
            "organ_reg": "MyString",
            "business_licenses": "data:image/png;base64,xxxxxxx",
            "remark": "MyString"
          }
        }
response: 
        { 
          "institution"=>
          {
            "id"=>56, 
            "name"=>"MyString", 
            "cell"=>"MyString", 
            "remark_name"=>"MyString", 
            "organ_reg"=>"MyString", 
            "business_licenses"=>{
              "business_licenses"=>{
                "url"=>"/uploads/institution/business_licenses/56/20150924212802.png", 
                "thumb"=>{
                  "url"=>"/uploads/institution/business_licenses/56/thumb_20150924212802.png"
                }
              }
            }, 
            "remark"=>"MyString",
            "created_at"=>"2015-09-25",
            "booking_count"=>0,
            "holding_count"=>0
          }
        }
```
### 获取机构投资者资料
```
curl -X GET --header "Authorization: Token token=#{open_id}" http://localhost:3000/api/institutions/{individual.id}
```
```
url:    http://localhost:3000/api/institutions/{institution.id}
action: get
params: no
response: same as above
```
### 更新机构投资者
```
curl -X PATCH -d "institution[name]=mysting" --header "Authorization: Token token=#{open_id}" http://localhost:3000/api/institutions/{institution.id}
```
```
url:    http://localhost:3000/api/institutions/{institution.id}
action: patch
params: { 
          "institution": {
            "name": "MyString",
            "cell": "MyString",
            "remark_name", "MyString",
            "organ_reg": "MyString",
            "business_licenses": "data:image/png;base64,xxxxxxx",
            "remark": "MyString"
          }
        }
response: same as above
```
### 个人投资者列表
```
curl -X GET --header "Authorization: Token token=#{open_id}" http://localhost:3000/api/individuals
```
```
url:    http://localhost:3000/api/individuals
action: get
params: no
        }
response: 
        [
          {
            "id"=>23, 
            "name"=>"MyString",
            "booking_count"=>0,
            "holding_count"=>0
          }
        ]
```
### 机构投资者列表
```
curl -X GET --header "Authorization: Token token=#{open_id}" http://localhost:3000/api/institutions
```
```
url:    http://localhost:3000/api/institutions
action: get
params: no
        }
response: 
        [
          {
            "id"=>23, 
            "name"=>"MyString",
            "booking_count"=>0,
            "holding_count"=>0
          }
        ]
```
### 获取投资者的名字（包括个人投资者和机构投资者），用于下预约单
```
curl -X GET --header "Authorization: Token token=#{open_id}" http://localhost:3000/api/users/all_investors
```
```
url:    http://localhost:3000/api/users/all_investors
params: no
response:
        [
          {"individual:273"=>"[个人]MyString"}, 
          {"institution:241"=>"[机构]MyString"},
          {"type:id"=>"名字"}
        ]
```
### 创建预约单
```
curl -X POST --header "Authorization: Token token=#{open_id}" -d "product_id=1...." http://localhost:3000/api/orders
```
```
url:    http://localhost:3000/api/orders
params: {
          order:{
            investable_id: "individual:#{individual.id}",
            product_id: product.id,
            amount: "9.99",
            due_date "2015-09-25",
            mail_address "MyString",
            other: 'data:image/png;base64, xxxxxx',
            remark: "MyString"
          }
        }
response: same as below
```
### 获取预约单
```
curl -X GET --header "Authorization: Token token=#{open_id}" http://localhost:3000/api/orders/{order.id}
```
```
url:    http://localhost:3000/api/orders/{order.id}
params: no
action: get
response:
        {
          "order"=>
          {
            "id"=>179, 
            "investable_id"=>1166, 
            "investable_type"=>"Individual", 
            "product_id"=>830, 
            "user_id"=>2349, 
            "amount"=>"9.99", 
            "due_date"=>"2015-09-25", 
            "mail_address"=>"MyString", 
            "other"=>{
              "other"=>{
                "url"=>"/uploads/order/other/179/rails.png", 
                "thumb"=>{
                  "url"=>"/uploads/order/other/179/thumb_rails.png"
                }
              }
            }, 
            "remark"=>"MyString", 
            "state"=>"已经预约，等待完成报单",
            "booking_date"=> "2015-09-25",    #预约日期
            "investor_name"=> "MyString",     #投资者名称
            "product_name"=> "product name",  #预约产品
            "currency"=>"人民币",              #币种
            "number"=>"xxxxxxxxxxxxxx",       #证件号码
            "deliver"=>"未快递"                #合同快递至管理人,只有【未快递】和【已快递】两个选项
          }, 
          "money_receipts"=>
          [
            {
              "id"=>83, 
              "amount"=>"9.99", 
              "bank_charge"=>"9.99", 
              "date"=>"2015-09-27", 
              "attach"=>{
                "attach"=>{
                  "url"=>"/uploads/money_receipt/attach/83/rails.png"
                }
              }, 
              "state"=>"未确认"
            },
            ......
          ],
          "infos"=>
          [
            {
              "id"=>56, 
              "category"=>"MyString", 
              "field_name"=>"MyString", 
              "field_type"=>"string",   # 只有三个类型：string, text, photo，与类型对应的字段才是有效字段
              "string"=>"MyString", 
              "text"=>"MyText", 
              "photo"=>{
                "photo"=>{
                  "url"=>"/uploads/info/photo/56/rails.png"
                }
              }, 
              "state"=>"未确认"
            },
            ......
          ]
        }
```
### 更新订单（只有【合同快递】和【备注】可更新）
```
curl -X PATCH --header "Authorization: Token token=#{open_id}" -d "order[deliver]=已快递&order[remark]=new_remark" http://localhost:3000/api/orders/{order.id}
```
```
url:    http://localhost:3000/api/orders/{order.id}
action: patch
params: {order:
          {
            deliver: "已快递",
            remark: "new_remark"
          }
        }
response: same as above
```
### 删除订单
```
curl -X DELETE http://localhost:3000/api/orders/{order.id}
```
```
url:    http://localhost:3000/api/orders/{order.id}
action: delete
params: no
response:
        200 if ok
        422 if failed
```
### 提交报单信息
```
curl -X PATCH --header "Authorization: Token token=#{open_id}" -d "infos[1][string]=new_string&xxx" http://localhost:3000/api/orders/{order.id}/update_infos
```
```
url:    http://localhost:3000/api/orders/{order.id}/update_infos
params: {
          infos:
          {
            1: {string: "new_string"},
            2: {text: "new_text"},
            3: {photo: 'data:image/png;base64,'},
            id: {field_type: "new_info"}
          }
        }
action: patch
response: same as above
```
### 提交汇款信息
```
curl -X POST --header "Authorization: Token token=#{open_id}" -d "money_receipt[order_id]=1&xxxxxxxx" http://localhost:3000/api/orders/{order.id}/money_receipts
```
```
url:    http://localhost:3000/api/orders/{order.id}/money_receipts
action: post
params: {
          money_receipt:
          {
            order_id: 1,
            attach: 'data:image/png;base64,xxxxx',
            amount: "9.99",
            date: "2015-09-27",
          }
        }
response:
        {
          "money_receipt"=>
          {
            "id"=>38, 
            "order_id"=>136, 
            "amount"=>"9.99", 
            "bank_charge"=>"0.0", 
            "date"=>"2015-09-27", 
            "attach"=>{
              "attach"=>{
                "url"=>"/uploads/money_receipt/attach/38/20151003141836.png"
              }
            }, 
            "state"=>"未确认"
          }
        }
```
### 我的预约(by_state)
```
curl -X GET --header "Authorization: Token token=#{open_id}" http://localhost:3000/api/orders/by_state
```
```
url:    http://localhost:3000/api/orders/by_state
params: no
action: get
response:
        {
          "booked"=>                            #已经预约，等待完成报单
          [
            {
              "id"=>360, 
              "amount"=>"9.99", 
              "investor_name"=>"MyString", 
              "product_name"=>"MyString",
              "product_abbr"=>"MyString",
              "product_desc"=>"MyString",
              "currency"=>"美元产品"
            },
            ...
          ], 
          "completed"=>                         #已经完成报单，等待起息
          [
            {
              "id"=>361, 
              "amount"=>"9.99", 
              "investor_name"=>"MyString", 
              "product_name"=>"MyString",
              "product_abbr"=>"MyString",
              "product_desc"=>"MyString",
              "currency"=>"美元产品"
            },
            ...
          ], 
          "valued"=>                            #已起息，但合同文本基金管理人未收讫
          [
            {
              "id"=>362, 
              "amount"=>"9.99", 
              "investor_name"=>"MyString", 
              "product_name"=>"MyString",
              "product_abbr"=>"MyString",
              "product_desc"=>"MyString",
              "currency"=>"美元产品"
            },
            ...
          ]
        }
```
### 我的预约(by_product)
```
curl -X GET --header "Authorization: Token token=#{open_id}" http://localhost:3000/api/orders/by_product
```
```
url:    http://localhost:3000/api/orders/by_product
params: no
action: get
response: same as below
```
### 我的投资
```
curl -X GET --header "Authorization: Token token=#{open_id}" http://localhost:3000/api/products/my
```
```
url:    http://localhost:3000/api/products/my
params: no
action: get
response:
        [
          {
            "id"=>1374, 
            "name"=>"MyString", 
            "desc"=>"MyString", 
            "title1"=>"MyString", 
            "content1"=>"MyString", 
            "title2"=>"MyString", 
            "content2"=>"MyString", 
            "title3"=>"MyString", 
            "content3"=>"MyString", 
            "progress_bar"=>1, 
            "orders"=>
            [
              {
                "id"=>336, 
                "investor_name"=>"MyString", 
                "currency"=>"MyString", 
                "amount"=>"9.99"
                "state"=>"已经预约，等待完成报单"
              },
              ......
            ]
          },
          ......
        ]
```
### 已预约产品
```
curl -X GET --header "Authorization: Token token=#{open_id}" http://localhost:3000/api/products/{product.id}/ordered
```
```
url:    http://localhost:3000/api/products/{product.id}/ordered
action: get
params: no
response:
        { "product"=>
          {
            "id"=>505, 
            "name"=>"MyString", 
            "title4"=>"MyString", 
            "content4"=>"MyString", 
            "title5"=>"MyString", 
            "content5"=>"MyString", 
            "title6"=>"MyString", 
            "content6"=>"MyString", 
            "title7"=>"MyString", 
            "content7"=>"MyString",
            "notices"=>
            [
              {
                "id"=>51, 
                "title"=>"MyString", 
                "attach"=>{
                  "attach"=>{
                    "url"=>"/uploads/attach/attach/51/rails.png"
                  }
                }, 
                "date"=>"2015-10-03"
              }
            ], 
            "reports"=>
            [
              {
                "id"=>52, 
                "title"=>"MyString", 
                "attach"=>{
                  "attach"=>{
                    "url"=>"/uploads/attach/attach/52/rails.png"
                  }
                }, 
                "date"=>"2015-10-03"
              }
            ]
          }
        }
```
### 投资者请进【我的投资（投资者）】
```
curl -X GET --header "Authorization: Token token=#{open_id}" http://localhost:3000/api/orders/by_number
```
```
url:    http://localhost:3000/api/orders/by_number
action: get
params: {number: xxxxxx}
response:
        [
          {
            "product_name"=>"MyString", 
            "product_desc"=>"MyString", 
            "id"=>240, 
            "title1"=>"MyString", 
            "content1"=>"MyString", 
            "title2"=>"MyString", 
            "content2"=>"MyString", 
            "title3"=>"MyString", 
            "content3"=>"MyString", 
            "amount"=>"9.99"
          },
          ......
        ]
```
self-defined memu
```
{
  "button":
  [
    {  
      "type":"view",
      "name":"我要投资",
      "url":"http://wx.hehuifunds.com/auth/wechat?state=1"
    },
    {
      "type":"view",
      "name":"我的投资",
      "url":"http://wx.hehuifunds.com/auth/wechat?state=2"
    },
    {
      "type":"view",
      "name":"关于禾晖",
      "url":"http://wx.hehuifunds.com/about.html"
    }
  ]
}
```