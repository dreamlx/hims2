# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'ffaker'

#User
User.find_or_create_by(cell: '18616770245', name: 'Derek Cai' , gender: '男', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '13761971379', name: '包容' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '18888650887', name: '曹斌斌' , gender: '男', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '15088661372', name: '车丽娜' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '', name: '陈琦' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '', name: '陈学燕' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '', name: '冯鑫' , gender: '男', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '15900753355', name: '傅瓅' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '', name: '嘎日玛盖' , gender: '男', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '13901974541', name: '高宏' , gender: '男', card_type: '身份证',state:'确认', card_no: '310106196708303212').save!(validate: false)
User.find_or_create_by(cell: '18917963605', name: '高萍萍' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '', name: '官文晖' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '', name: '郭婷' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '15001706348', name: '赫艳琦' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '15618813725', name: '侯婷婷' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '13818008411', name: '胡伟忠' , gender: '男', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '13585592183', name: '胡骁春' , gender: '男', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '15801823350', name: '黄勇梅' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '18918556327', name: '姜培青' , gender: '男', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '18918591055', name: '解杰竣' , gender: '男', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '', name: '金传玺' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '13816584015', name: '蓝瑶' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '13916585469', name: '李栋' , gender: '男', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '13911880963', name: '李龙' , gender: '男', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '13605807676', name: '林祺' , gender: '女', card_type: '身份证',state:'确认', card_no: '330103198906221625').save!(validate: false)
User.find_or_create_by(cell: '13661672973', name: '龙丽华' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '', name: '蒲丽琼' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '', name: '戎燕萍' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '15921804707', name: '史靖' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '', name: '孙萍' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '13671587447', name: '唐赟' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '13764991140', name: '汪丽芸' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '15801664931', name: '王彦洁' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '', name: '邬金晶' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '13862563327', name: '谢静娴' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '13764929570', name: '徐蕾' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '13817513785', name: '徐元犇' , gender: '男', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '', name: '张善' , gender: '男', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '13816009975', name: '张正达' , gender: '男', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '', name: '周建敏' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)
User.find_or_create_by(cell: '13601781931', name: '周莉' , gender: '女', card_type: '',state:'确认', card_no: '').save!(validate: false)

#Individual
Individual.find_or_create_by(name: 'AN TONGYU',cell:'' ,id_type: '身份证' ,id_no: '340406196211093223', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'CHEN CHENG',cell:'' ,id_type: '身份证' ,id_no: '310107196410291251', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'CHEN ZHE',cell:'' ,id_type: '身份证' ,id_no: '310104197310110834', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'CHONG TSZ NAM',cell:'' ,id_type: '护照' ,id_no: 'KJ0053514', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'CHOU SHIH-LUN',cell:'' ,id_type: '台胞证' ,id_no: '00503645', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'DONG LIHUA',cell:'' ,id_type: '身份证' ,id_no: '310109195204052020', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'HUA WEIFENG',cell:'' ,id_type: '身份证' ,id_no: '330106196807230016', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'HUAN FU',cell:'' ,id_type: '护照' ,id_no: 'E3068858', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'HUANG WENHUI',cell:'' ,id_type: '身份证' ,id_no: '310110197011273817', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'HUANG YANMING',cell:'' ,id_type: '护照' ,id_no: 'E4037652', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'LEE CHANG NING',cell:'' ,id_type: '台胞证' ,id_no: '00462263', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'LEE SHU MEI',cell:'' ,id_type: '港澳同胞回乡证' ,id_no: 'H01445678', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'LEI TAN',cell:'' ,id_type: '护照' ,id_no: 'G36677104', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'LI PUI FAN',cell:'' ,id_type: '香港永久性居住身份证' ,id_no: 'L001535(3)', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'LI YANG',cell:'' ,id_type: '身份证' ,id_no: '110108198311088512', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'LIN QI',cell:'' ,id_type: '身份证' ,id_no: '330103198906221625', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'LIU YINGXIANG',cell:'' ,id_type: '身份证' ,id_no: '120106196809160534', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'MA WEIFENG',cell:'' ,id_type: '身份证' ,id_no: '420106197601030824', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'MU JIANG',cell:'' ,id_type: '身份证' ,id_no: '110101197202261516', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'MU WANG',cell:'' ,id_type: '外国人永久居留证' ,id_no: 'ARG310055111303', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'NAGANO EIKO',cell:'' ,id_type: '护照' ,id_no: 'TK2634741', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'PAN I TE',cell:'' ,id_type: '台胞证' ,id_no: '05176948', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'PING ZHOU',cell:'' ,id_type: '身份证' ,id_no: '330103197808060720', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'RAN LING',cell:'' ,id_type: '身份证' ,id_no: '659001197301155469', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'SHEN HAIYING',cell:'' ,id_type: '身份证' ,id_no: '310227197203100825', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'TANG JUN',cell:'' ,id_type: '身份证' ,id_no: '310101197001072038', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'TILUN WANG',cell:'' ,id_type: '身份证' ,id_no: '310106199609122823', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'TU NANFENG',cell:'' ,id_type: '身份证' ,id_no: '330106196801140036', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'WANG HAIJUN',cell:'' ,id_type: '身份证' ,id_no: '31010319580728333X', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'WANG HUI',cell:'' ,id_type: '身份证' ,id_no: '33260319730927001X', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'WANG JING',cell:'' ,id_type: '身份证' ,id_no: '310102197312214423', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'WANG YING',cell:'' ,id_type: '身份证' ,id_no: '330103196804121624', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'WU QIONG',cell:'' ,id_type: '身份证' ,id_no: '320102197208201616', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'XI CHAO',cell:'' ,id_type: '身份证' ,id_no: '32050319580822153X', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'XIA QIFENG',cell:'' ,id_type: '护照' ,id_no: 'G59703563', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'XING JIANLIANG',cell:'' ,id_type: '身份证' ,id_no: '31011019650206461X', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'XINPING CAO',cell:'' ,id_type: '护照' ,id_no: 'G36677117', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'XU DUOWEN',cell:'' ,id_type: '身份证' ,id_no: '310110196505193214', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'XU LIANG',cell:'' ,id_type: '身份证' ,id_no: '310104198209246811', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'XU XIAOMIN',cell:'' ,id_type: '身份证' ,id_no: '310112197212240547', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'YANG HUI',cell:'' ,id_type: '身份证' ,id_no: '310101197012293231', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'YAO JINGJIE',cell:'' ,id_type: '身份证' ,id_no: '310103197506170445', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'YE HANGJUN',cell:'' ,id_type: '身份证' ,id_no: '412723197605090014', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'YIN TONG',cell:'' ,id_type: '护照' ,id_no: 'BA800664', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'YU PEILIANG',cell:'' ,id_type: '身份证' ,id_no: '310110195203266217', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'YUAN XIAO LONG',cell:'' ,id_type: '身份证' ,id_no: '330681197811012099', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'ZHANG SHU',cell:'' ,id_type: '身份证' ,id_no: '11010519721227771X', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'ZHAO SARAH QING QING',cell:'13801861058' ,id_type: '护照' ,id_no: 'M6141985', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'ZHAO XINWEN',cell:'' ,id_type: '身份证' ,id_no: '310109197602101229', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'ZHONG YUEJING',cell:'' ,id_type: '身份证' ,id_no: '310110197810221247', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'ZHOU FENG',cell:'' ,id_type: '身份证' ,id_no: '310222196702240033', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'ZHOU HENG',cell:'' ,id_type: '身份证' ,id_no: '620102196512095324', state:'确认').save!(validate: false)
Individual.find_or_create_by(name: 'ZHU XIAOBIN',cell:'' ,id_type: '身份证' ,id_no: '320111197409123219', state:'确认').save!(validate: false)

#Order
Order.all.each do |o|
  if o.investable_type == 'User'
    o.destroy
  end
end

Order.find_or_create_by(investable_id: Individual.find_by_id_no('KJ0053514').id,user_id:User.find_by_name('高宏').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:1000000.00 ,due_date: ' 2015/11/5',state:'已起息',booking_date: '2015/11/5', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('M6141985').id,user_id:User.find_by_name('高宏').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:700000.00 ,due_date: ' 2015/11/9',state:'已起息',booking_date: '2015/11/9', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('412723197605090014').id,user_id:User.find_by_name('蒲丽琼').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:159993.50 ,due_date: ' 2015/11/11',state:'已起息',booking_date: '2015/11/11', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310109197602101229').id,user_id:User.find_by_name('唐赟').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:199993.50 ,due_date: ' 2015/11/11',state:'已起息',booking_date: '2015/11/11', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('32050319580822153X').id,user_id:User.find_by_name('谢静娴').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:999993.50 ,due_date: ' 2015/11/11',state:'已起息',booking_date: '2015/11/11', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('E3068858').id,user_id:User.find_by_name('高宏').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:1000000.00 ,due_date: ' 2015/11/12',state:'已起息',booking_date: '2015/11/12', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310227197203100825').id,user_id:User.find_by_name('龙丽华').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:119993.50 ,due_date: ' 2015/11/12',state:'已起息',booking_date: '2015/11/12', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310106199609122823').id,user_id:User.find_by_name('高宏').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:10000.00 ,due_date: ' 2015/11/12',state:'已起息',booking_date: '2015/11/12', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('L001535(3)').id,user_id:User.find_by_name('张正达').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:510000.00 ,due_date: ' 2015/11/12',state:'已起息',booking_date: '2015/11/12', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310106199609122823').id,user_id:User.find_by_name('高宏').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:90000.00 ,due_date: ' 2015/11/13',state:'已起息',booking_date: '2015/11/12', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310102197312214423').id,user_id:User.find_by_name('胡伟忠').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:99993.50 ,due_date: ' 2015/11/13',state:'已起息',booking_date: '2015/11/13', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310104197310110834').id,user_id:User.find_by_name('唐赟').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:124993.50 ,due_date: ' 2015/11/13',state:'已起息',booking_date: '2015/11/13', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310110196505193214').id,user_id:User.find_by_name('徐蕾').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:99993.50 ,due_date: ' 2015/11/16',state:'已起息',booking_date: '2015/11/16', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310110196505193214').id,user_id:User.find_by_name('徐蕾').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:59993.50 ,due_date: ' 2015/11/16',state:'已起息',booking_date: '2015/11/16', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310102197312214423').id,user_id:User.find_by_name('胡伟忠').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:99993.50 ,due_date: ' 2015/11/16',state:'已起息',booking_date: '2015/11/13', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310222196702240033').id,user_id:User.find_by_name('黄勇梅').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:100000.00 ,due_date: ' 2015/11/16',state:'已起息',booking_date: '2015/11/16', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310104197310110834').id,user_id:User.find_by_name('唐赟').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:124993.50 ,due_date: ' 2015/11/16',state:'已起息',booking_date: '2015/11/13', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310227197203100825').id,user_id:User.find_by_name('龙丽华').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:39993.50 ,due_date: ' 2015/11/16',state:'已起息',booking_date: '2015/11/12', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('330103197808060720').id,user_id:User.find_by_name('邬金晶').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:49977.50 ,due_date: ' 2015/11/13',state:'已起息',booking_date: '2015/11/13', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('330106196801140036').id,user_id:User.find_by_name('曹斌斌').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:99993.50 ,due_date: ' 2015/11/16',state:'已起息',booking_date: '2015/11/16', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('330103198906221625').id,user_id:User.find_by_name('林祺').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:1000023.50 ,due_date: ' 2015/11/16',state:'已起息',booking_date: '2015/11/16', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310110197810221247').id,user_id:User.find_by_name('唐赟').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:209993.50 ,due_date: ' 2015/11/16',state:'已起息',booking_date: '2015/11/16', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310104197310110834').id,user_id:User.find_by_name('唐赟').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:124993.50 ,due_date: ' 2015/11/17',state:'已起息',booking_date: '2015/11/13', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310222196702240033').id,user_id:User.find_by_name('黄勇梅').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:100000.00 ,due_date: ' 2015/11/17',state:'已起息',booking_date: '2015/11/16', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('330106196801140036').id,user_id:User.find_by_name('曹斌斌').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:59993.50 ,due_date: ' 2015/11/17',state:'已起息',booking_date: '2015/11/16', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('31010319580728333X').id,user_id:User.find_by_name('戎燕萍').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:159993.50 ,due_date: ' 2015/11/17',state:'已起息',booking_date: '2015/11/17', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('320111197409123219').id,user_id:User.find_by_name('谢静娴').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:299993.50 ,due_date: ' 2015/11/18',state:'已起息',booking_date: '2015/11/18', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('G59703563').id,user_id:User.find_by_name('嘎日玛盖').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:99993.50 ,due_date: ' 2015/11/18',state:'已起息',booking_date: '2015/11/18', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310222196702240033').id,user_id:User.find_by_name('黄勇梅').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:100000.00 ,due_date: ' 2015/11/18',state:'已起息',booking_date: '2015/11/16', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310107196410291251').id,user_id:User.find_by_name('赫艳琦').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:99993.50 ,due_date: ' 2015/11/18',state:'已起息',booking_date: '2015/11/18', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310110197011273817').id,user_id:User.find_by_name('黄勇梅').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:124993.50 ,due_date: ' 2015/11/18',state:'已起息',booking_date: '2015/11/18', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310101197012293231').id,user_id:User.find_by_name('徐元犇').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:179993.50 ,due_date: ' 2015/11/18',state:'已起息',booking_date: '2015/11/18', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310109195204052020').id,user_id:User.find_by_name('胡骁春').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:159993.50 ,due_date: ' 2015/11/18',state:'已起息',booking_date: '2015/11/18', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('ARG310055111303').id,user_id:User.find_by_name('汪丽芸').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:99976.50 ,due_date: ' 2015/11/18',state:'已起息',booking_date: '2015/11/18', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('TK2634741').id,user_id:User.find_by_name('姜培青').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:49976.50 ,due_date: ' 2015/11/19',state:'已起息',booking_date: '2015/11/19', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310107196410291251').id,user_id:User.find_by_name('赫艳琦').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:99993.50 ,due_date: ' 2015/11/19',state:'已起息',booking_date: '2015/11/18', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('G59703563').id,user_id:User.find_by_name('嘎日玛盖').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:99993.50 ,due_date: ' 2015/11/19',state:'已起息',booking_date: '2015/11/18', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('05176948').id,user_id:User.find_by_name('侯婷婷').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:99993.50 ,due_date: ' 2015/11/19',state:'已起息',booking_date: '2015/11/19', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310110197011273817').id,user_id:User.find_by_name('黄勇梅').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:125006.50 ,due_date: ' 2015/11/19',state:'已起息',booking_date: '2015/11/18', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('330103197808060720').id,user_id:User.find_by_name('邬金晶').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:49977.50 ,due_date: ' 2015/11/18',state:'已起息',booking_date: '2015/11/13', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('330103197808060720').id,user_id:User.find_by_name('邬金晶').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:49977.50 ,due_date: ' 2015/11/18',state:'已起息',booking_date: '2015/11/13', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('330103197808060720').id,user_id:User.find_by_name('邬金晶').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:9977.50 ,due_date: ' 2015/11/18',state:'已起息',booking_date: '2015/11/13', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('320102197208201616').id,user_id:User.find_by_name('胡骁春').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:159993.50 ,due_date: ' 2015/11/19',state:'已起息',booking_date: '2015/11/19', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310104197310110834').id,user_id:User.find_by_name('唐赟').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:124993.50 ,due_date: ' 2015/11/19',state:'已起息',booking_date: '2015/11/13', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310110195203266217').id,user_id:User.find_by_name('史靖').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:1149993.50 ,due_date: ' 2015/11/19',state:'已起息',booking_date: '2015/11/19', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('659001197301155469').id,user_id:User.find_by_name('冯鑫').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:119993.50 ,due_date: ' 2015/11/19',state:'已起息',booking_date: '2015/11/19', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('BA800664').id,user_id:User.find_by_name('李栋').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:230000.00 ,due_date: ' 2015/11/19',state:'已起息',booking_date: '2015/11/19', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('110108198311088512').id,user_id:User.find_by_name('李龙').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:199993.50 ,due_date: ' 2015/11/19',state:'已起息',booking_date: '2015/11/19', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('G36677104').id,user_id:User.find_by_name('官文晖').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:299970.50 ,due_date: ' 2015/11/20',state:'已起息',booking_date: '2015/11/20', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310110197011273817').id,user_id:User.find_by_name('黄勇梅').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:125000.00 ,due_date: ' 2015/11/20',state:'已起息',booking_date: '2015/11/18', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('659001197301155469').id,user_id:User.find_by_name('冯鑫').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:119993.50 ,due_date: ' 2015/11/20',state:'已起息',booking_date: '2015/11/19', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('05176948').id,user_id:User.find_by_name('侯婷婷').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:59993.50 ,due_date: ' 2015/11/20',state:'已起息',booking_date: '2015/11/19', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('00462263').id,user_id:User.find_by_name('郭婷').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:159993.50 ,due_date: ' 2015/11/20',state:'已起息',booking_date: '2015/11/20', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('G36677117').id,user_id:User.find_by_name('官文晖').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:189970.50 ,due_date: ' 2015/11/19',state:'已起息',booking_date: '2015/11/19', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310101197001072038').id,user_id:User.find_by_name('高萍萍').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:199993.50 ,due_date: ' 2015/11/23',state:'已起息',booking_date: '2015/11/23', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310110197011273817').id,user_id:User.find_by_name('黄勇梅').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:125000.00 ,due_date: ' 2015/11/23',state:'已起息',booking_date: '2015/11/18', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('659001197301155469').id,user_id:User.find_by_name('冯鑫').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:119993.50 ,due_date: ' 2015/11/23',state:'已起息',booking_date: '2015/11/19', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('H01445678').id,user_id:User.find_by_name('蓝瑶').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:600000.00 ,due_date: ' 2015/11/23',state:'已起息',booking_date: '2015/11/23', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('11010519721227771X').id,user_id:User.find_by_name('陈学燕').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:99993.50 ,due_date: ' 2015/11/18',state:'已起息',booking_date: '2015/11/18', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('11010519721227771X').id,user_id:User.find_by_name('陈学燕').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:99993.50 ,due_date: ' 2015/11/19',state:'已起息',booking_date: '2015/11/18', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('330103196804121624').id,user_id:User.find_by_name('Derek Cai').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:49993.50 ,due_date: ' 2015/11/23',state:'已起息',booking_date: '2015/11/23', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('00503645').id,user_id:User.find_by_name('傅瓅').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:299961.50 ,due_date: ' 2015/11/23',state:'已起息',booking_date: '2015/11/23', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('659001197301155469').id,user_id:User.find_by_name('冯鑫').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:119993.50 ,due_date: ' 2015/11/23',state:'已起息',booking_date: '2015/11/19', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('330681197811012099').id,user_id:User.find_by_name('Derek Cai').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:159993.50 ,due_date: ' 2015/11/23',state:'已起息',booking_date: '2015/11/23', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('TK2634741').id,user_id:User.find_by_name('姜培青').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:49976.50 ,due_date: ' 2015/11/23',state:'已起息',booking_date: '2015/11/19', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('330106196807230016').id,user_id:User.find_by_name('林祺').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:100000.00 ,due_date: ' 2015/11/24',state:'已起息',booking_date: '2015/11/24', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('120106196809160534').id,user_id:User.find_by_name('金传玺').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:99993.50 ,due_date: ' 2015/11/24',state:'已起息',booking_date: '2015/11/24', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('330103196804121624').id,user_id:User.find_by_name('Derek Cai').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:119993.50 ,due_date: ' 2015/11/24',state:'已起息',booking_date: '2015/11/23', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('659001197301155469').id,user_id:User.find_by_name('冯鑫').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:119993.50 ,due_date: ' 2015/11/24',state:'已起息',booking_date: '2015/11/19', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('120106196809160534').id,user_id:User.find_by_name('金传玺').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:59993.50 ,due_date: ' 2015/11/25',state:'已起息',booking_date: '2015/11/24', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310112197212240547').id,user_id:User.find_by_name('张善').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:159993.50 ,due_date: ' 2015/11/25',state:'已起息',booking_date: '2015/11/25', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('420106197601030824').id,user_id:User.find_by_name('周莉').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:1000000.00 ,due_date: ' 2015/11/25',state:'已起息',booking_date: '2015/11/25', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('E4037652').id,user_id:User.find_by_name('陈琦').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:99993.50 ,due_date: ' 2015/11/26',state:'已起息',booking_date: '2015/11/26', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310103197506170445').id,user_id:User.find_by_name('孙萍').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:119993.50 ,due_date: ' 2015/11/26',state:'已起息',booking_date: '2015/11/26', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('33260319730927001X').id,user_id:User.find_by_name('车丽娜').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:119993.50 ,due_date: ' 2015/11/26',state:'已起息',booking_date: '2015/11/26', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('33260319730927001X').id,user_id:User.find_by_name('车丽娜').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:119993.50 ,due_date: ' 2015/11/27',state:'已起息',booking_date: '2015/11/26', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310103197506170445').id,user_id:User.find_by_name('孙萍').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:39993.50 ,due_date: ' 2015/11/27',state:'已起息',booking_date: '2015/11/26', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('33260319730927001X').id,user_id:User.find_by_name('车丽娜').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:119993.50 ,due_date: ' 2015/11/30',state:'已起息',booking_date: '2015/11/26', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('33260319730927001X').id,user_id:User.find_by_name('车丽娜').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:119993.50 ,due_date: ' 2015/11/30',state:'已起息',booking_date: '2015/11/26', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('110101197202261516').id,user_id:User.find_by_name('周建敏').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:159993.50 ,due_date: ' 2015/11/30',state:'已起息',booking_date: '2015/11/30', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('31011019650206461X').id,user_id:User.find_by_name('孙萍').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:179993.50 ,due_date: ' 2015/11/30',state:'已起息',booking_date: '2015/11/30', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('340406196211093223').id,user_id:User.find_by_name('冯鑫').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:299993.50 ,due_date: ' 2015/11/30',state:'已起息',booking_date: '2015/11/30', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('310104198209246811').id,user_id:User.find_by_name('解杰竣').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:200000.00 ,due_date: ' 2015/11/30',state:'已起息',booking_date: '2015/11/30', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('33260319730927001X').id,user_id:User.find_by_name('车丽娜').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:119993.50 ,due_date: ' 2015/12/1',state:'已起息',booking_date: '2015/11/26', investable_type:'Individual').save!(validate: false)
Order.find_or_create_by(investable_id: Individual.find_by_id_no('620102196512095324').id,user_id:User.find_by_name('王彦洁').id,product_id: Product.find_by_name('禾晖*稳健量化1号基金第一期').id,amount:149993.50 ,due_date: ' 2015/12/1',state:'已起息',booking_date: '2015/12/1', investable_type:'Individual').save!(validate: false)

#rels
Individual.find_by(name:'AN TONGYU').update_attribute(:user_id, User.find_by(name: '冯鑫').id) if User.find_by(name: '冯鑫')
Individual.find_by(name:'CHEN CHENG').update_attribute(:user_id, User.find_by(name: '赫艳琦').id) if User.find_by(name: '赫艳琦')
Individual.find_by(name:'CHEN ZHE').update_attribute(:user_id, User.find_by(name: '唐赟').id) if User.find_by(name: '唐赟')
Individual.find_by(name:'CHONG TSZ NAM').update_attribute(:user_id, User.find_by(name: '高宏').id) if User.find_by(name: '高宏')
Individual.find_by(name:'CHOU SHIH-LUN').update_attribute(:user_id, User.find_by(name: '傅瓅').id) if User.find_by(name: '傅瓅')
Individual.find_by(name:'DONG LIHUA').update_attribute(:user_id, User.find_by(name: '胡骁春').id) if User.find_by(name: '胡骁春')
Individual.find_by(name:'HUA WEIFENG').update_attribute(:user_id, User.find_by(name: '林祺').id) if User.find_by(name: '林祺')
Individual.find_by(name:'HUAN FU').update_attribute(:user_id, User.find_by(name: '高宏').id) if User.find_by(name: '高宏')
Individual.find_by(name:'HUANG WENHUI').update_attribute(:user_id, User.find_by(name: '黄勇梅').id) if User.find_by(name: '黄勇梅')
Individual.find_by(name:'HUANG YANMING').update_attribute(:user_id, User.find_by(name: '陈琦').id) if User.find_by(name: '陈琦')
Individual.find_by(name:'LEE CHANG NING').update_attribute(:user_id, User.find_by(name: '郭婷').id) if User.find_by(name: '郭婷')
Individual.find_by(name:'LEE SHU MEI').update_attribute(:user_id, User.find_by(name: '蓝瑶').id) if User.find_by(name: '蓝瑶')
Individual.find_by(name:'LEI TAN').update_attribute(:user_id, User.find_by(name: '官文晖').id) if User.find_by(name: '官文晖')
Individual.find_by(name:'LI PUI FAN').update_attribute(:user_id, User.find_by(name: '张正达').id) if User.find_by(name: '张正达')
Individual.find_by(name:'LI YANG').update_attribute(:user_id, User.find_by(name: '李龙').id) if User.find_by(name: '李龙')
Individual.find_by(name:'LIN QI').update_attribute(:user_id, User.find_by(name: '林棋').id) if User.find_by(name: '林棋')
Individual.find_by(name:'LIU YINGXIANG').update_attribute(:user_id, User.find_by(name: '金传玺').id) if User.find_by(name: '金传玺')
Individual.find_by(name:'MA WEIFENG').update_attribute(:user_id, User.find_by(name: '周莉').id) if User.find_by(name: '周莉')
Individual.find_by(name:'MU JIANG').update_attribute(:user_id, User.find_by(name: '周建敏').id) if User.find_by(name: '周建敏')
Individual.find_by(name:'MU WANG').update_attribute(:user_id, User.find_by(name: '汪丽芸').id) if User.find_by(name: '汪丽芸')
Individual.find_by(name:'NAGANO EIKO').update_attribute(:user_id, User.find_by(name: '姜培青').id) if User.find_by(name: '姜培青')
Individual.find_by(name:'PAN I TE').update_attribute(:user_id, User.find_by(name: '侯婷婷').id) if User.find_by(name: '侯婷婷')
Individual.find_by(name:'PING ZHOU').update_attribute(:user_id, User.find_by(name: '邬金晶').id) if User.find_by(name: '邬金晶')
Individual.find_by(name:'RAN LING').update_attribute(:user_id, User.find_by(name: '冯鑫').id) if User.find_by(name: '冯鑫')
Individual.find_by(name:'SHEN HAIYING').update_attribute(:user_id, User.find_by(name: '龙丽华').id) if User.find_by(name: '龙丽华')
Individual.find_by(name:'TANG JUN').update_attribute(:user_id, User.find_by(name: '高萍萍').id) if User.find_by(name: '高萍萍')
Individual.find_by(name:'TILUN WANG').update_attribute(:user_id, User.find_by(name: '高宏').id) if User.find_by(name: '高宏')
Individual.find_by(name:'TU NANFENG').update_attribute(:user_id, User.find_by(name: '曹斌斌').id) if User.find_by(name: '曹斌斌')
Individual.find_by(name:'WANG HAIJUN').update_attribute(:user_id, User.find_by(name: '戎燕萍').id) if User.find_by(name: '戎燕萍')
Individual.find_by(name:'WANG HUI').update_attribute(:user_id, User.find_by(name: '车丽娜').id) if User.find_by(name: '车丽娜')
Individual.find_by(name:'WANG JING').update_attribute(:user_id, User.find_by(name: '胡伟忠').id) if User.find_by(name: '胡伟忠')
Individual.find_by(name:'WANG YING').update_attribute(:user_id, User.find_by(name: 'Derek Cai').id) if User.find_by(name: 'Derek Cai')
Individual.find_by(name:'WU QIONG').update_attribute(:user_id, User.find_by(name: '胡骁春').id) if User.find_by(name: '胡骁春')
Individual.find_by(name:'XI CHAO').update_attribute(:user_id, User.find_by(name: '谢静娴').id) if User.find_by(name: '谢静娴')
Individual.find_by(name:'XIA QIFENG').update_attribute(:user_id, User.find_by(name: '嘎日玛盖').id) if User.find_by(name: '嘎日玛盖')
Individual.find_by(name:'XING JIANLIANG').update_attribute(:user_id, User.find_by(name: '孙萍').id) if User.find_by(name: '孙萍')
Individual.find_by(name:'XINPING CAO').update_attribute(:user_id, User.find_by(name: '官文晖').id) if User.find_by(name: '官文晖')
Individual.find_by(name:'XU DUOWEN').update_attribute(:user_id, User.find_by(name: '徐蕾').id) if User.find_by(name: '徐蕾')
Individual.find_by(name:'XU LIANG').update_attribute(:user_id, User.find_by(name: '解杰竣').id) if User.find_by(name: '解杰竣')
Individual.find_by(name:'XU XIAOMIN').update_attribute(:user_id, User.find_by(name: '张善').id) if User.find_by(name: '张善')
Individual.find_by(name:'YANG HUI').update_attribute(:user_id, User.find_by(name: '徐元犇').id) if User.find_by(name: '徐元犇')
Individual.find_by(name:'YAO JINGJIE').update_attribute(:user_id, User.find_by(name: '孙萍').id) if User.find_by(name: '孙萍')
Individual.find_by(name:'YE HANGJUN').update_attribute(:user_id, User.find_by(name: '蒲丽琼').id) if User.find_by(name: '蒲丽琼')
Individual.find_by(name:'YIN TONG').update_attribute(:user_id, User.find_by(name: '李栋').id) if User.find_by(name: '李栋')
Individual.find_by(name:'YU PEILIANG').update_attribute(:user_id, User.find_by(name: '史靖').id) if User.find_by(name: '史靖')
Individual.find_by(name:'YUAN XIAOLONG').update_attribute(:user_id, User.find_by(name: 'Derek Cai').id) if User.find_by(name: 'Derek Cai')
Individual.find_by(name:'ZHANG SHU').update_attribute(:user_id, User.find_by(name: '陈学燕').id) if User.find_by(name: '陈学燕')
Individual.find_by(name:'ZHAO SARAH QING QING').update_attribute(:user_id, User.find_by(name: '高宏').id) if User.find_by(name: '高宏')
Individual.find_by(name:'ZHAO XINWEN').update_attribute(:user_id, User.find_by(name: '唐赟').id) if User.find_by(name: '唐赟')
Individual.find_by(name:'ZHONG YUEJING').update_attribute(:user_id, User.find_by(name: '唐赟').id) if User.find_by(name: '唐赟')
Individual.find_by(name:'ZHOU FENG').update_attribute(:user_id, User.find_by(name: '黄勇梅').id) if User.find_by(name: '黄勇梅')
Individual.find_by(name:'ZHOU HENG').update_attribute(:user_id, User.find_by(name: '王彦洁').id) if User.find_by(name: '王彦洁')
Individual.find_by(name:'ZHU XIAOBIN').update_attribute(:user_id, User.find_by(name: '谢静娴').id) if User.find_by(name: '谢静娴')


# 100.times {
#   User.create(
#     open_id: FFaker::Guid.guid,
#     cell: FFaker::PhoneNumberCU.e164_mobile_phone_number,
#     name: FFaker::NameCN.name,
#     email: FFaker::Internet.email,
#     id_type: User::ID_TYPES.sample,
#     nickname: FFaker::Name.first_name,
#     gender: User::GENDER_TYPES.sample,
#     address: FFaker::Address.street_address,
#     card_type: Individual::ID_TYPES.sample,
#     card_no: FFaker::Guid.guid,
#     card_front: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))),
#     card_back: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))),
#     remark: FFaker::LoremCN.sentence,
#     number: FFaker::Guid.guid,
#     state: User::STATES.sample
#   )
# }
# 100.times {
#   Fund.create(
#     name: FFaker::LoremCN.words,
#     desc: FFaker::LoremCN.sentence,
#     title1: FFaker::LoremCN.word,
#     content1: FFaker::LoremCN.sentence,
#     title2: FFaker::LoremCN.word,
#     content2: FFaker::LoremCN.sentence,
#     title3: FFaker::LoremCN.word,
#     content3: FFaker::LoremCN.sentence,
#     progress_bar: rand(100),
#     label: FFaker::LoremCN.word,
#     currency: ["人民币", "美元"].sample
#     )
# }
#
# 100.times {
#   Individual.create(
#     user_id: User.all.sample.id,
#     name: FFaker::NameCN.name,
#     cell: FFaker::PhoneNumberCU.e164_mobile_phone_number,
#     remark_name: FFaker::LoremCN.word,
#     id_type: Individual::ID_TYPES.sample,
#     id_no: FFaker::Guid.guid,
#     id_front: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))),
#     id_back: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))),
#     remark: FFaker::LoremCN.sentence,
#     state: ["提交", "确认", "否决"].sample
#     )
# }
