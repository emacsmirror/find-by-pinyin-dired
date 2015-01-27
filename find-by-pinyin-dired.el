;;; find-by-pinyin-dired.el --- Find file by first PinYin character of Chinese Hanzi

;; Copyright (C) 2015 Chen Bin

;; Author: Chen Bin <chenbin.sh@gmail.com>
;; URL: http://github.com/redguardtoo/find-by-pinyin-dired
;; Keywords: Hanzi Chinese dired find character
;; Version: 0.0.1

;; This file is not part of GNU Emacs.

;; This file is free software (GPLv3 License)

;;; Commentary:
;; Setup:
;;
;; Place this file somewhere (say ~/.emacs/lisp), add below code into your .emacs:
;; (add-to-list 'load-path "~/.emacs.d/lisp/")
;; (require 'find-by-pinyin-dired)
;;
;; Then `M-x find-by-pinyin-dired`.
;;

;;; Code:
(require 'find-lisp)

(defconst fbpd-char-table
  '("[阿啊呵腌嗄锕吖爱哀挨碍埃癌艾唉矮哎皑蔼隘暧霭捱嗳瑷嫒锿嗌砹安案按暗岸俺谙黯鞍氨庵桉鹌胺铵揞犴埯昂肮盎奥澳傲熬敖凹袄懊坳嗷拗鏖骜鳌翱岙廒遨獒聱媪螯鏊]"
    "[把八吧巴爸罢拔叭芭霸靶扒疤跋坝笆耙粑灞茇菝魃岜捌钯鲅百白败摆伯拜柏呗掰捭佰稗办半版般班板伴搬扮斑颁瓣拌扳绊阪坂瘢钣舨癍帮邦棒膀榜傍绑磅谤浜梆镑蚌蒡报保包暴宝抱薄胞爆鲍饱堡曝刨褒豹雹苞葆褓孢煲鸨龅趵被北备背悲辈杯倍贝碑卑蓓惫悖狈呗焙鹎孛邶陂埤碚褙鐾鞴萆钡本奔笨苯夯畚贲锛坌崩甭绷蹦迸甏泵嘣蚌比必笔毕币避闭鼻彼逼壁臂弊碧鄙毙蔽庇匕璧敝陛弼篦婢愎痹妣濞铋裨俾髀萆薜哔狴庳秕滗舭毖吡嬖蓖贲畀荸埤筚箅芘襞跸荜编便边变遍辩辨贬鞭辫扁卞砭苄匾汴蝙笾碥窆褊弁鳊忭煸缏表标彪镖膘骠镳裱杓飙瘭髟飚婊飑鳔别憋瘪蹩鳖宾滨彬斌鬓缤殡濒槟摈膑傧玢豳髌镔并病兵冰饼丙柄秉炳禀邴摒波播博伯勃薄拨泊柏剥玻驳卜脖搏膊饽簸掰舶跛礴菠帛铂钵渤檗钹擘箔趵孛鹁踣亳啵不部布步补捕怖卜簿哺埔卟埠钸逋醭晡瓿钚]"
    "[擦嚓礤才采菜财材彩裁猜蔡踩睬参餐残惨灿惭掺蚕璨孱骖黪粲藏苍仓沧舱伧草操曹糙嘈槽螬艚漕策测侧厕册恻参岑涔曾层蹭噌查察差茶插刹叉诧茬碴喳岔嚓衩杈楂槎檫镲搽锸猹馇汊姹差柴拆豺钗侪虿瘥产颤缠禅蝉馋铲搀阐掺潺忏蟾婵谄谗廛孱澶冁躔蒇骣觇镡羼长场常唱厂尝昌肠偿畅倡倘敞怅娼猖嫦伥氅徜昶鲳阊菖苌鬯惝超朝潮炒吵抄嘲钞绰巢晁焯怊耖车彻撤扯澈掣坼砗称陈沉晨尘臣趁衬辰郴谶琛忱嗔伧抻谌宸榇龀碜成城程称承诚盛乘呈撑惩澄秤瞠橙噌逞铛丞骋埕枨塍铖裎酲柽蛏吃持迟尺赤斥池痴齿驰耻翅匙侈哧嗤啻弛蚩炽笞敕叱饬踟鸱褫豉坻墀茌篪傺媸螭彳眵魑瘛重冲充崇虫宠憧忡艟茺舂铳抽愁仇丑筹臭酬绸踌瞅惆畴稠雠俦帱瘳出处除初楚触储础厨畜躇橱雏矗怵锄杵搐绌黜褚蜍蹰刍滁楮憷亍樗揣啜踹嘬膪搋传穿川船串喘舛遄舡巛氚椽钏创窗床闯幢疮怆吹垂炊锤捶陲槌棰春纯唇蠢醇淳椿鹑蝽莼绰戳啜辍踔龊此次词差刺辞慈磁赐瓷兹茨雌祠疵呲鹚糍茈从匆聪丛葱囱琮淙枞苁骢璁凑楱辏腠促粗簇醋卒猝蹴蹙徂殂蔟酢攒窜篡蹿撺镩汆爨脆粹催摧崔萃翠瘁悴璀隹淬毳榱啐存村寸忖皴错措搓挫撮磋蹉矬嵯脞痤瘥鹾厝锉]"
    "[大打达答搭瘩嗒沓耷褡鞑笪靼怛妲哒疸代带待戴袋呆贷逮歹殆黛怠玳岱迨傣呔骀绐埭甙但单担弹淡旦蛋胆诞丹耽惮眈啖澹掸殚箪瘅赕疸聃氮萏郸儋当党荡档挡裆铛宕凼菪谠砀到道导倒岛刀悼盗蹈捣祷叨稻忉帱氘纛的得德锝等登灯邓凳瞪蹬噔磴戥镫簦嶝地第提底低帝弟敌抵递滴迪蒂堤笛缔涤嘀诋谛狄邸睇嫡翟砥娣棣荻羝坻柢觌骶氐绨镝碲籴嗲点电店典颠甸淀垫殿滇奠惦掂碘癫巅踮佃玷簟阽坫靛钿癜丶调掉吊雕刁钓凋叼貂碉铫铞鲷爹跌叠迭碟谍蝶喋佚踮牒耋蹀堞瓞揲垤鲽定订顶丁盯钉鼎叮町铤腚酊仃锭疔啶玎碇耵丢铥动东懂冬洞冻董栋咚恫侗氡硐鸫岽垌峒胨胴都斗豆抖逗兜陡窦蔸蚪篼痘都读度独毒督渡肚杜睹堵赌妒嘟渎笃牍镀犊黩髑椟芏蠹断段短端锻缎煅椴簖对队堆兑碓憝怼镦顿盾吨敦蹲钝炖遁盹沌囤墩趸镦礅砘多夺朵躲舵堕踱咄跺哆剁惰垛驮掇铎裰哚缍沲柁]"
    "[额俄恶饿哦鹅扼愕遏噩娥峨呃厄鄂讹婀蛾轭颚鳄锷谔屙锇阏垩腭苊鹗萼莪诶恩摁蒽而二儿尔耳迩饵洱鸸珥铒鲕贰佴]"
    "[发法罚乏伐阀砝筏垡珐反饭犯翻范凡烦返番贩繁泛帆藩幡梵樊燔蕃畈钒蘩矾蹯方放房访防仿芳妨纺彷坊肪舫钫鲂邡枋非费飞废肥啡沸菲肺匪诽腓扉吠霏绯妃斐翡蜚痱淝悱鲱篚芾狒镄榧分份纷奋愤粉氛芬坟焚粪忿吩汾棼鼢玢酚偾瀵鲼风封丰峰疯锋逢奉缝凤讽冯蜂枫烽俸砜唪酆葑沣佛否缶夫府服复父负副福富付妇附佛幅伏符赴腐浮扶腹抚覆肤赋弗傅辅拂甫俯斧缚咐脯袱俘敷阜芙釜孚腑匐孵辐涪讣氟桴蜉芾苻茯莩菔幞怫拊滏黼艴麸绂绋趺祓砩黻罘蚨跗蝠呋凫郛稃驸赙馥蝮鲋鳆]"
    "[咖尬嘎噶轧伽旮钆尕尜改该概盖丐钙赅溉垓陔戤感干敢赶甘肝杆尴赣橄竿秆擀坩苷柑泔矸澉疳酐淦绀旰刚港钢岗纲缸扛杠冈肛罡戆筻高告稿搞糕膏皋羔睾槁藁缟篙镐诰槔杲郜锆个革各歌格哥戈隔葛割阁胳搁疙咯鸽嗝骼颌屹搿膈镉纥袼仡鬲塥圪哿舸铬硌虼给根跟亘艮哏茛更耿耕颈庚羹梗哽赓鲠埂绠工公共供功攻宫贡恭巩躬龚弓拱肱汞蚣珙觥够购构狗沟勾苟钩觏篝垢佝岣诟鞲笱枸遘媾缑彀故古顾股鼓姑骨固孤谷估雇辜咕沽箍菇汩轱锢蛊梏鸪毂鹄臌瞽罟钴觚鹘菰蛄嘏诂崮酤牿牯痼鲴挂瓜刮寡呱褂卦剐鸹栝胍诖怪乖拐掴关观管官馆惯冠贯罐灌棺莞倌纶掼盥涫鳏鹳广光逛犷咣胱桄规归贵鬼桂跪柜轨瑰诡刽龟硅闺皈傀癸圭晷簋妫鲑匦庋宄炔刿桧炅鳜滚棍鲧绲磙辊衮国过果锅郭裹帼蝈聒馘掴埚虢呙崞猓椁蜾]"
    "[哈蛤铪还海孩害嘿咳亥骇骸嗨胲醢氦汉喊含寒汗韩憾涵函翰撼罕旱捍酣悍憨晗瀚鼾顸阚焊蚶焓颔菡撖邗邯行航巷杭夯沆颃绗珩好号毫豪浩耗皓嚎昊郝壕蒿貉灏镐嗥嚆薅濠蚝颢和何合河喝赫核吓贺盒呵禾荷鹤壑阂褐诃涸阖嗬貉曷颌劾盍纥蚵翮菏黑嘿嗨很恨狠痕横衡恒哼亨蘅珩桁红轰洪鸿哄宏虹弘烘泓闳薨讧蕻訇黉荭后候後厚侯喉吼猴逅糇骺堠瘊篌鲎乎护呼胡户湖忽互糊虎壶狐沪惚浒唬葫弧蝴囫瑚斛祜猢鹄醐戽扈唿笏琥滹鹕轷烀冱岵怙鹘槲觳瓠鹱煳话华化花划画滑哗桦猾砉铧骅怀坏徊淮槐踝欢换还环缓患幻唤宦焕痪寰鬟涣浣奂桓缳豢锾郇萑圜洹擐獾漶逭鲩黄皇荒晃慌煌惶恍谎璜徨簧凰幌潢蝗蟥遑隍肓磺癀湟篁鳇会回汇挥辉灰惠毁悔恢慧绘徽讳贿徊晦秽诲诙晖彗麾烩荟卉茴喙蛔恚洄珲蕙哕咴浍虺缋桧隳蟪婚混魂昏浑馄荤诨溷阍珲和或活火获货伙祸惑霍豁夥锪耠劐钬攉藿嚯镬蠖]"
    ""
    "[几给己机记及计即基济辑级极寄际技集纪击奇急激继既积籍鸡吉挤迹季寂绩疾饥祭缉忌剂圾姬矶肌嫉讥藉叽脊冀稽妓棘骥畸蓟汲悸岌伎笈跻瘠亟诘暨霁羁稷偈戟嵇楫唧鲫髻荠箕觊蒺畿虮齑殛墼佶掎芨丌麂蕺咭嵴芰笄哜洎乩戢屐剞跽玑鲚赍犄家加价假架甲佳驾夹嫁嘉贾稼茄佼挟颊皎侥枷珈戛迦伽浃痂胛笳荚葭钾镓嘏郏挢岬徼湫敫袈瘕恝铗袷蛱跏见间件建简坚监减渐检健兼剑艰肩键荐尖鉴剪践奸捡箭舰拣贱溅煎俭槛碱歼缄茧笺柬谏蹇僭涧菅謇硷睑锏饯毽鲣鞯蒹搛谫囝湔缣枧戬戋犍裥笕翦趼楗牮鹣腱踺将讲强江奖降蒋疆酱姜浆僵匠犟缰绛桨耩礓洚豇茳糨教交觉校叫较角脚焦骄郊轿搅嚼胶缴绞饺椒矫娇佼狡浇跤姣窖剿侥皎蕉酵礁鲛徼湫敫僬鹪峤蛟铰艽茭挢噍醮界解接结节街姐阶介借戒杰届皆捷截洁揭劫竭藉睫诫嗟拮孑碣秸诘桀芥偈颉讦疖疥婕羯鲒蚧骱喈进今金近尽仅紧禁劲津斤谨锦筋晋巾浸襟瑾矜靳缙烬噤觐馑堇衿荩廑妗卺赆槿经京精境警竟静惊景敬睛镜竞净井径晶荆兢颈憬靖鲸泾阱儆旌痉迳茎胫腈菁粳獍肼弪婧刭靓窘炯迥扃炅就九究酒久旧救纠揪疚舅韭赳鸠灸咎啾臼鹫阄僦厩玖柩桕鬏局据居句举具剧巨聚拒俱距惧菊拘矩桔驹鞠咀沮瞿锯炬飓趄掬踽踞遽橘倨疽龃屦犋裾钜苴雎鞫椐讵苣锔狙榘莒枸榉窭醵琚捐卷倦眷娟隽绢鹃涓镌锩鄄狷桊蠲觉绝决脚嚼掘诀崛爵抉倔獗嗟厥蹶攫谲矍撅噱孓橛噘珏桷劂爝镢蕨觖军均君俊峻钧隽筠菌郡骏竣麇皲捃浚]"
    "[卡咖喀咔佧胩开慨凯铠揩楷恺垲蒈锎剀锴忾看刊侃堪砍坎槛勘瞰龛阚莰戡抗康慷扛炕亢糠伉闶钪考靠铐烤拷犒栲尻可克科客刻课颗渴柯呵棵恪咳苛磕壳坷嗑瞌轲稞疴蝌溘髁钶窠颏珂岢骒缂氪锞蚵肯恳啃垦龈裉坑吭铿空恐控孔倥崆箜口扣抠寇叩蔻眍芤筘苦哭库裤酷枯窟骷刳堀喾绔夸跨垮挎胯侉会快块筷脍蒯哙侩狯浍郐款宽髋况狂矿框旷眶筐匡哐邝诓夼诳圹纩贶亏愧溃窥魁馈睽盔逵葵奎匮傀喟聩岿馗夔篑喹悝暌隗蒉蝰愦揆跬困昆捆坤鲲悃髡锟醌阃琨括阔扩廓栝蛞]"
    "[拉啦辣腊喇垃蜡剌邋旯瘌砬来赖莱睐癞籁徕涞赉铼崃濑兰蓝栏烂懒览滥拦篮揽澜榄婪缆斓岚阑褴镧罱谰漤浪狼朗郎廊琅螂榔啷莨锒稂阆蒗老劳牢捞姥佬潦唠烙酪涝崂痨醪铹栳铑耢了乐勒肋叻泐鳓仂类泪累雷蕾垒磊擂肋儡羸诔镭嘞檑嫘缧酹耒冷愣楞棱塄里理力利立李历离例礼丽励黎厉璃莉哩笠粒俐漓栗狸梨隶吏沥篱厘犁雳罹莅戾鲤俚砺藜俪蜊黧郦痢枥逦娌詈骊荔鳢喱鹂嫠蠡鬲鲡悝坜苈砾藓呖唳猁溧澧栎轹蓠傈缡疠疬蛎锂篥粝跞醴俩联连脸练恋怜莲廉炼帘链敛涟镰殓琏楝裢裣蠊鲢濂臁潋蔹奁两量良亮辆梁俩凉粮谅粱晾踉莨墚魉椋靓了料聊疗辽僚廖寥镣潦撩撂缭燎寮嘹钌獠鹩蓼尥列烈裂劣猎咧趔冽洌捩埒躐鬣林临邻琳淋霖麟凛吝鳞磷躏赁嶙辚檩遴粼蔺懔瞵啉膦廪领令另灵零龄凌玲铃陵岭拎伶聆囹棱菱翎苓瓴棂绫呤柃鲮酃泠羚蛉六留流陆刘溜柳碌瘤榴浏硫琉遛馏镏骝绺锍旒熘鎏鹨龙隆笼胧拢咙聋垄珑窿陇癃茏栊泷垅砻楼陋漏搂喽篓偻娄髅蝼镂蒌嵝耧瘘路陆录卢露鲁炉鹿碌庐芦噜颅禄辘卤虏麓泸赂漉戮簏轳鹭掳潞鲈撸栌垆胪蓼渌鸬逯璐辂橹镥舻氇律旅绿率虑履屡侣缕驴吕榈滤捋铝褛闾膂氯稆乱卵峦挛孪栾銮娈滦鸾脔略掠锊论轮伦沦仑抡囵纶落罗络洛逻裸骆萝螺锣箩摞烙捋珞骡猡镙椤倮蠃荦瘰泺漯脶硌雒]"
    "[呒马吗妈码麻骂嘛抹玛蚂蟆唛杩犸嬷买卖麦埋迈脉霾劢荬满慢漫曼蛮馒瞒蔓颟谩墁幔螨鞔鳗缦熳镘忙茫盲芒氓莽蟒邙漭硭毛冒猫贸矛帽貌茅茂髦卯耄瑁锚懋袤铆峁牦蟊泖昴茆旄蝥瞀么麽没美每妹眉梅媒枚魅煤昧霉玫媚寐糜袂酶莓嵋楣湄猸镅浼鹛镁们门闷扪懑焖钔梦蒙猛盟朦孟萌勐懵檬蠓瞢甍礞蜢虻艋艨锰密米秘迷弥谜觅眯蜜靡咪谧泌糜汨宓麋醚弭敉芈祢脒幂縻嘧蘼猕糸面免棉眠缅绵勉腼冕娩湎沔眄黾渑妙描秒庙苗渺瞄藐缪淼缈喵眇邈鹋杪灭蔑篾咩乜蠛民敏悯闽泯珉皿抿闵苠岷缗玟愍黾鳘名明命鸣铭冥茗溟酩瞑暝螟谬缪默莫模麽末磨摸摩寞漠墨抹魔陌嘿沫膜蓦蘑茉馍摹貉谟嫫秣镆殁瘼耱貊貘某谋眸缪鍪哞侔蛑目母木幕姆慕牧墓募暮牟亩穆睦拇沐牡仫坶苜毪钼]"
    "嗯唔那拿呢哪纳娜呐捺钠镎肭衲乃奶奈耐氖艿鼐佴萘柰难南男楠喃囡囝腩蝻赧囊囔馕攮曩脑闹恼挠瑙淖呶猱铙孬硇蛲垴呢讷内馁嫩恁能嗯唔你呢尼泥逆倪匿拟腻妮霓昵溺旎睨鲵坭猊怩伲祢慝铌年念廿粘碾捻蔫撵拈黏鲶鲇辇埝娘酿鸟尿袅嬲茑脲捏涅聂孽蹑嗫啮镊镍乜陧颞臬蘖您恁宁凝拧泞咛狞柠佞聍苎甯牛纽扭妞钮拗忸狃农弄浓侬哝脓耨怒努奴弩驽胬孥女钕恧衄暖虐疟诺挪懦糯喏搦傩锘]"
    "[哦噢喔欧偶殴呕鸥讴瓯藕沤耦怄]"
    "[怕爬帕扒趴啪琶葩耙杷钯筢派排牌拍徘湃俳蒎哌判盘盼叛畔潘攀拚蹒磐爿蟠襻袢泮旁庞胖乓膀磅彷螃滂耪逄跑炮抛泡袍刨咆狍疱脬庖匏配陪培佩赔沛裴呸胚醅锫辔帔旆霈盆喷湓朋鹏碰彭捧棚蓬膨烹抨篷砰澎怦堋蟛嘭硼批否皮屁披疲辟啤脾匹僻劈譬坯痞癖琵毗霹噼媲郫裨纰丕鼙圮蚍蜱貔陂陴砒仳埤擗吡庀邳疋芘枇罴淠铍甓睥便片篇偏骗翩扁犏谝蹁骈缏胼票漂飘瓢嫖瞟骠嘌剽螵缥莩殍撇瞥氕丿苤品贫拼频聘拚姘嫔榀颦牝平评瓶凭萍乒屏苹坪枰娉俜鲆破迫颇婆坡泊泼魄粕珀叵攴钷笸钋陂泺鄱皤剖裒掊普铺扑朴谱浦葡蒲仆脯瀑菩溥匍璞噗圃埔氆镨蹼镤濮莆]"
    "[起其期气七奇妻企器汽棋齐旗弃启骑欺歧岂戚凄泣契琪乞祈漆迄脐栖沏祺崎祁琦蹊砌憩淇汔亟绮讫嘁岐萋俟杞芪荠耆槭颀芑屺欹桤綮萁蛴蜞綦鳍麒蕲柒亓骐葺畦圻碛恰洽掐伽袷葜髂前钱千签欠牵浅潜迁谦遣歉纤嵌乾谴铅虔钳骞倩堑黔掮悭芊缱愆荨芡阡佥搴褰肷钎仟犍钤岍箝鬈扦慊椠枪墙抢腔呛锵跄羌蔷戕襁樯炝蜣嫱锖戗羟镪桥悄乔巧侨瞧敲翘俏窍峭锹撬跷憔樵鞘橇诮愀谯荞峤缲硗鞒劁切且窃怯茄趄妾砌惬伽锲挈郄箧慊亲钦琴侵秦勤芹擒寝覃沁禽噙揿檎锓芩嗪螓衾廑溱吣情请青清轻晴庆倾卿擎顷氢罄蜻磬謦苘圊檠黥鲭氰箐綮穷琼穹茕邛蛩筇跫銎求球秋邱囚丘酋蚯裘俅虬鳅逑遒赇泅楸犰湫蝤巯鼽糗去取区曲趣屈趋驱渠躯娶觑瞿岖戌蛐衢蛆癯麴阒祛磲鸲诎蠼劬蕖蘧龋苣黢璩氍朐全权圈劝泉券拳犬诠颧蜷绻荃铨痊鬈辁悛畎醛筌却确缺雀瘸榷鹊阕阙炔悫群裙逡麇]"
    "[然染燃冉髯苒蚺让嚷攘壤瓤穰禳扰绕饶娆桡荛热惹喏人任认忍仁韧刃纫饪壬仞稔葚荏妊轫衽仍扔日容荣融蓉溶绒熔榕戎嵘茸冗肜蝾狨肉柔揉蹂鞣糅如入辱儒乳汝褥嚅茹濡蠕孺缛襦颥薷蓐洳溽铷软阮朊瑞锐芮睿蕤枘蕊蚋润闰若弱偌箬]"
    "[洒撒萨卅仨飒挲脎赛塞腮噻鳃三散伞叁毵馓糁霰丧桑嗓搡磉颡扫骚嫂梢臊搔缲缫鳋埽瘙色塞涩瑟啬铯穑森僧杀沙啥傻厦刹纱莎煞砂霎嗄挲歃鲨唼痧裟铩晒筛酾山善闪衫删煽扇陕珊杉擅掺膳栅讪跚汕姗赡潸缮嬗掸膻骟芟埏剡钐鄯舢苫髟疝蟮鳝上商伤尚赏殇裳晌觞熵墒绱垧少绍烧稍勺哨邵梢捎韶苕鞘潲劭杓芍蛸筲艄社设舍涉射摄舌蛇奢赦慑佘赊麝畲厍滠歙猞谁什身深神参甚申审沈伸慎渗绅肾呻婶莘蜃葚娠渖矧诜砷糁谂椹胂哂生声省胜升圣盛剩牲绳甥笙渑眚嵊晟是时十事实使世市识始士师诗式失史视示食室势试石释施适氏驶饰尸拾逝湿誓狮嗜蚀嘘屎侍匙峙仕恃柿轼矢噬拭虱弑蓍埘莳炻谥鲥豕贳铈螫舐筮鲺酾手受收首授守售瘦寿兽狩绶艏书数术属输树述熟束署殊舒叔鼠疏淑抒薯梳暑竖蜀恕墅孰漱枢俞赎黍蔬曙倏庶戍塾澍姝纾秫毹殳疋菽丨沭摅腧刷耍唰率衰摔甩帅蟀涮栓拴闩双爽霜孀泷水谁税睡顺舜瞬吮说朔硕烁铄妁蒴槊搠四死思斯司似私丝寺撕肆厮嘶伺饲嗣祀巳驷鸶俟汜泗厶兕蛳咝姒澌缌耜笥锶送松宋诵耸颂讼悚怂忪淞菘崧嵩凇竦搜艘嗽擞馊薮嗾叟嗖溲飕锼瞍螋苏诉速素俗肃宿塑稣溯酥粟簌夙嗉谡僳愫涑蔌觫算酸蒜狻岁随虽碎遂祟隧髓邃穗隋绥睢荽燧谇眭濉孙损笋荪狲飧榫隼所索缩锁琐梭嗦唆挲娑睃唢嗍蓑羧桫]"
    "[他她它踏塔塌榻嗒蹋沓遢挞鳎闼铊趿漯溻獭太台态泰抬胎汰苔呔鲐邰薹酞骀炱跆肽钛谈探弹坦叹坛摊贪滩毯谭潭瘫炭覃痰忐坍袒碳澹檀昙镡郯锬钽堂唐汤躺糖趟倘烫淌膛塘棠搪溏螳瑭樘螗铴醣镗耥饧傥帑羰讨套逃涛掏陶桃淘滔萄焘啕韬饕洮绦鼗特忑忒慝铽忒腾疼藤誊滕体提题替踢梯啼涕蹄剔剃惕屉嚏悌醍缇鹈锑荑倜绨逖裼天田填甜添腆舔恬钿阗畋忝殄掭条调跳挑迢眺鲦佻苕窕髫粜笤龆祧蜩铁贴帖餮萜听停庭厅挺亭婷廷艇町霆汀铤蜓莛梃葶烃同通统痛童彤筒铜桶捅桐瞳佟恸酮恫侗砼嗵仝垌茼峒潼头投偷透钭骰土突图途徒屠涂吐兔秃凸荼酴钍菟堍团湍抟疃彖推退腿褪颓蜕忒煺吞屯饨褪臀囤豚暾氽托脱拖妥拓陀驼唾椭砣驮沱跎坨鸵乇鼍橐佗庹铊酡柁柝箨]"
    ""
    ""
    "[瓦挖袜娃哇凹娲蛙洼佤腽外歪崴万完晚湾玩碗弯挽顽腕婉惋宛丸蜿莞畹剜豌皖纨琬脘烷芄菀绾望王往网忘亡汪旺枉妄惘罔尢辋魍为位未委维味围卫威微伟谓唯危慰尾违魏玮蔚伪畏胃喂炜韦惟巍纬萎娓苇尉帷渭猥偎薇痿猬逶帏韪煨鲔桅潍隈圩囗诿隗崴洧葳嵬闱沩涠艉軎文问闻温稳吻纹蚊雯紊瘟汶刎阌璺翁瓮嗡蓊蕹我握窝卧渥沃涡斡蜗幄喔倭挝莴肟硪龌无五物务武午舞於误恶吴屋伍悟吾污乌雾侮捂巫毋呜诬勿梧坞戊兀唔晤芜鹜钨妩痦鹉忤寤骛邬牾鼯圬浯仵阢芴庑婺怃杌焐蜈迕鋈]"
    "[西系息希喜席习细戏吸洗惜稀悉析夕牺袭昔熙兮溪隙嘻锡晰媳樨熄膝郗犀禧曦奚羲蹊唏淅嬉皙汐徙茜玺熹烯翕蟋屣檄浠僖穸蜥隰觋螅铣菥葸蓰舾矽粞硒醯欷鼷歙饩阋禊舄下夏吓峡厦侠狭霞瞎暇虾唬辖遐匣黠瑕呷狎柙硖瘕罅现先显线险限县鲜献闲宪陷贤仙嫌咸羡掀弦纤娴衔馅涎舷腺跣暹岘猃蚬筅跹莶锨鹇痫铣氙祆籼冼藓酰苋燹霰想相向象香乡像响项享降箱详祥巷厢湘橡翔镶飨襄饷骧葙庠鲞芗缃蟓小笑校消效晓销潇肖萧孝宵削嚣啸逍硝霄淆哮枭骁箫筱哓枵绡魈蛸崤些写谢协鞋携斜泄胁歇谐邪械屑卸挟懈泻亵蟹偕邂榭撷楔瀣蝎颉勰薤燮躞缬獬绁廨榍渫心新信欣辛薪馨鑫芯衅昕忻锌歆镡囟行性形兴星型姓幸刑醒腥杏悻惺邢猩荇擤荥饧硎陉雄兄胸凶熊匈汹芎修休秀袖宿臭羞绣朽锈嗅咻貅髹馐庥鸺岫溴许续需须徐序虚绪吁蓄叙畜嘘恤絮浒墟旭婿栩戌诩胥酗煦砉盱糈醑顼勖洫溆圩蓿选宣旋悬券喧轩玄炫渲绚眩萱漩暄璇谖铉儇痃泫煊楦癣碹揎镟学血雪削穴谑靴薛踅噱泶鳕寻询训迅讯巡逊循旬熏勋驯荤殉醺巽徇埙荀峋洵薰汛郇曛窨恂獯浔鲟蕈浚]"
    "[亚压雅牙呀押涯讶鸦哑鸭崖丫芽衙轧痖睚娅蚜伢疋岈琊垭揠迓桠氩砑眼言严演研烟验延沿掩颜厌炎燕阎宴盐咽岩雁焰艳焉淹衍阉奄谚俨檐蜒彦腌焱晏唁妍砚嫣胭湮筵堰赝餍鼹芫偃魇闫崦厣剡恹阏兖郾琰罨鄢谳滟阽鼽酽菸样洋阳央杨养扬仰羊痒漾泱氧鸯秧殃恙疡烊佯鞅怏徉炀蛘要摇药耀遥邀腰姚咬尧谣瑶窑夭肴妖吆钥侥杳窈鹞曜舀铫幺爻徭繇鳐珧轺崾也业夜爷叶野页液耶咽曳拽揶噎烨冶椰掖腋谒邺靥晔铘一以意已义议医易衣艺依译移异益亦亿疑遗忆宜椅伊仪谊抑翼矣役艾乙溢毅蛇裔逸姨夷轶怡蚁弈倚翌颐疫绎彝咦佚奕熠贻漪诣迤弋懿呓驿咿揖旖屹痍薏噫镒刈沂臆缢邑胰猗羿钇舣劓仡酏佾埸诒圯荑壹挹嶷饴嗌峄怿悒铱欹殪黟苡肄镱瘗癔翊蜴眙翳因音引印银隐饮阴姻瘾吟寅殷淫茵荫尹蚓垠喑湮胤鄞氤霪圻铟狺吲夤堙龈洇茚窨应英影营迎硬映赢盈颖鹰婴蝇樱莹荧膺萤萦莺罂瀛楹缨颍嬴鹦瑛茔嘤璎荥撄郢瘿蓥滢潆媵哟唷用永拥勇涌踊泳庸佣咏俑雍恿甬臃邕镛痈壅鳙饔喁墉蛹慵有又由友游右油优邮幽尤忧犹悠幼诱佑黝攸呦酉柚鱿莠囿鼬铀卣猷牖铕疣蚰蝣釉蝤繇莜侑莸宥蚴尢于与语育余遇狱雨於欲预予鱼玉愈域誉吁宇寓豫愚舆粥郁喻羽娱裕愉禹浴馀御逾渔渝俞萸瑜隅驭迂揄圄谕榆屿淤毓虞禺谀妪腴峪竽芋妤臾欤龉觎盂昱煜熨燠窬蝓嵛狳伛俣舁圉庾菀蓣饫阈鬻瘐窳雩瘀纡聿钰鹆鹬蜮员元原院远愿园源圆怨缘援冤袁渊苑猿鸳辕垣媛沅橼芫爰螈鼋眢圜鸢箢塬垸掾瑗月乐越约阅跃曰悦岳粤钥刖瀹栎樾龠钺运云允韵晕孕匀蕴酝筠芸耘陨纭殒愠氲狁熨郓恽昀韫郧]"
    "[杂扎砸咋咂匝拶在再载灾仔宰哉栽崽甾咱赞暂攒簪糌瓒拶昝趱錾藏脏葬赃臧锗奘驵早造遭糟澡灶躁噪凿枣皂燥蚤藻缲唣则责泽择咋啧仄迮笮箦舴帻赜昃贼怎谮增赠憎缯罾甑锃炸扎咋诈乍眨渣札栅轧闸榨喳揸柞楂哳吒铡砟齄咤痄蚱摘债宅窄斋寨翟砦瘵战展站占沾斩辗粘盏崭瞻绽蘸湛詹毡栈谵搌旃长张章丈掌涨帐障账胀仗杖彰璋蟑樟瘴漳嶂鄣獐仉幛嫜着找照招朝赵召罩兆昭肇沼诏钊啁棹笊这着者折哲浙遮辙辄谪蔗蛰褶鹧锗磔摺蜇赭柘真阵镇震针珍圳振诊枕斟贞侦赈甄臻箴疹砧桢缜畛轸胗稹祯浈溱蓁椹榛朕鸩政正证整争征挣郑症睁徵蒸怔筝拯铮峥狰诤鲭钲帧之只知至制直治指支志职致值织纸止质执智置址枝秩植旨滞徵帜稚挚汁掷殖芝吱肢脂峙侄窒蜘趾炙痔咫芷栉枳踯桎帙栀祉轾贽痣豸卮轵埴陟郅黹忮彘骘酯摭絷跖膣雉鸷胝蛭踬祗觯中种重众终钟忠衷肿仲锺踵盅冢忪舯螽周州洲粥舟皱骤轴宙咒昼肘帚胄纣诌绉妯碡啁荮籀繇酎主住注助著逐诸朱驻珠祝猪筑竹煮嘱柱烛铸株瞩蛛伫拄贮洙诛褚铢箸蛀茱炷躅竺杼翥渚潴麈槠橥苎侏瘃疰邾舳抓爪拽嘬传专转赚撰砖篆啭馔颛装状壮庄撞妆幢桩奘僮戆追坠缀锥赘隹椎惴骓缒准谆窀肫着桌捉卓琢灼酌拙浊濯茁啄斫镯涿焯浞倬禚诼擢子自字资咨紫滋仔姿吱兹孜梓渍籽姊恣滓谘龇秭呲辎锱眦笫髭淄茈觜訾缁耔鲻嵫赀孳粢趑总宗纵踪综棕粽鬃偬腙枞走奏邹揍驺鲰诹陬鄹组足族祖租阻卒诅俎镞菹赚钻攥纂躜缵最罪嘴醉咀觜蕞尊遵樽鳟撙作做坐座左昨琢佐凿撮柞嘬怍胙唑笮阼祚酢]"))

;;;###autoload
(defun find-by-pinyin-dired (dir pattern)
  "Search DIR recursively for files/directories matching the PATTERN,
and run Dired on those files.
PATTERN is sequence of first character of PinYin from Chinese file name."
  (interactive
   "DFind-name (directory): \nsFind-name (first characters of Hanzi Pinyin): ")

  (let ((regexp ".*"))
    (dotimes (i (length pattern) str)
      (setq str (nth (- (aref pattern i) 97) fbpd-char-table))
      (setq regexp (concat regexp str ".*")))
    ;; find-lisp-find-dired is a lisp version
    (find-lisp-find-dired dir regexp)))

(provide 'find-by-pinyin-dired)

;;; find-by-pinyin-dired.el ends here
