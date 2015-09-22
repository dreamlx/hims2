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