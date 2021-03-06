/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80015
 Source Host           : localhost:3306
 Source Schema         : library

 Target Server Type    : MySQL
 Target Server Version : 80015
 File Encoding         : 65001

 Date: 09/06/2020 16:31:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `book_id` int(11) NOT NULL AUTO_INCREMENT,
  `book_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `intro` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `number` int(100) NOT NULL,
  `price` double(10, 2) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `photourl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `press` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`book_id`) USING BTREE,
  INDEX `type_id`(`type_id`) USING BTREE,
  CONSTRAINT `type_id` FOREIGN KEY (`type_id`) REFERENCES `category` (`c_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '计算机网络技术', '本书是一本计算机网络的基础教材。该书共分为12章，内容包括：计算机网络的概论、计算机网络的基本原理、网络通信技术、计算机网络设备、计算机网络互连、网络操作系统、Internet、计算机网络安全与管理、计算机网络系统集成等。该书可作为高等学校的教材，同时也可以满足从事计算机网络建设与应用的各类人员学习网络应用与Internet技术的需要。', '叶勇健，陈二微，林勇升', 2, 40.00, 1, '\\images\\1_1.png', 'A区1号柜', '北京理工大学出版社');
INSERT INTO `book` VALUES (2, '计算机操作系统', '操作系统是计算机资源的管理者，本书从计算机资源管理者的角度出发，系统、全面地阐述了操作系统的概念、原理和方法。全书共分为９章', '韩彦岭，李净', 2, 60.00, 1, '\\images\\1_2.png', 'A区1号柜', '上海科学技术出版社');
INSERT INTO `book` VALUES (3, '计算机组成原理', '本书主要围绕计算机的几个组成部分、这几个组成部分之间的协调配合、计算机的指令流数据流的流程以及计算机的工作原理等内容进行讲解。全书共分7个项目，分别是计算机的构成、结构，整体工作流程；数据在计算机中的表示方法；存储器系统；指令系统；IO系统；CPU；综合部分。', '魏胜利，曹领', 4, 55.00, 1, '\\images\\1_3.jpg', 'A区1号柜', '电子科技大学出版社');
INSERT INTO `book` VALUES (4, '计算机导论', '本书概括讨论计算机学科主要涉及的基本内容和重要应用，全书共分11章，分别是计算机发展与专业概述、数制和编码、计算机系统组成、互联网基础、数据库系统、软件与程序设计、网站建设基础、物联网技术及其应用、电子商务、企业管理与信息化、新技术与就业。', '张万民，王振友', 2, 45.00, 1, '\\images\\1_4.jpg', 'A区1号柜', '北京理工大学出版社');
INSERT INTO `book` VALUES (5, '大学计算机基础', '本书分为6章，内容包括：计算机基础知识、WindowsXP使用基础、文字处理软件Word、电子表格软件Excel、演示文稿软件PowerPoint、计算机网络应用基础。', '杨志峰，高望，魏忠凯', 3, 20.00, 1, '\\images\\1_5.jpg', 'A区1号柜', '电子科技大学出版社');
INSERT INTO `book` VALUES (6, '数据结构', '共分9章，第1章介绍数据结构的基本概念和算法的表示和分析方法，第2章至第7章以线性结构、树状结构、图状结构为主线，由简到繁地介绍了顺序表、链表以及栈和队，树和二叉树，图等几种基本数据结构及有关算法。第8章和第9章详细介绍了在实际应用中广泛使用的查找和排序的基本算法。全书以知识单元为结构，各知识单元内容相互独立，知识面广，内容丰富。', '张珊靓，朱宗胜', 2, 43.00, 1, '\\images\\1_6.jpg', 'A区2号柜', '电子科技大学出版社');
INSERT INTO `book` VALUES (7, '算法与数据结构 C语言版', '本书主要内容包括绪论、线性表、栈和队列、串、数组、树形结构、图、内部排序、查找。教材中对各类数据结构的分析按照“逻辑结构-存储结构-基本运算的实现-时空性分析-实例”的顺序进行讲述，结构规范，条理清晰。书中给出的程序和算法都是经过仔细筛选的经典内容，便于读者理解和掌握，程序采用C语言描述并容易调试通过；每章有重点介绍和总结，总结对重要的知识点进行穿线，每章后针对本章重要知识点配有大量习题。本书可作为高等院校计算机有关专业本科生、专科生教材，也可作为自考成人教育的教材。', '邓玉洁', 3, 45.00, 1, '\\images\\1_7.jpg', 'A区2号柜', '北京邮电大学出版社');
INSERT INTO `book` VALUES (8, 'Java程序设计', '本书采用基础优先、循序渐进的方式安排教学内容,通过问题驱动的方式讲授Java程序设计的概念和技术,全面细致地介绍Java技术涵盖的基本内容。', '余平，王金凤', 5, 60.00, 1, '\\images\\1_8.jpg', 'A区2号柜', '北京邮电大学出版社');
INSERT INTO `book` VALUES (9, 'Java Web编程详解', '本书深入介绍了JavaWeb编程的最核心内容，强调实战。全书内容覆盖Java进行Web编程必须的HTML、CSS、XML、JAVASCRIPT、JSP、SERVLET、AJAX技术。本书不是单纯从知识角度来讲解JavaWeb开发技术，而是从解决问题的角度来介绍JavaWeb开发，所以书中介绍了大量的实例程序，这些案例既能让读者巩固每章的知识，又可以让读者学以致用、激发编程自豪感，进而引爆内心的编程激情。章节和程序循序渐进、语言通俗易懂、注重实例、程序很好调试、注解充分，因此非常易懂。', '杨卫兵', 3, 45.00, 1, '\\images\\1_9.jpg', 'A区2号柜', '东南大学出版社');
INSERT INTO `book` VALUES (10, 'PHP编程基础与案例开发', '《PHP编程基础与案例开发》系统地介绍了PHP程序开发的相关知识，并在实际应用中通过具体案例，使读者巩固所学知识，更好地进行开发实践。《PHP编程基础与案例开发》将教学内容划分为11章，内容包括PHP入门与开发环境搭建、PHP开发基础、PHP流程控制、PHP数组、PHP函数、正则表达式、面向对象编程、MySQL数据库、Form表单以及两个综合案例。《PHP编程基础与案例开发》内容丰富、讲解深入浅出，适用于初、中级PHP用户，可以作为各类院校相关专业的教材，同时也是一本面向广大PHP爱好者的实用参考书。', '刘丽，杨灵', 2, 52.00, 1, '\\images\\1_10.jpg', 'A区2号柜', '北京理工大学出版社');
INSERT INTO `book` VALUES (11, '老人与海', '圣地亚哥是古巴的一个老渔夫，他和一个叫马诺林的男孩子是忘年交。整整84天，圣地亚哥都没有钓到鱼。第85天，老人出海很远，终于钓到了一条很大的马林鱼。老人同大鱼搏斗了两天一夜，终于把大鱼杀死，绑在船边胜利返航。但在返航的过程中又遇到了鲨鱼的进攻，老人与鲨鱼展开搏斗，由于鲨鱼太多难以对付。当船驶进小港时，大鱼只剩下了白色的鱼脊骨。', '欧内斯特·米勒·海明威', 3, 45.00, 2, '\\images\\2_1.jpg', 'B区1号柜', '四川科学技术出版社');
INSERT INTO `book` VALUES (12, '汤姆·索亚历险记', '故事发生在19世纪上半叶美国密西西比河畔的圣彼得堡小镇上。小主人公汤姆父母过世后，由波莉姨妈收养。姨妈很疼爱他，却又为他的淘气而头疼不已。一天晚上，汤姆和哈克贝利·费恩一起去坟地，无意中看到了印江·乔把一位医生杀死了，并嫁祸给了被打昏的波特。汤姆和哈克被吓坏了，发誓绝不泄密，但这使他们非常愧疚。法官即将对波特的罪行做出判决，这使汤姆感到更为不安。经过激烈的思想斗争，最终，他战胜了恐惧和自私，指出了真凶，但凶手还是逃走了。在一次野餐活动中，汤姆和他喜欢的女孩儿贝琪因为迷路被困在了山洞里。在山洞中汤姆再一次遇见了杀人凶手印江·乔。最终，汤姆靠牵着绑在石头上的风筝线探路，走出了山洞。村民们发现了他们，并听他们讲述了在洞中的经历。之后，村民们用铁板封死了山洞，印江·乔死在了山洞里，村民们因此非常感谢他们。后来，汤姆和哈克返回山洞，找到了一笔可观的宝藏，成了小镇上的富翁。', '马克·吐温', 2, 30.00, 2, '\\images\\2_2.jpg', 'B区1号柜', '四川科学技术出版社');
INSERT INTO `book` VALUES (13, '朱自清散文选', '朱自清散文是中国现代散文的典范。《朱自清散文选》精选《匆匆》《背影》《荷塘月色》《春》《威尼斯》等很能代表朱自清艺术水平的名篇，以飨读者。朱自清的作品风格素朴缜密，清隽沉郁，以语言洗练、文笔秀丽，善于把自己的真情实感，通过平易的叙述表达出来，笔致简约、亲切，读来有一种娓娓动人的风采。对中小学生的阅读与写作具有指导和参考意义。', '朱自清', 2, 60.00, 2, '\\images\\2_3.jpg', 'B区2号柜', '四川科学技术出版社');
INSERT INTO `book` VALUES (14, '朝花夕拾·呐喊', '《朝花夕拾》是鲁迅1926年所作回忆散文的结集，共十篇。前五篇写于北京，后五篇写于厦门。《呐喊》是一部短篇小说集，收录了鲁迅在1918―1922年间所写的15篇小说。1930年靠前3次印刷时，由作者抽去其中的《不周山》一篇（后改为《补天》），收入《故事新编》。其中，《狂人日记》《阿Q正传》《孔乙己》等文章皆为鲁迅的代表作。《朝花夕拾呐喊》为这两部作品的合集。', '鲁迅', 2, 55.00, 2, '\\images\\2_4.jpg', 'B区2号柜', '四川科学技术出版社');
INSERT INTO `book` VALUES (15, '\r\n焦裕禄家风', '该书翔实记载焦裕禄与他的儿女们在家庭内外的生活细节，以及焦裕禄对孩子们既严格要求又润物无声的言传身教和革命熏陶，从中可见焦裕禄既是慈父也是严父的崇高形象，今天的党员干部依然能从中汲取丰富的精神养分。', '赵瑜', 1, 30.00, 2, '\\images\\2_5.jpg', 'B区2号柜', '河南文艺出版社');
INSERT INTO `book` VALUES (16, '2000个应该知道的军事常识', '不管是中国, 还是外国, 几千年的文明史也是你来我往、残酷杀戮的战争史, 人类社会总是与战争相伴随。本书详细描述了2000多个军事方面的常识, 包括中外著名战役、将领、武器装备、军事论著、战略战术等内容。', '李艳君，刘利生', 1, 30.00, 3, '\\images\\3_1.jpg', 'C区1号柜', '内蒙古科学技术出版社');
INSERT INTO `book` VALUES (17, '高校军事理论教程', '本书根据《中华人民共和国国防教育法》、国家国防动员委员会颁发的《全民国防教育大纳》和中华人民共和国教育部、中国人民解放军总参谋部、中国人民解放军总政治部2007年重新颁发的《普通高等学校军事课教学大纲》规定的课程内容组织编写。书中包括国防基本知识、军事思想、战略环境等。', '贺幸平', 2, 42.00, 3, '\\images\\3_2.jpg', 'C区1号柜', '北京理工大学出版社');
INSERT INTO `book` VALUES (18, '普通高校军事理论与技能教程', '本书结合我国军事变革的新形势，着眼于时代的发展，力求创新，既全面体现了《普通高等学校军事课教学大纲》的要求，又符合军事科学规律和高等院校军事课程教学的客观实际；既注重其思想性、教育性、理论性，也注重其知识性、趣味性、基础性，具有结构合理、内容翔实、可读性强的特点，基本形成了科学完整的大学生军事课程体系。本书本书结合我国军事变革的新形势，着眼于时代的发展，力求创新，既全面体现了《普通高等学校军事课教学大纲》的要求，又符合军事科学规律和高等院校军事课程教学的客观实际，可供开设军事课的各类高等学校作为教材或教学参考用书。', '冯小宁', 2, 50.00, 3, '\\images\\3_3.jpg', 'C区1号柜', '华南理工大学出版社');
INSERT INTO `book` VALUES (19, '孙子兵法与三十六计 注·译·析', '《孙子兵法》被誉为“兵学圣典一，为春秋时期著名军事家孙武所著，《三十六计》则是一部起源于南北朝并最终成书于明清时期的军事著作。《孙子兵法》和《-十六计》虽然都是军事著作，在当代却被广泛运用于社会生活的方方面面。依据的版本，以原文、注释、集注、译文、解析、案例的架构形式，对《孙子兵法》和《三十六计》进行了深入浅出的解读，希望能够为读者掌握这两部军事著作的思想精髓提供一些助益。', '任宪宝', 3, 40.00, 3, '\\images\\3_4.jpg', 'C区2号柜', '中国言实出版社');
INSERT INTO `book` VALUES (20, '未来之战 全维精确战', '本书主要内容包括:战争与武装冲突;未来,为何而战?战争的演变;未来战争是有限战争;第四代战争;乌克兰内战——未来战争和武装冲突典型样式等。', '李大鹏', 1, 30.00, 3, '\\images\\3_5.jpg', 'C区1号柜', '新华出版社');
INSERT INTO `book` VALUES (21, '电子商务会计基础', '本书分三大部分:第一篇，会计基础知识。包括:认识会计、会计核算基础等;第二篇，会计基础实务。包括:企业注册、企业资金筹集、采购业务等;第三篇，项目实施-从会计视角分析电子商务企业的经营运作。', '邢广陆，朱传霞', 2, 40.00, 4, '\\images\\4_1.jpg', 'D区1号柜', '北京理工大学出版社');
INSERT INTO `book` VALUES (22, '基础会计', '本书以《会计法》、《企业财务会计报告条例》、2017年以来新修订会计准则及应用指南为法律法规依据，选取一般工业企业主要交易或事项为例，共有10章内容。第1章至第3章阐述企业会计核算的基础理论、基本方法和基本操作技术，着重介绍会计概念、会计循环、复式记账方法及其应用；第4章基于企业“生命周期”介绍企业从注册到注销过程中典型交易或事项的会计核算方法；第5章至第8章介绍会计凭证与会计账簿、财产清查、账务处理程序等内容；第9章至第10章介绍财务报表及会计工作组织。本书强调对会计信息的理性认识和逻辑理解，突出对会计概念的整体认识和系统把握，兼顾会计基础理论与方法操作的有机结合。本书除作为应用型本科院校会计学、审计学、财务管理等专业的教材或教学参考书外，还可以作为会计实务工作者的工作参考用书。', '李政，赵桂青', 2, 35.00, 4, '\\images\\4_2.jpg', 'D区1号柜', '北京理工大学出版社');
INSERT INTO `book` VALUES (23, '电子商务概论', '本书共分为九个章节, 主要包括电子商务导论、电子商务模式、网络市场、网络营销、电子商务与物流、电子商务支付、电子商务安全技术、电子商务战略、电子商务法律问题等内容。每个章节以案例引入, 以思考题结尾, 结构清晰, 通俗易懂, 引导性强。', '文英姐，黎金玲', 2, 30.00, 4, '\\images\\4_3.jpg', 'D区2号柜', '重庆大学出版社');
INSERT INTO `book` VALUES (24, '经济管理', '《经济管理》系统地介绍了经济学的基本知识和管理学的基本知识，介绍了经济学与管理学的概念，并从供求理论、消费者行为理论、生产理论、成本理论、工程经济分析等方面，阐述了经济学的基本原理，以及工程项目决策中的经济问题分析方法和工具；从管理与管理者、管理决策、计划、组织与组织设计、领导与激励、管理控制等方面，阐述了管理的基本问题和管理的各项职能。通过《经济管理》的学习，使学生建立经济与管理思维，增强适应社会和市场的能力，更有效地整合技术、经济和管理等要素为创造顾客价值。《经济管理》可作为高等院校非经济专业的学生学习经济管理理论的本科基础教材，也可作为高等教育自学考试的学习用书，还可作为广大企业非经济管理专业的工程师、管理者等了解经济管理知识的参考资料。', '朱伏平，杨方燕', -2, 40.00, 4, '\\images\\4_4.jpg', 'D区2号柜', '西南交通大学出版社');
INSERT INTO `book` VALUES (25, '国际贸易实务', '本书是一本介绍国际贸易实务基本理论与操作技能的实用性教材，分为十二个项目，系统介绍贸易术语、货物条款、国际货物运输、国际货物运输保险、价格核算、国际货款的收付、贸易纠纷的预防与处理、交易准备等内容。', '林悦，徐军', 1, 35.00, 4, '\\images\\4_5.jpg', 'D区2号柜', '北京理工大学出版社');
INSERT INTO `book` VALUES (26, '思想政治教育实践育人理论与对策研究', '这是一本研究在国家思想政治教育政策指导下开展思想政治教育实践育人理论与对策的专著。该书用学术的语言表达，围绕学生、关照学生、服务学生，不断提高学生思想水平、政治觉悟、道德品质、文化素养，让学生成为德才兼备、全面发展的人才的目标，论述了开展思想政治教育实践育人主客体及其矛盾、工作意识与管理理念、工作观念与方法，并结合工作实际，总结了马克思主义学院非马克思主义理论学科专任教师参与思想政治教育工作的经验。', '张子睿，卢彤', 1, 40.00, 5, '\\images\\5_1.jpg', 'E区1号柜', '经济日报出版社');
INSERT INTO `book` VALUES (27, '新时代党性修养十二讲', '本书以新时代中国特色社会主义思想、党的*精神和*党章为依据，以理论与实践相结合的方式，对新时代加强党性修养的重要意义、基本要求、基本原则、实现路径、主要内容等进行阐释。重点论述了如何加强政治修养、理论修养、道德修养、作风修养、纪律修养、廉政修养和法治修养，并对如何提高学习实践能力、弘扬优秀传统文化、自觉进行党性分析进行深度解读。', '张福俭', 1, 40.00, 5, '\\images\\5_2.jpg', 'E区1号柜', '华文出版社');
INSERT INTO `book` VALUES (28, '党风十章', '本书是为广大党员群众精心打造的一个党风通俗理论读本。全书以习近平新时代中国特色社会主义思想为指导，紧紧围绕中国共产党党风，立足党近百年辉煌历史，落脚党员干部的思想和工作实际，结合世情、党情形势变化，分十个部分全面解读党风的基本内涵、重要作用、历史实践、现代考验等内容，重点从思想作风、学风、工作作风、领导作风、生活作风五个方面入手，对党的一系列优良党风进行了系统地梳理和概括，展现了十八大以来党中央全面从严治党的新理念新思想新战略，生动地展现了党风的基本内涵和核心精神。全书理论与历史相结合，知识性和实践性相结合，通俗易懂，对于在新时代不忘初心、牢记使命，坚定共产党人的理想信念，凝聚党心民心，以优良党风塑造良好政风和民风，具有重要意义', '董振华', 1, 35.00, 5, '\\images\\5_3.jpg', 'E区1号柜', '广西人民出版社');
INSERT INTO `book` VALUES (29, '全面从严治党再出发', '纵观党的十八大以来波澜壮阔的五年，全面从严治党无疑是贯穿始终而又影响深远的一件大事。以*同志为核心的党中央直面党内存在的种种问题和弊端，把全面从严治党纳入“四个全面”战略布局，以前所未有的决心勇气力度推进管党治党，采取一系列开创性和突破性的重大举措，锻造气象一新的强大政党，为党和国家事业历史性变革提供坚强政治保证。本书从“以零容忍态度惩治腐败”“发挥巡视检查的利剑作用”“纠正四风不止步”“作风建设永远在路上”等维度，将十九届中央纪委二次全会治党管党的*精神一以贯之，系统梳理，权威解读，可以作为基层党组织贯彻全面从严治党要求的通俗理论读本。', '本书编写组', 1, 25.00, 5, '\\images\\5_4.jpg', 'E区1号柜', '新华出版社');
INSERT INTO `book` VALUES (30, '民事诉讼法实务教程', '本书对法律专业研究生不能马上适应法律实务工作的情况进行写作设计，更加强调学习者对人民法院主导的民事诉讼程序实际情况的了解。本书分为十一章，分别为：民事诉讼法基本理论、管辖制度、当事人及其代理人、证据与证明、诉讼保障制度、调解制度、一审程序、二审程序、再审程序、非诉讼程序、执行程序。除第一章涉及民事诉讼基本理论外，其余十章内容按照《中华人民共和国民事诉讼法》中的内容排序，逐章讲授，根据从一件民事纠纷的产生、提起诉讼、到民事诉讼的管辖、证明、调解与判决并最终执行的全过程，将民事诉讼程序的实际操作过程展现在学习者的面前。', '秦涛', 1, 66.00, 5, '\\images\\5_5.jpg', 'E区2号柜', '华东理工大学出版社');
INSERT INTO `book` VALUES (31, '英语四六级词汇速成 构词+联想记忆法', '本书根据大学英语教学大纲编写而成，采用词根+词缀的拼写方式，帮助考生有效记忆大学英语四级考试的词汇。从而达到高效记忆、攻克四六级考试的目的。', '刘金龙，杨唯伟', 5, 55.00, 6, '\\images\\6_1.jpg', 'F区1号柜', '华东理工大学出版社');
INSERT INTO `book` VALUES (32, '考研英语满分写作与翻译', '本书分为写作和翻译两大部分，有效结合了历年考试真题，从理论和实践两方面进行讲解和探讨，力图为参加英语（二）的考生们提供一本比较实用、较易于模仿的指导手册，成为相关课程外的充实实力的重要资源，可以使考生在最短的时间内达到最好的复习效果。', '汪海洋，马全海', 5, 35.00, 6, '\\images\\6_2.jpg', 'F区1号柜', '电子科技大学出版社');
INSERT INTO `book` VALUES (33, '玩转考研英语长难句 适用于英语1和英语2', '本书选取考研英语历年真题中各种题型中出现的长难句，将其分门别类进行归纳，然后展开深度剖析，最终达到深刻理解与完美翻译的目的。分门别类的主要依据是根据考研大纲中所罗列的语法要求，并从中选取相关的句法概念逐一展开论述，包括定语从句、名词性从句、同位语从句等各大从句部分，省略与倒装现象，比较结构，平行结构，句子分割，否定句式等各种长难句类型。', '韩健', 5, 30.00, 6, '\\images\\6_3.jpg', 'F区1号柜', '上海交通大学出版社');
INSERT INTO `book` VALUES (34, '商务英语精读', '本书共16个单元，供2个学期使用。每单元由阅读、练习、口语、写作、商务英语学习指导、单元项目任务六大部分组成。TextA、TextB两篇阅读文章属于同一主题，其中A课文为精读，包括导入、课文、生词与词组、注释、课文练习、商务加油站等内容。B课文为泛读课文，是A课文的延伸与拓展，配有生词和注释，练习则包括阅读理解和英译汉的长句翻译。口语练习部分参照历年高职高专三级考试和技能大赛的题型，选择与本单元相关的练习内容。写作则包含技能大赛和三级中常见的图表作文和应用文写作。学习策略则包括商务英语本身的介绍以及商务英语阅读策略内容。每个单元都有一个需要学生一团队形式完成的项目任务。', '冯秀红，顾芸', 6, 40.00, 6, '\\images\\6_4.jpg', 'F区2号柜', '复旦大学出版社');
INSERT INTO `book` VALUES (35, '大学英语综合教程', '《大学英语综合教程》既注意打好语言基础，更侧重培养应用能力，特别是实际使用英语进行涉外交际的能力。在培养阅读能力的同时，加强听、说、写、译等语言技能的综合训练，尤其注重口头和书面实用表达能力的训练与培养。', '吴得禄，方钰', 3, 35.00, 6, '\\images\\6_5.jpg', 'F区2号柜', '电子科技大学出版社');
INSERT INTO `book` VALUES (38, '锦字回文 写给岁月的诗', '本书收录了作者在十二岁至十四岁之间写下的散文，从中可以看到一位少女对成长、人生、友情、亲情和读书等方面的独特感悟。她的文章饱含真情，洋溢着对诗意的追求，对生活的热爱和对未来的希冀。在华丽精美的语言下，你可以看到一个女孩单纯又美丽的心境。', '叶芗', 2, 56.50, 2, '\\images\\2_6.jpg', 'B区2号柜', '四川科学技术出版社');
INSERT INTO `book` VALUES (46, '计算机辅助设计与制造课程实验指导书', '本书共分为八章，主要内容包括：目的和意义、实验条件、实验内容、零件实体建模、毛坯实体建模、零件数控编程、有限元分析等。', '刘少丽，丁晓宇', 2, 32.00, 1, '\\images\\1_11.jpg', 'A区2号柜', '北京理工大学出版社');

-- ----------------------------
-- Table structure for borrowtable
-- ----------------------------
DROP TABLE IF EXISTS `borrowtable`;
CREATE TABLE `borrowtable`  (
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `borrow_date` datetime(0) NOT NULL,
  `return_date` datetime(0) DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`user_id`, `book_id`, `borrow_date`) USING BTREE,
  INDEX `book_id`(`book_id`) USING BTREE,
  CONSTRAINT `book_id` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrowtable
-- ----------------------------
INSERT INTO `borrowtable` VALUES (3, 25, '2020-05-07 12:31:12', NULL, '未归还');
INSERT INTO `borrowtable` VALUES (3, 26, '2020-05-20 12:59:41', '2020-05-31 18:36:38', '已归还');
INSERT INTO `borrowtable` VALUES (4, 1, '2020-06-09 14:19:44', '2020-06-09 14:19:53', '已归还');
INSERT INTO `borrowtable` VALUES (4, 1, '2020-06-09 14:36:33', NULL, '未归还');
INSERT INTO `borrowtable` VALUES (4, 4, '2018-02-01 11:57:58', '2018-04-01 17:03:00', '已归还');
INSERT INTO `borrowtable` VALUES (4, 7, '2019-06-01 11:53:06', '2019-07-11 06:51:05', '已归还');
INSERT INTO `borrowtable` VALUES (4, 11, '2020-01-01 16:05:00', '2020-02-05 13:52:53', '已归还');
INSERT INTO `borrowtable` VALUES (4, 18, '2020-03-13 16:46:00', '2020-03-31 15:57:03', '已归还');
INSERT INTO `borrowtable` VALUES (4, 24, '2020-04-03 12:04:57', '2020-05-31 18:37:02', '已归还');
INSERT INTO `borrowtable` VALUES (4, 24, '2020-05-20 12:55:09', '2020-05-31 18:37:02', '已归还');
INSERT INTO `borrowtable` VALUES (4, 29, '2020-05-08 12:05:59', NULL, '未归还');
INSERT INTO `borrowtable` VALUES (4, 34, '2020-05-01 13:52:57', '2020-05-20 14:14:00', '已归还');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `c_id` int(11) NOT NULL AUTO_INCREMENT,
  `c_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `intro` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`c_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '计算机类', '系列关于计算机知识的书籍      ');
INSERT INTO `category` VALUES (2, '文学类', '畅游在曼妙的语言世界中');
INSERT INTO `category` VALUES (3, '军事类', '领略军人风采，展现国家军事力量');
INSERT INTO `category` VALUES (4, '经济类', '系列关于金融经济书籍');
INSERT INTO `category` VALUES (5, '政治、法律类', '了解国家政治领域、国家法律');
INSERT INTO `category` VALUES (6, '英语类', '有关英语四六级、考研英语等书籍');
INSERT INTO `category` VALUES (28, '农业类', '带你探索农业中的奥秘');
INSERT INTO `category` VALUES (29, '科技类', '');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phonenum` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `age` int(100) DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_rank` int(3) NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '123', '13990757756', NULL, NULL, 1);
INSERT INTO `user` VALUES (2, '张三', '111', '18782999055', 23, '男', 0);
INSERT INTO `user` VALUES (3, '小红', '111', '13990870063', 20, '女', 0);
INSERT INTO `user` VALUES (4, '赵立远', '111', '13990755586', 23, '男', 0);
INSERT INTO `user` VALUES (5, '张俸铖', '123', '18042666919', 20, '男', 1);
INSERT INTO `user` VALUES (26, 'Mary', '123', '15687532459', 25, '女', 0);
INSERT INTO `user` VALUES (28, 'Jack', '123', '13696216532', 25, '男', 0);

SET FOREIGN_KEY_CHECKS = 1;
