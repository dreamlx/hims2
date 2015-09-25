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
curl  -X PATCH -d "user[email]=foobar@example.com&name=xxxxxx" http://localhost:3000/api/users/{#user.id}
```
```
url:    http://localhost:3000/api/users/{user.id}
params:
        {
          user:
          {
            name: "xxxxxx",
            email: "foobar@example.com",
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
            "progress_bar"=>1
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
            "id"=>26, 
            "name"=>"MyString", 
            "desc"=>"MyString", 
            "title1"=>"MyString", 
            "content1"=>"MyString", 
            "title2"=>"MyString", 
            "content2"=>"MyString", 
            "title3"=>"MyString", 
            "content3"=>"MyString", 
            "progress_bar"=>1
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
curl -X GET -d "email=foobar@example.com" http://localhost:3000/api/product/#{product.id}/send_mail
```
```
url:    http://localhost:3000/api/product/#{product.id}/send_mail
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
            "remark"=>"MyString"
          }
        }
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
            "remark"=>"MyString"
          }
        }
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
            "name"=>"MyString"
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
            "name"=>"MyString"
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
          investable_id: "individual:#{individual.id}",
          product_id: product.id,
          amount: "9.99",
          due_date "2015-09-25",
          mail_address "MyString",
          other: 'data:image/png;base64, xxxxxx',
          remark: "MyString",
        }
response:
        {
          "id"=>21, 
          "investable_id"=>213, 
          "investable_type"=>"Individual", 
          "product_id"=>245, 
          "user_id"=>496, 
          "amount"=>"9.99", 
          "due_date"=>"2015-09-25", 
          "mail_address"=>"MyString", 
          "other"=>{
            "other"=>{
              "url"=>"/uploads/order/other/21/20150925175940.png", 
              "thumb"=>{
                "url"=>"/uploads/order/other/21/thumb_20150925175940.png"
              }
            }
          }, 
          "remark"=>"MyString", 
          "state"=>nil
        }
```
