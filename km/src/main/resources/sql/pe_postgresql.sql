CREATE TABLE t_pe_category (
  "id"              VARCHAR(32) PRIMARY KEY,
  "corp_code"       VARCHAR(50)   NOT NULL,
  "create_by"       VARCHAR(32)   NOT NULL,
  "create_time"     TIMESTAMP(6)  NOT NULL,
  "update_by"       VARCHAR(32)   NOT NULL,
  "update_time"     TIMESTAMP(6)  NOT NULL,
  "id_path"         VARCHAR(1300) NOT NULL,
  "parent_id"       VARCHAR(255),
  "show_order"      FLOAT4        NOT NULL,
  "category_name"   VARCHAR(50)   NOT NULL,
  "category_type"   VARCHAR(20)   NOT NULL,
  "category_status" VARCHAR(20)   NOT NULL,
  "is_default"      BOOL
);
COMMENT ON TABLE t_pe_category IS '类别表';
COMMENT ON COLUMN t_pe_category.id IS '主键';
COMMENT ON COLUMN t_pe_category.id_path IS 'idPath';
COMMENT ON COLUMN t_pe_category.parent_id IS '父类ID';
COMMENT ON COLUMN t_pe_category.show_order IS '排序';
COMMENT ON COLUMN t_pe_category.category_name IS '类别名称';
COMMENT ON COLUMN t_pe_category.category_type IS '类别类型(POSITION("岗位"), ITEM_BANK("题库"), KNOWLEDGE("知识点"), ORGANIZE("部门"), PAPER("试卷"))';
COMMENT ON COLUMN t_pe_category.category_status IS '状态';
COMMENT ON COLUMN t_pe_category.is_default IS '是否默认值';
CREATE INDEX "i_pe_category_corpCode"
  ON "t_pe_category" USING BTREE (corp_code);
CREATE INDEX "i_pe_category_parentId"
  ON "t_pe_category" USING BTREE (parent_id);

CREATE TABLE t_pe_file (
  "id"             VARCHAR(32) PRIMARY KEY,
  "corp_code"      VARCHAR(50)  NOT NULL,
  "create_by"      VARCHAR(32)  NOT NULL,
  "create_time"    TIMESTAMP(6) NOT NULL,
  "update_by"      VARCHAR(32)  NOT NULL,
  "update_time"    TIMESTAMP(6) NOT NULL,
  "file_name"      VARCHAR(100),
  "file_size"      INT8,
  "fs_type"        VARCHAR(20)  NOT NULL,
  "template_type"  VARCHAR(20),
  "processor_type" VARCHAR(20),
  "suffix"         VARCHAR(20),
  "refer_id"       VARCHAR(32)
);
COMMENT ON TABLE t_pe_file IS '文件表';
COMMENT ON COLUMN t_pe_file.id IS '主键';
COMMENT ON COLUMN t_pe_file.file_name IS '文件名称';
COMMENT ON COLUMN t_pe_file.file_size IS '文件大小';
COMMENT ON COLUMN t_pe_file.fs_type IS '功能类型';
COMMENT ON COLUMN t_pe_file.fs_type IS '功能类型';
COMMENT ON COLUMN t_pe_file.template_type IS '模块类型';
COMMENT ON COLUMN t_pe_file.processor_type IS '文件类型';
COMMENT ON COLUMN t_pe_file.refer_id IS '关联主键';
COMMENT ON COLUMN t_pe_file.suffix IS '文件后缀';
CREATE INDEX "i_pes_file_corpCode"
  ON t_pe_file USING BTREE (corp_code);

CREATE TABLE t_uc_organize (
  "id"              VARCHAR(32) PRIMARY KEY,
  "corp_code"       VARCHAR(50)   NOT NULL,
  "create_by"       VARCHAR(32)   NOT NULL,
  "create_time"     TIMESTAMP(6)  NOT NULL,
  "update_by"       VARCHAR(32)   NOT NULL,
  "update_time"     TIMESTAMP(6)  NOT NULL,
  "id_path"         VARCHAR(1300) NOT NULL,
  "parent_id"       VARCHAR(255),
  "show_order"      FLOAT4        NOT NULL,
  "organize_name"   VARCHAR(50)   NOT NULL,
  "organize_status" VARCHAR(20)   NOT NULL,
  "is_default"      BOOL
);
COMMENT ON TABLE t_uc_organize IS '部门表';
COMMENT ON COLUMN t_uc_organize.id IS '主键';
COMMENT ON COLUMN t_uc_organize.id_path IS 'idPath';
COMMENT ON COLUMN t_uc_organize.parent_id IS '父类ID';
COMMENT ON COLUMN t_uc_organize.show_order IS '排序';
COMMENT ON COLUMN t_uc_organize.organize_name IS '部门名称';
COMMENT ON COLUMN t_uc_organize.organize_status IS '部门状态';
COMMENT ON COLUMN t_uc_organize.is_default IS '是否默认值';
CREATE INDEX "i_uc_organize_corpCode"
  ON t_uc_organize USING BTREE (corp_code);
CREATE INDEX "i_uc_organize_parentId"
  ON t_uc_organize USING BTREE (parent_id);

CREATE TABLE t_uc_position (
  "id"              VARCHAR(32) PRIMARY KEY,
  "corp_code"       VARCHAR(50)  NOT NULL,
  "create_by"       VARCHAR(32)  NOT NULL,
  "create_time"     TIMESTAMP(6) NOT NULL,
  "update_by"       VARCHAR(32)  NOT NULL,
  "update_time"     TIMESTAMP(6) NOT NULL,
  "position_name"   VARCHAR(50)  NOT NULL,
  "position_status" VARCHAR(20)  NOT NULL,
  "category_id"     VARCHAR(32)  NOT NULL REFERENCES "t_pe_category" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
COMMENT ON TABLE t_uc_position IS '岗位表';
COMMENT ON COLUMN t_uc_position.id IS '主键';
COMMENT ON COLUMN t_uc_position.position_name IS '岗位名称';
COMMENT ON COLUMN t_uc_position.category_id IS '岗位类别ID';
COMMENT ON COLUMN t_uc_position.position_status IS '岗位状态';
CREATE INDEX "i_uc_position_categoryId"
  ON t_uc_position USING BTREE (category_id);
CREATE INDEX "i_uc_position_corpcCode"
  ON t_uc_position USING BTREE (corp_code);

CREATE TABLE t_uc_user (
  "id"             VARCHAR(32) PRIMARY KEY,
  "corp_code"      VARCHAR(50)  NOT NULL,
  "create_by"      VARCHAR(32)  NOT NULL,
  "create_time"    TIMESTAMP(6) NOT NULL,
  "update_by"      VARCHAR(32)  NOT NULL,
  "update_time"    TIMESTAMP(6) NOT NULL,
  "address"        VARCHAR(1300),
  "email"          VARCHAR(100),
  "email_verify"   BOOL DEFAULT FALSE,
  "employee_code"  VARCHAR(20),
  "entry_time"     DATE,
  "face_file_id"   VARCHAR(32),
  "face_file_Name" VARCHAR(50),
  "id_card"        VARCHAR(50),
  "login_name"     VARCHAR(50)  NOT NULL,
  "mobile"         VARCHAR(20),
  "mobile_verify"  BOOL DEFAULT FALSE,
  "password"       VARCHAR(50)  NOT NULL,
  "sex_type"       VARCHAR(20),
  "status"         VARCHAR(20)  NOT NULL,
  "user_name"      VARCHAR(50)  NOT NULL,
  "role_type"      VARCHAR(20)  NOT NULL,
  "organize_id"    VARCHAR(32)  NOT NULL REFERENCES t_uc_organize ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
COMMENT ON TABLE t_uc_user IS '用户表';
COMMENT ON COLUMN t_uc_user.id IS '主键';
COMMENT ON COLUMN t_uc_user.address IS '地址';
COMMENT ON COLUMN t_uc_user.email IS '邮箱';
COMMENT ON COLUMN t_uc_user.email_verify IS '邮箱是否严验证';
COMMENT ON COLUMN t_uc_user.employee_code IS '工号';
COMMENT ON COLUMN t_uc_user.entry_time IS '入职时间';
COMMENT ON COLUMN t_uc_user.face_file_id IS '头像ID';
COMMENT ON COLUMN t_uc_user.face_file_Name IS '头像名称';
COMMENT ON COLUMN t_uc_user.id_card IS '身份证';
COMMENT ON COLUMN t_uc_user.login_name IS '用户名';
COMMENT ON COLUMN t_uc_user.mobile IS '手机号';
COMMENT ON COLUMN t_uc_user.mobile_verify IS '手机号是否验证';
COMMENT ON COLUMN t_uc_user.password IS '密码';
COMMENT ON COLUMN t_uc_user.sex_type IS '性别 MALE("男"), FEMALE("女"), SECRECY("保密")';
COMMENT ON COLUMN t_uc_user.status IS '状态 ENABLE("启用"), FORBIDDEN("冻结"), DELETED("删除")';
COMMENT ON COLUMN t_uc_user.user_name IS '姓名';
COMMENT ON COLUMN t_uc_user.role_type IS 'USER("学员"), ADMIN("管理员")';
COMMENT ON COLUMN t_uc_user.organize_id IS '部门';
CREATE INDEX "i_uc_user_corpCode"
  ON t_uc_user USING BTREE (corp_code);
CREATE INDEX "i_uc_user_employeeCode"
  ON t_uc_user USING BTREE (employee_code);
CREATE INDEX "i_uc_user_organizeId"
  ON t_uc_user USING BTREE (organize_id);
CREATE INDEX "i_uc_user_loginName"
  ON t_uc_user USING BTREE (login_name);
CREATE INDEX "i_uc_user_mobile"
  ON t_uc_user USING BTREE (mobile);
CREATE INDEX "i_uc_user_email"
  ON t_uc_user USING BTREE (email);

CREATE TABLE t_uc_user_position (
  "id"          VARCHAR(32) PRIMARY KEY,
  "corp_code"   VARCHAR(50)  NOT NULL,
  "create_by"   VARCHAR(32)  NOT NULL,
  "create_time" TIMESTAMP(6) NOT NULL,
  "update_by"   VARCHAR(32)  NOT NULL,
  "update_time" TIMESTAMP(6) NOT NULL,
  "position_id" VARCHAR(32)  NOT NULL REFERENCES "t_uc_position" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "user_id"     VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  UNIQUE ("user_id", "position_id")
);
COMMENT ON TABLE t_uc_user_position IS '用户岗位表';
COMMENT ON COLUMN t_uc_user_position.id IS '主键';
COMMENT ON COLUMN t_uc_user_position.position_id IS '岗位ID';
COMMENT ON COLUMN t_uc_user_position.user_id IS '用户ID';
CREATE INDEX "i_uc_user_position_corpcode"
  ON t_uc_user_position USING BTREE (corp_code);
CREATE INDEX "i_uc_user_position_positionid"
  ON t_uc_user_position USING BTREE (position_id);

CREATE TABLE t_uc_role (
  "id"          VARCHAR(32) PRIMARY KEY,
  "corp_code"   VARCHAR(50)  NOT NULL,
  "create_by"   VARCHAR(32)  NOT NULL,
  "create_time" TIMESTAMP(6) NOT NULL,
  "update_by"   VARCHAR(32)  NOT NULL,
  "update_time" TIMESTAMP(6) NOT NULL,
  "assign_type" VARCHAR(20),
  "comments"    VARCHAR(200),
  "role_name"   VARCHAR(50)  NOT NULL,
  "is_default"  BOOL
);
COMMENT ON TABLE t_uc_role IS '角色表';
COMMENT ON COLUMN t_uc_role.id IS '主键';
COMMENT ON COLUMN t_uc_role.assign_type IS '安排方式 PART("部分"), ALL("全部")';
COMMENT ON COLUMN t_uc_role.comments IS '备注';
COMMENT ON COLUMN t_uc_role.role_name IS '角色名称';
COMMENT ON COLUMN t_uc_role.is_default IS '是否默认';
CREATE INDEX "i_uc_role_corpCode"
  ON t_uc_role USING BTREE (corp_code);

CREATE TABLE t_uc_user_role (
  "id"          VARCHAR(32) PRIMARY KEY,
  "corp_code"   VARCHAR(50)  NOT NULL,
  "create_by"   VARCHAR(32)  NOT NULL,
  "create_time" TIMESTAMP(6) NOT NULL,
  "update_by"   VARCHAR(32)  NOT NULL,
  "update_time" TIMESTAMP(6) NOT NULL,
  "role_id"     VARCHAR(32)  NOT NULL REFERENCES "t_uc_role" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "user_id"     VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  UNIQUE ("user_id", "role_id")
);
COMMENT ON TABLE t_uc_user_role IS '用户角色表';
COMMENT ON COLUMN t_uc_user_role.id IS '主键';
COMMENT ON COLUMN t_uc_user_role.role_id IS '角色ID';
COMMENT ON COLUMN t_uc_user_role.user_id IS '用户ID';
CREATE INDEX "i_uc_user_role_corpCode"
  ON t_uc_user_role USING BTREE (corp_code);
CREATE INDEX "i_uc_user_role_roleId"
  ON t_uc_user_role USING BTREE (role_id);

CREATE TABLE t_uc_authority (
  "id"          VARCHAR(32) PRIMARY KEY,
  "corp_code"   VARCHAR(50)   NOT NULL,
  "create_by"   VARCHAR(32)   NOT NULL,
  "create_time" TIMESTAMP(6)  NOT NULL,
  "update_by"   VARCHAR(32)   NOT NULL,
  "update_time" TIMESTAMP(6)  NOT NULL,
  "id_path"     VARCHAR(1300) NOT NULL,
  "parent_id"   VARCHAR(255),
  "show_order"  FLOAT4        NOT NULL,
  "auth_name"   VARCHAR(50)   NOT NULL,
  "auth_url"    VARCHAR(1300),
  "auth_code"   VARCHAR(50)   NOT NULL,
  "comments"    VARCHAR(200)
);
COMMENT ON TABLE t_uc_authority IS '权限表';
COMMENT ON COLUMN t_uc_authority.id IS '主键';
COMMENT ON COLUMN t_uc_authority.id_path IS 'idPath';
COMMENT ON COLUMN t_uc_authority.parent_id IS '父类ID';
COMMENT ON COLUMN t_uc_authority.show_order IS '排序';
COMMENT ON COLUMN t_uc_authority.auth_name IS '权限名称';
COMMENT ON COLUMN t_uc_authority.auth_url IS '权限URL';
COMMENT ON COLUMN t_uc_authority.auth_code IS '权限编号';
COMMENT ON COLUMN t_uc_authority.comments IS '备注';
CREATE INDEX "i_uc_authority_corpcode"
  ON "t_uc_authority" USING BTREE (corp_code);
CREATE INDEX "i_uc_authority_parentid"
  ON "t_uc_authority" USING BTREE (parent_id);

CREATE TABLE t_uc_role_authority (
  "id"           VARCHAR(32) PRIMARY KEY,
  "corp_code"    VARCHAR(50)  NOT NULL,
  "create_by"    VARCHAR(32)  NOT NULL,
  "create_time"  TIMESTAMP(6) NOT NULL,
  "update_by"    VARCHAR(32)  NOT NULL,
  "update_time"  TIMESTAMP(6) NOT NULL,
  "authority_id" VARCHAR(32)  NOT NULL REFERENCES "t_uc_authority" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "role_id"      VARCHAR(32)  NOT NULL REFERENCES "t_uc_role" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  UNIQUE ("role_id", "authority_id")
);
COMMENT ON TABLE t_uc_role_authority IS '角色权限表';
COMMENT ON COLUMN t_uc_role_authority.id IS '主键';
COMMENT ON COLUMN t_uc_role_authority.authority_id IS '权限ID';
COMMENT ON COLUMN t_uc_role_authority.role_id IS '角色ID';
CREATE INDEX "i_uc_role_authority_authorityId"
  ON "t_uc_role_authority" USING BTREE (authority_id);
CREATE INDEX "i_uc_role_authority_corpCode"
  ON "t_uc_role_authority" USING BTREE (corp_code);

CREATE TABLE t_ems_item_bank (
  "id"          VARCHAR(32) PRIMARY KEY,
  "corp_code"   VARCHAR(50)  NOT NULL,
  "create_by"   VARCHAR(32)  NOT NULL,
  "create_time" TIMESTAMP(6) NOT NULL,
  "update_by"   VARCHAR(32)  NOT NULL,
  "update_time" TIMESTAMP(6) NOT NULL,
  "bank_name"   VARCHAR(50)  NOT NULL,
  "category_id" VARCHAR(32)  NOT NULL REFERENCES "t_pe_category" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "bank_status" VARCHAR(20)  NOT NULL
);
COMMENT ON TABLE "t_ems_item_bank" IS '题库表';
COMMENT ON COLUMN t_ems_item_bank.id IS '主键';
COMMENT ON COLUMN t_ems_item_bank.bank_name IS '题库名称';
COMMENT ON COLUMN t_ems_item_bank.category_id IS '类别ID';
COMMENT ON COLUMN t_ems_item_bank.bank_status IS '题库状态';
CREATE INDEX "i_ems_item_bank_categoryId"
  ON "t_ems_item_bank" USING BTREE (category_id);
CREATE INDEX "i_ems_item_bank_corpCode"
  ON "t_ems_item_bank" USING BTREE (corp_code);

CREATE TABLE t_ems_item_bank_auth (
  "id"          VARCHAR(32) PRIMARY KEY,
  "corp_code"   VARCHAR(50)  NOT NULL,
  "create_by"   VARCHAR(32)  NOT NULL,
  "create_time" TIMESTAMP(6) NOT NULL,
  "update_by"   VARCHAR(32)  NOT NULL,
  "update_time" TIMESTAMP(6) NOT NULL,
  "can_edit"    BOOL DEFAULT FALSE,
  "bank_id"     VARCHAR(32)  NOT NULL REFERENCES "t_ems_item_bank" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "user_id"     VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  UNIQUE ("bank_id", "user_id")
);
COMMENT ON TABLE "t_ems_item_bank_auth" IS '题库授权表';
COMMENT ON COLUMN t_ems_item_bank_auth.id IS '主键';
COMMENT ON COLUMN t_ems_item_bank_auth.can_edit IS '是否有编辑权限';
COMMENT ON COLUMN t_ems_item_bank_auth.bank_id IS '题库ID';
COMMENT ON COLUMN t_ems_item_bank_auth.user_id IS '人员ID';
CREATE INDEX "i_ems_item_bank_auth_userId"
  ON "t_ems_item_bank_auth" USING BTREE (user_id);
CREATE INDEX "i_ems_item_bank_auth_corpCode"
  ON "t_ems_item_bank_auth" USING BTREE (corp_code);

CREATE TABLE t_ems_item_detail (
  "id"          VARCHAR(32) PRIMARY KEY,
  "corp_code"   VARCHAR(50)  NOT NULL,
  "create_by"   VARCHAR(32)  NOT NULL,
  "create_time" TIMESTAMP(6) NOT NULL,
  "update_by"   VARCHAR(32)  NOT NULL,
  "update_time" TIMESTAMP(6) NOT NULL,
  "item_detail" TEXT         NOT NULL
);
COMMENT ON TABLE "t_ems_item_detail" IS '试题详情表';
COMMENT ON COLUMN t_ems_item_detail.id IS '主键';
COMMENT ON COLUMN t_ems_item_detail.item_detail IS '试题详情包含题干选项答案';
CREATE INDEX "i_ems_item_detail_corpCode"
  ON "t_ems_item_detail" USING BTREE (corp_code);

CREATE TABLE "t_ems_simulationExam" (
  "id"           VARCHAR(32) PRIMARY KEY,
  "corp_code"    VARCHAR(50)  NOT NULL,
  "create_by"    VARCHAR(32)  NOT NULL,
  "create_time"  TIMESTAMP(6) NOT NULL,
  "update_by"    VARCHAR(32)  NOT NULL,
  "update_time"  TIMESTAMP(6) NOT NULL,
  "end_time"     TIMESTAMP(6),
  "simulationExam_code"    VARCHAR(50)  NOT NULL,
  "exam_name"    VARCHAR(100) NOT NULL,
  "exam_plain"   VARCHAR(1300),
  "publish_time" TIMESTAMP(6),
 "exam_setting" VARCHAR(500),
  "status"       VARCHAR(20)  NOT NULL,
  "subject"      BOOL         NOT NULL,
  "template_id"  VARCHAR(32) REFERENCES "t_ems_paper_template" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "source"       VARCHAR(20),
  "mark_up_id"   VARCHAR(32),
  UNIQUE ("corp_code", "simulationExam_code")
);

CREATE TABLE "t_ems_item" (
  "id"                 VARCHAR(32) PRIMARY KEY,
  "corp_code"          VARCHAR(50)  NOT NULL,
  "create_by"          VARCHAR(32)  NOT NULL,
  "create_time"        TIMESTAMP(6) NOT NULL,
  "update_by"          VARCHAR(32)  NOT NULL,
  "update_time"        TIMESTAMP(6) NOT NULL,
  "expire_date"        DATE         NOT NULL,
  "security"           BOOL         NOT NULL DEFAULT FALSE,
  "item_code"          VARCHAR(50)  NOT NULL,
  "language_type"      VARCHAR(20)  NOT NULL DEFAULT 'CHINESE',
  "level"              VARCHAR(20)  NOT NULL DEFAULT 'MEDIUM',
  "mark"               FLOAT8       NOT NULL,
  "score_rate"         FLOAT8,
  "score_setting_type" VARCHAR(20),
  "status"             VARCHAR(20)  NOT NULL DEFAULT 'DRAFT',
  "stem_outline"       VARCHAR(50)  NOT NULL,
  "type"               VARCHAR(20)  NOT NULL DEFAULT 'SINGLE_SELECTION',
  "bank_id"            VARCHAR(32)  NOT NULL REFERENCES "t_ems_item_bank" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "detail_id"          VARCHAR(32)  NOT NULL REFERENCES "t_ems_item_detail" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "attribute_type"    VARCHAR(20),
  UNIQUE ("corp_code", "item_code"),
  UNIQUE ("detail_id")
);
COMMENT ON TABLE "t_ems_item" IS '试题表';
COMMENT ON COLUMN t_ems_item.id IS '主键';
COMMENT ON COLUMN t_ems_item.expire_date IS '过期时间';
COMMENT ON COLUMN t_ems_item.security IS '是否保密';
COMMENT ON COLUMN t_ems_item.item_code IS '试题编号';
COMMENT ON COLUMN t_ems_item.language_type IS '语言：CHINESE("中文"), ENGLISH("英文"), TRADITIONAL_CHINESE("繁体中文"), JAPANESE("日文"), KOREAN("韩语")';
COMMENT ON COLUMN t_ems_item.level IS '等级SIMPLE("简单"), RELATIVELY_SIMPLE("较简单"), MEDIUM("中等"), MORE_DIFFICULT("较难"), DIFFICULT("困难")';
COMMENT ON COLUMN t_ems_item.mark IS '分数';
COMMENT ON COLUMN t_ems_item.score_rate IS '分率';
COMMENT ON COLUMN t_ems_item.score_setting_type IS '得分设置,用于多选题选中部分选项的得分:ALL("全部分值"), PART("部分分值")';
COMMENT ON COLUMN t_ems_item.status IS '状态:DRAFT("草稿"), ENABLE("启用"), DISABLE("停用"), DELETE("彻底删除")';
COMMENT ON COLUMN t_ems_item.stem_outline IS '题干前50字';
COMMENT ON COLUMN t_ems_item.type IS '类型SINGLE_SELECTION("单选题"), MULTI_SELECTION("多选题"), INDEFINITE_SELECTION("不定项选择"), JUDGMENT("判断题"), FILL("填空题"), QUESTIONS("问答题")';
COMMENT ON COLUMN t_ems_item.bank_id IS '题库ID';
COMMENT ON COLUMN t_ems_item.detail_id IS '详情ID';
CREATE INDEX "i_ems_item_blankId"
  ON "t_ems_item" USING BTREE (bank_id);
CREATE INDEX "i_ems_item_itemCode"
  ON "t_ems_item" USING BTREE (item_code);
CREATE INDEX "i_ems_item_createBy"
  ON "t_ems_item" USING BTREE (create_by);

CREATE TABLE "t_ems_knowledge" (
  "id"               VARCHAR(32) PRIMARY KEY,
  "corp_code"        VARCHAR(50)  NOT NULL,
  "create_by"        VARCHAR(32)  NOT NULL,
  "create_time"      TIMESTAMP(6) NOT NULL,
  "update_by"        VARCHAR(32)  NOT NULL,
  "update_time"      TIMESTAMP(6) NOT NULL,
  "knowledge_name"   VARCHAR(50)  NOT NULL,
  "category_id"      VARCHAR(32)  NOT NULL REFERENCES "t_pe_category" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "knowledge_status" VARCHAR(20)  NOT NULL
);
COMMENT ON TABLE "t_ems_knowledge" IS '知识点表';
COMMENT ON COLUMN t_ems_knowledge.id IS '主键';
COMMENT ON COLUMN t_ems_knowledge.knowledge_name IS '知识点名称';
COMMENT ON COLUMN t_ems_knowledge.category_id IS '类别ID';
COMMENT ON COLUMN t_ems_knowledge.knowledge_status IS '状态';
CREATE INDEX "i_ems_knowledge_categoryid"
  ON "t_ems_knowledge" USING BTREE (category_id);

CREATE TABLE "t_ems_knowledge_item" (
  "id"           VARCHAR(32) PRIMARY KEY,
  "corp_code"    VARCHAR(50)  NOT NULL,
  "create_by"    VARCHAR(32)  NOT NULL,
  "create_time"  TIMESTAMP(6) NOT NULL,
  "update_by"    VARCHAR(32)  NOT NULL,
  "update_time"  TIMESTAMP(6) NOT NULL,
  "item_id"      VARCHAR(32)  NOT NULL REFERENCES "t_ems_item" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "knowledge_id" VARCHAR(32)  NOT NULL REFERENCES "t_ems_knowledge" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  UNIQUE ("knowledge_id", "item_id")
);
COMMENT ON TABLE "t_ems_knowledge_item" IS '知识题库表';
COMMENT ON COLUMN t_ems_knowledge_item.id IS '主键';
COMMENT ON COLUMN t_ems_knowledge_item.knowledge_id IS '知识点ID';
COMMENT ON COLUMN t_ems_knowledge_item.item_id IS '题库ID';
CREATE INDEX "i_ems_knowledge_item_corpCode"
  ON "t_ems_knowledge_item" USING BTREE (corp_code);
CREATE INDEX "i_ems_knowledge_item_itemId"
  ON "t_ems_knowledge_item" USING BTREE (item_id);

CREATE TABLE "t_ems_paper_template" (
  "id"           VARCHAR(32) PRIMARY KEY,
  "corp_code"    VARCHAR(50)  NOT NULL,
  "create_by"    VARCHAR(32)  NOT NULL,
  "create_time"  TIMESTAMP(6) NOT NULL,
  "update_by"    VARCHAR(32)  NOT NULL,
  "update_time"  TIMESTAMP(6) NOT NULL,
  "security"     BOOL DEFAULT FALSE,
  "paper_code"   VARCHAR(50)  NOT NULL,
  "paper_name"   VARCHAR(50)  NOT NULL,
  "paper_status" VARCHAR(20)  NOT NULL,
  "paper_type"   VARCHAR(20)  NOT NULL,
  "strategy"     VARCHAR(500),
  "category_id"  VARCHAR(32)  NOT NULL REFERENCES "t_pe_category" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  UNIQUE ("corp_code", "paper_code")
);
COMMENT ON TABLE "t_ems_paper_template" IS '试卷模板表';
COMMENT ON COLUMN t_ems_paper_template.id IS '主键';
COMMENT ON COLUMN t_ems_paper_template.security IS '是否绝密';
COMMENT ON COLUMN t_ems_paper_template.paper_code IS '试卷编号';
COMMENT ON COLUMN t_ems_paper_template.paper_name IS '试卷名称';
COMMENT ON COLUMN t_ems_paper_template.paper_status IS '状态：ENABLE("启用"), DISABLE("停用"), DRAFT("草稿")';
COMMENT ON COLUMN t_ems_paper_template.paper_type IS '试卷模板类型：FIXED("固定"), RANDOM("随机")';
COMMENT ON COLUMN t_ems_paper_template.strategy IS '随机卷组卷策略JSONB';
COMMENT ON COLUMN t_ems_paper_template.category_id IS '类别ID';
CREATE INDEX "i_ems_paper_template_paperCode"
  ON "t_ems_paper_template" USING BTREE (paper_code);
CREATE INDEX "i_ems_paper_template_createBy"
  ON "t_ems_paper_template" USING BTREE (create_by);
CREATE INDEX "i_ems_paper_template_categoryId"
  ON "t_ems_paper_template" USING BTREE (category_id);

CREATE TABLE "t_ems_paper_template_auth" (
  "id"          VARCHAR(32) PRIMARY KEY,
  "corp_code"   VARCHAR(50)  NOT NULL,
  "create_by"   VARCHAR(32)  NOT NULL,
  "create_time" TIMESTAMP(6) NOT NULL,
  "update_by"   VARCHAR(32)  NOT NULL,
  "update_time" TIMESTAMP(6) NOT NULL,
  "template_id" VARCHAR(32)  NOT NULL REFERENCES "t_ems_paper_template" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "user_id"     VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  UNIQUE ("template_id", "user_id")
);
COMMENT ON TABLE "t_ems_paper_template_auth" IS '试卷模板授权表';
COMMENT ON COLUMN t_ems_paper_template_auth.id IS '主键';
COMMENT ON COLUMN t_ems_paper_template_auth.template_id IS '模板ID';
COMMENT ON COLUMN t_ems_paper_template_auth.user_id IS '用户ID';
CREATE INDEX "t_ems_paper_template_auth_corpCode"
  ON "t_ems_paper_template_auth" USING BTREE (corp_code);
CREATE INDEX "t_ems_paper_template_auth_userId"
  ON "t_ems_paper_template_auth" USING BTREE (user_id);

CREATE TABLE "t_ems_paper_template_item" (
  "id"          VARCHAR(32) PRIMARY KEY,
  "corp_code"   VARCHAR(50)  NOT NULL,
  "create_by"   VARCHAR(32)  NOT NULL,
  "create_time" TIMESTAMP(6) NOT NULL,
  "update_by"   VARCHAR(32)  NOT NULL,
  "update_time" TIMESTAMP(6) NOT NULL,
  "show_order"  FLOAT8       NOT NULL,
  "item_id"     VARCHAR(32)  NOT NULL REFERENCES "t_ems_item" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "template_id" VARCHAR(32)  NOT NULL REFERENCES "t_ems_paper_template" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  UNIQUE ("template_id", "item_id")
);
COMMENT ON TABLE "t_ems_paper_template_item" IS '模板必考题关联表';
COMMENT ON COLUMN t_ems_paper_template_item.id IS '主键';
COMMENT ON COLUMN t_ems_paper_template_item.template_id IS '模板ID';
COMMENT ON COLUMN t_ems_paper_template_item.item_id IS '试题ID';
COMMENT ON COLUMN t_ems_paper_template_item.show_order IS '排序';
CREATE INDEX "i_ems_paper_template_item_corpCode"
  ON "t_ems_paper_template_item" USING BTREE (corp_code);
CREATE INDEX "i_ems_paper_template_item_itemId"
  ON "t_ems_paper_template_item" USING BTREE (item_id);

CREATE TABLE "t_ems_paper_template_strategy" (
  "id"            VARCHAR(32) PRIMARY KEY,
  "corp_code"     VARCHAR(50)  NOT NULL,
  "create_by"     VARCHAR(32)  NOT NULL,
  "create_time"   TIMESTAMP(6) NOT NULL,
  "update_by"     VARCHAR(32)  NOT NULL,
  "update_time"   TIMESTAMP(6) NOT NULL,
  "object_id"     VARCHAR(32)  NOT NULL,
  "strategy_type" VARCHAR(20)  NOT NULL,
  "template_id"   VARCHAR(32)  NOT NULL,
  UNIQUE ("template_id", "object_id")
);
COMMENT ON TABLE "t_ems_paper_template_strategy" IS '组卷策略题库知识点关联表';
COMMENT ON COLUMN t_ems_paper_template_strategy.id IS '主键';
COMMENT ON COLUMN t_ems_paper_template_strategy.template_id IS '模板ID';
COMMENT ON COLUMN t_ems_paper_template_strategy.object_id IS '题库ID、知识点ID';
COMMENT ON COLUMN t_ems_paper_template_strategy.strategy_type IS '类型:ITEM_BANK("题库"), KNOWLEDGE("知识点")';
CREATE INDEX "i_ems_paper_template_strategy_corpCode"
  ON "t_ems_paper_template_strategy" USING BTREE (corp_code);
CREATE INDEX "i_ems_paper_template_strategy_createBy"
  ON "t_ems_paper_template_strategy" USING BTREE (create_by);
CREATE INDEX "i_ems_paper_template_strategy_objectId"
  ON "t_ems_paper_template_strategy" USING BTREE (object_id);
-- 考试
CREATE TABLE "t_ems_exam" (
  "id"            VARCHAR(32) PRIMARY KEY,
  "corp_code"     VARCHAR(50)  NOT NULL,
  "create_by"     VARCHAR(32)  NOT NULL,
  "create_time"   TIMESTAMP(6) NOT NULL,
  "update_by"     VARCHAR(32)  NOT NULL,
  "update_time"   TIMESTAMP(6) NOT NULL,
  "end_time"      TIMESTAMP(6),
  "exam_code"     VARCHAR(50)  NOT NULL,
  "exam_name"     VARCHAR(100) NOT NULL,
  "exam_plain"    VARCHAR(1300),
  "exam_type"     VARCHAR(20)  NOT NULL,
  "publish_time"  TIMESTAMP(6),
  "start_time"    TIMESTAMP(6),
  "status"        VARCHAR(20)  NOT NULL,
  "subject"       BOOL         NOT NULL,
  "template_id"   VARCHAR(32) REFERENCES "t_ems_paper_template" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "source"        VARCHAR(20),
  "mark_up_id"    VARCHAR(32),
  "enable_ticket" BOOL,
  UNIQUE ("corp_code", "exam_code")
);
CREATE INDEX "i_ems_exam_corpCode"
  ON "t_ems_exam" USING BTREE (corp_code);
CREATE INDEX "i_ems_exam_createBy"
  ON "t_ems_exam" USING BTREE (create_by);
CREATE INDEX "i_ems_exam_examCode"
  ON "t_ems_exam" USING BTREE (exam_code);
CREATE INDEX "i_ems_exam_referId"
  ON "t_ems_exam" USING BTREE (mark_up_id);
CREATE INDEX "i_ems_exam_templateId"
  ON "t_ems_exam" USING BTREE (template_id);
COMMENT ON TABLE "t_ems_exam" IS '考试表';
COMMENT ON COLUMN t_ems_exam.id IS '主键';
COMMENT ON COLUMN t_ems_exam.end_time IS '结束时间';
COMMENT ON COLUMN t_ems_exam.exam_code IS '考试编号';
COMMENT ON COLUMN t_ems_exam.exam_name IS '考试名称';
COMMENT ON COLUMN t_ems_exam.exam_plain IS '解释';
COMMENT ON COLUMN t_ems_exam.exam_type IS '考试类型ONLINE("线上考试"), OFFLINE("线下考试"), COMPREHENSIVE("综合考试")';
COMMENT ON COLUMN t_ems_exam.publish_time IS '发布时间';
COMMENT ON COLUMN t_ems_exam.start_time IS '开始时间';
COMMENT ON COLUMN t_ems_exam.status IS '状态DRAFT("草稿")ENABLE("启用")CANCEL("已作废")';
COMMENT ON COLUMN t_ems_exam.subject IS '是否科目';
COMMENT ON COLUMN t_ems_exam.template_id IS '模板ID';
COMMENT ON COLUMN t_ems_exam.source IS '来源COPY("复制")EXAM_COPY("启用复制")ADD("新建")';
COMMENT ON COLUMN t_ems_exam.mark_up_id IS '补考来源ID';
COMMENT ON COLUMN t_ems_exam.enable_ticket IS '是否启用准考证';

CREATE TABLE "t_ems_exam_arrange" (
  "id"                   VARCHAR(32) PRIMARY KEY,
  "corp_code"            VARCHAR(50)  NOT NULL,
  "create_by"            VARCHAR(32)  NOT NULL,
  "create_time"          TIMESTAMP(6) NOT NULL,
  "update_by"            VARCHAR(32)  NOT NULL,
  "update_time"          TIMESTAMP(6) NOT NULL,
  "batch_name"           VARCHAR(50),
  "end_time"             TIMESTAMP(6),
  "show_order"           FLOAT4       NOT NULL,
  "start_time"           TIMESTAMP(6),
  "status"               VARCHAR(20)  NOT NULL,
  "exam_subject_setting" VARCHAR(500),
  "exam_id"              VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "subject_id"           VARCHAR(32) REFERENCES "t_ems_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "mark_up_type"         VARCHAR(50)
);

CREATE INDEX "i_ems_exam_arrange_corpCode"
  ON "t_ems_exam_arrange" USING BTREE (corp_code);
CREATE INDEX "i_ems_exam_arrange_createBy"
  ON "t_ems_exam_arrange" USING BTREE (create_by);
CREATE INDEX "i_ems_exam_arrange_examId"
  ON "t_ems_exam_arrange" USING BTREE (exam_id);
COMMENT ON TABLE "t_ems_exam_arrange" IS '考试安排表';
COMMENT ON COLUMN t_ems_exam_arrange.id IS '主键';
COMMENT ON COLUMN t_ems_exam_arrange.batch_name IS '批次名称';
COMMENT ON COLUMN t_ems_exam_arrange.end_time IS '结束时间';
COMMENT ON COLUMN t_ems_exam_arrange.show_order IS '排序';
COMMENT ON COLUMN t_ems_exam_arrange.start_time IS '开始时间';
COMMENT ON COLUMN t_ems_exam_arrange.status IS '状态';
COMMENT ON COLUMN t_ems_exam_arrange.exam_subject_setting IS '科目设置';
COMMENT ON COLUMN t_ems_exam_arrange.exam_id IS '考试ID';
COMMENT ON COLUMN t_ems_exam_arrange.subject_id IS '科目ID';
COMMENT ON COLUMN t_ems_exam_arrange.mark_up_type IS 'NO_PASS("未通过"),MISS_EXAM("缺考")';

CREATE TABLE "t_ems_exam_auth" (
  "id"          VARCHAR(32) PRIMARY KEY,
  "corp_code"   VARCHAR(50)  NOT NULL,
  "create_by"   VARCHAR(32)  NOT NULL,
  "create_time" TIMESTAMP(6) NOT NULL,
  "update_by"   VARCHAR(32)  NOT NULL,
  "update_time" TIMESTAMP(6) NOT NULL,
  "refer_type"  VARCHAR(20) NOT NULL,
  "arrange_id"  VARCHAR(32) REFERENCES "t_ems_exam_arrange" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "show_order"  FLOAT4,
  "exam_id"     VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "user_id"     VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX "i_ems_exam_auth_corpCode"
  ON "t_ems_exam_auth" USING BTREE (corp_code);
CREATE INDEX "i_ems_exam_auth_createBy"
  ON "t_ems_exam_auth" USING BTREE (create_by);
CREATE INDEX "i_ems_exam_auth_examId"
  ON "t_ems_exam_auth" USING BTREE (exam_id);
CREATE INDEX "i_ems_exam_auth_userId"
  ON "t_ems_exam_auth" USING BTREE (user_id);
COMMENT ON TABLE "t_ems_exam_auth" IS '考试授权表';
COMMENT ON COLUMN t_ems_exam_auth.id IS '主键';
COMMENT ON COLUMN t_ems_exam_auth.show_order IS '序号';
COMMENT ON COLUMN t_ems_exam_auth.exam_id IS '考试ID';
COMMENT ON COLUMN t_ems_exam_auth.user_id IS '用户ID';
COMMENT ON COLUMN t_ems_exam_auth.arrange_id IS '批次id';
COMMENT ON COLUMN t_ems_exam_auth.refer_type IS 'MONITOR_USER("监考员")，(EXAM_USER("考试管理员"))';

CREATE TABLE "t_ems_paper" (
  "id"                VARCHAR(32) PRIMARY KEY,
  "corp_code"         VARCHAR(50)  NOT NULL,
  "create_by"         VARCHAR(32)  NOT NULL,
  "create_time"       TIMESTAMP(6) NOT NULL,
  "update_by"         VARCHAR(32)  NOT NULL,
  "update_time"       TIMESTAMP(6) NOT NULL,
  "item_count"        INT4,
  "level"             VARCHAR(20)  NOT NULL,
  "mark"              FLOAT8,
  "paper_content"     TEXT         NOT NULL,
  "paper_strategy"    TEXT,
  "exam_id"           VARCHAR(32) REFERENCES "t_ems_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "paper_template_id" VARCHAR(32) REFERENCES "t_ems_paper_template" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX "i_ems_paper_corpCode"
  ON "t_ems_paper" USING BTREE (corp_code);
CREATE INDEX "i_ems_paper_createBy"
  ON "t_ems_paper" USING BTREE (create_by);
COMMENT ON TABLE "t_ems_paper" IS '试卷表';
COMMENT ON COLUMN t_ems_paper.id IS '主键';
COMMENT ON COLUMN t_ems_paper.item_count IS '试题数量';
COMMENT ON COLUMN t_ems_paper.level IS '试题等级';
COMMENT ON COLUMN t_ems_paper.mark IS '试题总分';
COMMENT ON COLUMN t_ems_paper.paper_content IS '试卷试题';
COMMENT ON COLUMN t_ems_paper.exam_id IS '考试';
COMMENT ON COLUMN t_ems_paper.paper_template_id IS '试卷模板ID';
COMMENT ON COLUMN t_ems_paper.paper_strategy IS '试卷生成组卷策略';

CREATE TABLE "t_ems_exam_result" (
  "id"             VARCHAR(32) PRIMARY KEY,
  "corp_code"      VARCHAR(50)  NOT NULL,
  "create_by"      VARCHAR(32)  NOT NULL,
  "create_time"    TIMESTAMP(6) NOT NULL,
  "update_by"      VARCHAR(32)  NOT NULL,
  "update_time"    TIMESTAMP(6) NOT NULL,
  "exam_count"     INT4         NOT NULL,
  "judge_flag"     VARCHAR(20)  NOT NULL,
  "judge_time"     TIMESTAMP(6),
  "total_score"    FLOAT8,
  "exam_id"        VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "user_id"        VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "score"          FLOAT8,
  "first_score"    FLOAT8,
  "need_make_up"   BOOL,
  "pass"           BOOL,
  "publish_time"   TIMESTAMP(6),
  "paper_id"       VARCHAR(32) REFERENCES "t_ems_paper" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "start_time"     TIMESTAMP(6),
  "end_time"       TIMESTAMP(6),
  "last_result_id" VARCHAR(32),
  "mark_exam_id"   VARCHAR(32) REFERENCES "t_ems_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "arrange_id"     VARCHAR(32) REFERENCES "t_ems_exam_arrange" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "status"         VARCHAR(20)  NOT NULL,
  UNIQUE ("exam_id", "user_id")
);
CREATE INDEX "i_ems_exam_result_corpCode"
  ON "t_ems_exam_result" USING BTREE (corp_code);
CREATE INDEX "i_ems_exam_result_examId"
  ON "t_ems_exam_result" USING BTREE (exam_id);
CREATE INDEX "i_ems_exam_result_userId"
  ON "t_ems_exam_result" USING BTREE (user_id);
CREATE INDEX "i_ems_exam_result_lastResultId"
  ON "t_ems_exam_result" USING BTREE (last_result_id);
CREATE INDEX "i_ems_exam_result_markExamId"
  ON "t_ems_exam_result" USING BTREE (mark_exam_id);
CREATE INDEX "i_ems_exam_result_arrangeId"
  ON "t_ems_exam_result" USING BTREE (arrange_id);
COMMENT ON TABLE "t_ems_exam_result" IS '考试结果表';
COMMENT ON COLUMN t_ems_exam_result.id IS '主键';
COMMENT ON COLUMN t_ems_exam_result.exam_count IS '考试次数';
COMMENT ON COLUMN t_ems_exam_result.judge_flag IS '最后一次考试的评卷类型AUTO("自动评卷"), MANUAL("手动评卷")';
COMMENT ON COLUMN t_ems_exam_result.judge_time IS '最后一次考试的评卷时间';
COMMENT ON COLUMN t_ems_exam_result.total_score IS '最后一次考试的试卷总分';
COMMENT ON COLUMN t_ems_exam_result.exam_id IS '考试ID';
COMMENT ON COLUMN t_ems_exam_result.user_id IS '学员ID';
COMMENT ON COLUMN t_ems_exam_result.score IS '最后一次考试的考试真实成绩';
COMMENT ON COLUMN t_ems_exam_result.first_score IS '首次成绩';
COMMENT ON COLUMN t_ems_exam_result.need_make_up IS '是否需要补考:学员交卷，后台评卷 直接给出，主要针对补考类考试';
COMMENT ON COLUMN t_ems_exam_result.pass IS '是否通过';
COMMENT ON COLUMN t_ems_exam_result.publish_time IS '发布时间';
COMMENT ON COLUMN t_ems_exam_result.start_time IS '考试开始时间';
COMMENT ON COLUMN t_ems_exam_result.end_time IS '考试结束时间';
COMMENT ON COLUMN t_ems_exam_result.last_result_id IS '最后考试结果ID';
COMMENT ON COLUMN t_ems_exam_result.mark_exam_id IS '补考考试ID';
COMMENT ON COLUMN t_ems_exam_result.arrange_id IS '安排ID';
COMMENT ON COLUMN t_ems_exam_result.status IS '状态';

CREATE TABLE "t_ems_exam_result_detail" (
  "id"           VARCHAR(32) PRIMARY KEY,
  "corp_code"    VARCHAR(50)  NOT NULL,
  "create_by"    VARCHAR(32)  NOT NULL,
  "create_time"  TIMESTAMP(6) NOT NULL,
  "update_by"    VARCHAR(32)  NOT NULL,
  "update_time"  TIMESTAMP(6) NOT NULL,
  "exam_count"   INT4         NOT NULL,
  "judge_flag"   VARCHAR(20)  NOT NULL,
  "score"        FLOAT8,
  "total_score"  FLOAT8,
  "exam_id"      VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "paper_id"     VARCHAR(32)  NOT NULL REFERENCES "t_ems_paper" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "user_id"      VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "start_time"   TIMESTAMP(6) NOT NULL,
  "end_time"     TIMESTAMP(6) NOT NULL,
  "pass"         BOOL,
  "mark_exam_id" VARCHAR(32) REFERENCES "t_ems_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "result_id"    VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam_result" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE INDEX "i_ems_exam_result_detail_corpCode"
  ON "t_ems_exam_result_detail" USING BTREE (corp_code);
CREATE INDEX "i_ems_exam_result_detail_examId"
  ON "t_ems_exam_result_detail" USING BTREE (exam_id);
CREATE INDEX "i_ems_exam_result_detail_userId"
  ON "t_ems_exam_result_detail" USING BTREE (user_id);
CREATE INDEX "i_ems_exam_result_detail_markExamId"
  ON "t_ems_exam_result_detail" USING BTREE (mark_exam_id);
CREATE INDEX "i_ems_exam_result_detail_paperId"
  ON "t_ems_exam_result_detail" USING BTREE (paper_id);
COMMENT ON TABLE "t_ems_exam_result_detail" IS '考试结果详情表';
COMMENT ON COLUMN t_ems_exam_result_detail.id IS '主键';
COMMENT ON COLUMN t_ems_exam_result_detail.exam_count IS '当前次数';
COMMENT ON COLUMN t_ems_exam_result_detail.judge_flag IS '评卷标志';
COMMENT ON COLUMN t_ems_exam_result_detail.score IS '分数';
COMMENT ON COLUMN t_ems_exam_result_detail.total_score IS '总分';
COMMENT ON COLUMN t_ems_exam_result_detail.start_time IS '考试开始时间';
COMMENT ON COLUMN t_ems_exam_result_detail.end_time IS '考试结束时间';
COMMENT ON COLUMN t_ems_exam_result_detail.mark_exam_id IS '补考ID';
COMMENT ON COLUMN t_ems_exam_result_detail.result_id IS '结果ID';

CREATE TABLE "t_ems_exam_setting" (
  "id"              VARCHAR(32) PRIMARY KEY,
  "corp_code"       VARCHAR(50)  NOT NULL,
  "create_by"       VARCHAR(32)  NOT NULL,
  "create_time"     TIMESTAMP(6) NOT NULL,
  "update_by"       VARCHAR(32)  NOT NULL,
  "update_time"     TIMESTAMP(6) NOT NULL,
  "exam_auth_type"  VARCHAR(20),
  "exam_setting"    VARCHAR(500),
  "judge_setting"   VARCHAR(500),
  "message_setting" VARCHAR(500),
  "prevent_setting" VARCHAR(500),
  "rank_setting"    VARCHAR(500),
  "score_setting"   VARCHAR(500) NOT NULL,
  "exam_id"         VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  UNIQUE ("corp_code", "exam_id")
);
CREATE INDEX "i_ems_exam_setting_createBy"
  ON "t_ems_exam_setting" USING BTREE (create_by);
CREATE INDEX "i_ems_exam_setting_examId"
  ON "t_ems_exam_setting" USING BTREE (exam_id);
COMMENT ON TABLE "t_ems_exam_setting" IS '考试设置表';
COMMENT ON COLUMN t_ems_exam_setting.id IS '主键';
COMMENT ON COLUMN t_ems_exam_setting.exam_auth_type IS '考生权限设置';
COMMENT ON COLUMN t_ems_exam_setting.exam_setting IS '考试基本设置';
COMMENT ON COLUMN t_ems_exam_setting.judge_setting IS '评卷策略';
COMMENT ON COLUMN t_ems_exam_setting.message_setting IS '消息设置';
COMMENT ON COLUMN t_ems_exam_setting.prevent_setting IS '防舞弊设置';
COMMENT ON COLUMN t_ems_exam_setting.rank_setting IS '排行设置';
COMMENT ON COLUMN t_ems_exam_setting.score_setting IS '成绩设置';
COMMENT ON COLUMN t_ems_exam_setting.exam_id IS '考试ID';


CREATE TABLE "t_ems_exam_user" (
  "id"              VARCHAR(32) PRIMARY KEY,
  "corp_code"       VARCHAR(50)  NOT NULL,
  "create_by"       VARCHAR(32)  NOT NULL,
  "create_time"     TIMESTAMP(6) NOT NULL,
  "update_by"       VARCHAR(32)  NOT NULL,
  "update_time"     TIMESTAMP(6) NOT NULL,
  "refer_id"        VARCHAR(50)  NOT NULL,
  "refer_type"      VARCHAR(20)  NOT NULL,
  "ticket"          VARCHAR(20),
  "show_order"      FLOAT8       NOT NULL,
  "exam_id"         VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "exam_arrange_id" VARCHAR(32) REFERENCES "t_ems_exam_arrange" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX "i_ems_exam_user_corpCode"
  ON "t_ems_exam_user" USING BTREE (corp_code);
CREATE INDEX "i_ems_exam_user_examArrangeId"
  ON "t_ems_exam_user" USING BTREE (exam_arrange_id);
CREATE INDEX "i_ems_exam_user_examId"
  ON "t_ems_exam_user" USING BTREE (exam_id);
COMMENT ON TABLE "t_ems_exam_user" IS '考试安排人员表';
COMMENT ON COLUMN t_ems_exam_user.id IS '主键';
COMMENT ON COLUMN t_ems_exam_user.refer_id IS '关联ID';
COMMENT ON COLUMN t_ems_exam_user.refer_type IS '关联类型USER("用户"), ORGANIZE("组织")';
COMMENT ON COLUMN t_ems_exam_user.show_order IS '序号';
COMMENT ON COLUMN t_ems_exam_user.exam_id IS '考试ID';
COMMENT ON COLUMN t_ems_exam_user.exam_arrange_id IS '考试安排ID';
COMMENT ON COLUMN t_ems_exam_user.ticket IS '准考证号';

CREATE TABLE "t_ems_simulationExam_user" (
  "id"              VARCHAR(32) PRIMARY KEY,
  "corp_code"       VARCHAR(50)  NOT NULL,
  "create_by"       VARCHAR(32)  NOT NULL,
  "create_time"     TIMESTAMP(6) NOT NULL,
  "update_by"       VARCHAR(32)  NOT NULL,
  "update_time"     TIMESTAMP(6) NOT NULL,
  "refer_id"        VARCHAR(50)  NOT NULL,
  "refer_type"      VARCHAR(20)  NOT NULL,
  "show_order"      FLOAT8       NOT NULL,
  "simulationExam_id"         VARCHAR(32)  NOT NULL REFERENCES "t_ems_simulationExam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX "i_ems_exam_user_corpCode" ON "t_ems_simulationExam_user" USING BTREE (corp_code);
CREATE INDEX "i_ems_exam_user_examId" ON "t_ems_simulationExam_user" USING BTREE (simulationExam_id);
COMMENT ON TABLE "t_ems_simulationExam_user" IS '模拟考试安排人员表';
COMMENT ON COLUMN t_ems_simulationExam_user.id IS '主键';
COMMENT ON COLUMN t_ems_simulationExam_user.refer_id IS '关联ID';
COMMENT ON COLUMN t_ems_simulationExam_user.refer_type IS '关联类型USER("用户"), ORGANIZE("组织")';
COMMENT ON COLUMN t_ems_simulationExam_user.show_order IS '序号';
COMMENT ON COLUMN t_ems_simulationExam_user.simulationExam_id IS '考试ID';


CREATE TABLE "t_ems_judge_user" (
  "id"          VARCHAR(32) PRIMARY KEY,
  "corp_code"   VARCHAR(50)  NOT NULL,
  "create_by"   VARCHAR(32)  NOT NULL,
  "create_time" TIMESTAMP(6) NOT NULL,
  "update_by"   VARCHAR(32)  NOT NULL,
  "update_time" TIMESTAMP(6) NOT NULL,
  "rate"        FLOAT8,
  "refer_id"    VARCHAR(32)  NOT NULL,
  "refer_type"  VARCHAR(20)  NOT NULL,
  "show_order"  FLOAT4,
  "exam_id"     VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "user_id"     VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE INDEX "i_ems_judge_user_examId"
  ON "t_ems_judge_user" USING BTREE (exam_id);
CREATE INDEX "i_ems_judge_user_itemId"
  ON "t_ems_judge_user" USING BTREE (refer_id);
CREATE INDEX "i_ems_judge_user_userId"
  ON "t_ems_judge_user" USING BTREE (user_id);
CREATE INDEX "i_ems_judge_user_corpCode"
  ON "t_ems_judge_user" USING BTREE (corp_code);
COMMENT ON TABLE "t_ems_judge_user" IS '评卷关联表';
COMMENT ON COLUMN t_ems_judge_user.id IS '主键';
COMMENT ON COLUMN t_ems_judge_user.rate IS '比例';
COMMENT ON COLUMN t_ems_judge_user.refer_id IS '关联ID';
COMMENT ON COLUMN t_ems_judge_user.refer_type IS 'PAPER("试卷"), ITEM("试题")';
COMMENT ON COLUMN t_ems_judge_user.show_order IS '排序';

CREATE TABLE "t_ems_judge_user_record" (
  "id"               VARCHAR(32) PRIMARY KEY,
  "corp_code"        VARCHAR(50)  NOT NULL,
  "create_by"        VARCHAR(32)  NOT NULL,
  "create_time"      TIMESTAMP(6) NOT NULL,
  "update_by"        VARCHAR(32)  NOT NULL,
  "update_time"      TIMESTAMP(6) NOT NULL,
  "approval_type"    VARCHAR(20)  NOT NULL,
  "judge_type"       VARCHAR(20)  NOT NULL,
  "refer_id"         VARCHAR(32)  NOT NULL,
  "score"            FLOAT8       NOT NULL,
  "season"           VARCHAR(50),
  "mark_detail"      TEXT,
  "exam_id"          VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "make_user_id"     VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "user_id"          VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "result_detail_id" VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam_result_detail" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE INDEX "i_ems_judge_user_record_examId"
  ON "t_ems_judge_user_record" USING BTREE (exam_id);
CREATE INDEX "i_ems_judge_user_record_makeUserId"
  ON "t_ems_judge_user_record" USING BTREE (make_user_id);
CREATE INDEX "i_ems_judge_user_record_referId"
  ON "t_ems_judge_user_record" USING BTREE (refer_id);
CREATE INDEX "i_ems_judge_user_record_userId"
  ON "t_ems_judge_user_record" USING BTREE (user_id);
CREATE INDEX "i_ems_judge_user_record_corpCode"
  ON "t_ems_judge_user_record" USING BTREE (corp_code);
CREATE INDEX "i_ems_judge_user_record_resultDetailId"
  ON "t_ems_judge_user_record" USING BTREE (result_detail_id);
COMMENT ON TABLE "t_ems_judge_user_record" IS '评卷结果表';
COMMENT ON COLUMN t_ems_judge_user_record.id IS '主键';
COMMENT ON COLUMN t_ems_judge_user_record.approval_type IS 'MARK("评卷"), REVIEW("复评")';
COMMENT ON COLUMN t_ems_judge_user_record.judge_type IS 'PAPER("试卷"), ITEM("试题")';
COMMENT ON COLUMN t_ems_judge_user_record.refer_id IS '关联ID';
COMMENT ON COLUMN t_ems_judge_user_record.score IS '分数';
COMMENT ON COLUMN t_ems_judge_user_record.season IS '原因';
COMMENT ON COLUMN t_ems_judge_user_record.exam_id IS '考试ID';
COMMENT ON COLUMN t_ems_judge_user_record.make_user_id IS '评卷人';
COMMENT ON COLUMN t_ems_judge_user_record.user_id IS '学员';
COMMENT ON COLUMN t_ems_judge_user_record.result_detail_id IS '考试结果对应ID';
COMMENT ON COLUMN t_ems_judge_user_record.mark_detail IS '详情JSONB';

CREATE TABLE "t_ems_exam_monitor" (
  "id"               VARCHAR(32) PRIMARY KEY,
  "corp_code"        VARCHAR(50)  NOT NULL,
  "create_by"        VARCHAR(32)  NOT NULL,
  "create_time"      TIMESTAMP(6) NOT NULL,
  "update_by"        VARCHAR(32)  NOT NULL,
  "update_time"      TIMESTAMP(6) NOT NULL,
  "cut_screen_count" INT4,
  "exam_end_time"    TIMESTAMP(6) NOT NULL,
  "exam_start_time"  TIMESTAMP(6) NOT NULL,
  "exam_time"        TIMESTAMP(6),
  "force_submit"     BOOL,
  "illegal_count"    INT4,
  "duration"         FLOAT8,
  "exam_record"      TEXT,
  "exit_times"       INT4,
  "answer_status"    VARCHAR(20),
  "submit_time"      TIMESTAMP(6),
  "exam_id"          VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "user_id"          VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "arrange_id"       VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam_arrange" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "exam_image"       TEXT,
  "ticket"           VARCHAR(20),
  UNIQUE ("user_id", "exam_id")
);
CREATE INDEX "i_ems_exam_monitor_corpCode"
  ON "t_ems_exam_monitor" USING BTREE (corp_code);
CREATE INDEX "i_ems_exam_monitor_examId"
  ON "t_ems_exam_monitor" USING BTREE (exam_id);
COMMENT ON TABLE "t_ems_exam_monitor" IS '下发监控表';
COMMENT ON COLUMN t_ems_exam_monitor.id IS '主键';
COMMENT ON COLUMN t_ems_exam_monitor.cut_screen_count IS '切屏次数';
COMMENT ON COLUMN t_ems_exam_monitor.exam_end_time IS '考试结束时间';
COMMENT ON COLUMN t_ems_exam_monitor.exam_start_time IS '考试开始时间';
COMMENT ON COLUMN t_ems_exam_monitor.exam_time IS '进入考试时间';
COMMENT ON COLUMN t_ems_exam_monitor.force_submit IS '是否强制提交';
COMMENT ON COLUMN t_ems_exam_monitor.illegal_count IS '违规次数';
COMMENT ON COLUMN t_ems_exam_monitor.submit_time IS '提交时间';
COMMENT ON COLUMN t_ems_exam_monitor.duration IS '答题时长';
COMMENT ON COLUMN t_ems_exam_monitor.exam_record IS '考试记录';
COMMENT ON COLUMN t_ems_exam_monitor.exit_times IS '退出次数';
COMMENT ON COLUMN t_ems_exam_monitor.answer_status IS '答题类型NO_ANSWER("未作答"), ANSWERING("正在作答"), SUBMIT_EXAM("已交卷")';
COMMENT ON COLUMN t_ems_exam_monitor.ticket IS '准考证号';

CREATE TABLE "t_pe_system_setting" (
  "id"          VARCHAR(32) PRIMARY KEY,
  "corp_code"   VARCHAR(50)  NOT NULL,
  "create_by"   VARCHAR(32)  NOT NULL,
  "create_time" TIMESTAMP(6) NOT NULL,
  "update_by"   VARCHAR(32)  NOT NULL,
  "update_time" TIMESTAMP(6) NOT NULL,
  "system_type" VARCHAR(20)  NOT NULL,
  "message"     TEXT
);
CREATE INDEX "i_pe_system_setting_corpCode"
  ON "t_pe_system_setting" USING BTREE (corp_code);
COMMENT ON TABLE "t_pe_system_setting" IS '系统考试消息设置表';
COMMENT ON COLUMN t_pe_system_setting.id IS '主键';
COMMENT ON COLUMN t_pe_system_setting.message IS '消息设置内容';
COMMENT ON COLUMN t_pe_system_setting.system_type IS '保存的消息类型(EXAM:考试消息设置,USER:用户消息设置)';

CREATE TABLE t_ems_exam_monitor_data (
  "id"              VARCHAR(32) PRIMARY KEY,
  "corp_code"       VARCHAR(50)  NOT NULL,
  "create_by"       VARCHAR(32)  NOT NULL,
  "create_time"     TIMESTAMP(6) NOT NULL,
  "update_by"       VARCHAR(32)  NOT NULL,
  "update_time"     TIMESTAMP(6) NOT NULL,
  "arrange_id"      VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam_arrange" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "file_id"         VARCHAR(32),
  "exam_id"         VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "proctor_user_id" VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "message"         VARCHAR(500),
  "data_type"       VARCHAR(32),
  "comment"         VARCHAR(500),
  "start_time"      TIMESTAMP,
  "duration"        INT4,
  "cover_id"        VARCHAR(32)
);
COMMENT ON TABLE t_ems_exam_monitor_data IS '考试批次监控表';
COMMENT ON COLUMN t_ems_exam_monitor_data.id IS '主键';
COMMENT ON COLUMN t_ems_exam_monitor_data.arrange_id IS '批次id';
COMMENT ON COLUMN t_ems_exam_monitor_data.file_Id IS '文件ID';
COMMENT ON COLUMN t_ems_exam_monitor_data.exam_id IS '考试id';
COMMENT ON COLUMN t_ems_exam_monitor_data.proctor_user_id IS '监控人员id';
COMMENT ON COLUMN t_ems_exam_monitor_data.message IS '消息';
COMMENT ON COLUMN t_ems_exam_monitor_data.data_type IS '类型VIDEO("监控视频"), PRINTIMAGE("截屏"), MESSAGE("消息")';
COMMENT ON COLUMN t_ems_exam_monitor_data.comment IS '截图备注信息';
COMMENT ON COLUMN t_ems_exam_monitor_data.start_time IS '视频开始时间';
COMMENT ON COLUMN t_ems_exam_monitor_data.duration IS '视频时长';
COMMENT ON COLUMN t_ems_exam_monitor_data.cover_id IS '封面ID';
CREATE INDEX "i_ems_exam_monitor_data_corpCode"
  ON "t_ems_exam_monitor_data" USING BTREE (corp_code);
CREATE INDEX "i_ems_exam_monitor_data_arrangeId"
  ON "t_ems_exam_monitor_data" USING BTREE (arrange_id);
CREATE INDEX "i_ems_exam_monitor_data_fileId"
  ON "t_ems_exam_monitor_data" USING BTREE (file_Id);
CREATE INDEX "i_ems_exam_monitor_data_proctorUserId"
  ON "t_ems_exam_monitor_data" USING BTREE (proctor_user_id);
CREATE INDEX "i_ems_exam_monitor_data_examId"
  ON "t_ems_exam_monitor_data" USING BTREE (exam_id);

CREATE TABLE "t_ems_mock_exam" (
"id" varchar(32) NOT NULL PRIMARY KEY,
"corp_code" varchar(50)  NOT NULL,
"create_by" varchar(32)  NOT NULL,
"create_time" timestamp(6) NOT NULL,
"update_by" varchar(32)  NOT NULL,
"update_time" timestamp(6) NOT NULL,
"end_time" timestamp(6),
"mock_code" varchar(50)  NOT NULL,
"exam_name" varchar(100)  NOT NULL,
"publish_time" timestamp(6),
"status" varchar(20)  NOT NULL,
"template_id" varchar(32)  NOT NULL REFERENCES "public"."t_ems_paper_template" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
)

COMMENT ON TABLE "public"."t_ems_mock_exam" IS '模拟考试表';
COMMENT ON COLUMN "public"."t_ems_mock_exam"."id" IS '主键';
COMMENT ON COLUMN "public"."t_ems_mock_exam"."end_time" IS '结束时间';
COMMENT ON COLUMN "public"."t_ems_mock_exam"."mock_code" IS '考试编号';
COMMENT ON COLUMN "public"."t_ems_mock_exam"."exam_name" IS '考试名称';
COMMENT ON COLUMN "public"."t_ems_mock_exam"."publish_time" IS '启用时间';
COMMENT ON COLUMN "public"."t_ems_mock_exam"."status" IS '状态ENABLE("启用")CANCEL("已作废")';
COMMENT ON COLUMN "public"."t_ems_mock_exam"."template_id" IS '模板ID';
CREATE INDEX "i_ems_mock_corpCode" ON "public"."t_ems_mock_exam" USING btree (corp_code);
CREATE INDEX "i_ems_mock_createBy" ON "public"."t_ems_mock_exam" USING btree (create_by);
CREATE INDEX "i_ems_mock_examCode" ON "public"."t_ems_mock_exam" USING btree (mock_code);
CREATE INDEX "i_ems_mock_templateId" ON "public"."t_ems_mock_exam" USING btree (template_id);

CREATE TABLE "public"."t_ems_mock_exam_result" (
"id" varchar(32) COLLATE "default" NOT NULL  PRIMARY KEY,
"corp_code" varchar(50) COLLATE "default" NOT NULL,
"create_by" varchar(32) COLLATE "default" NOT NULL,
"create_time" timestamp(6) NOT NULL,
"update_by" varchar(32) COLLATE "default" NOT NULL,
"update_time" timestamp(6) NOT NULL,
"exam_count" int4 NOT NULL,
"total_score" float8,
"exam_id" varchar(32) COLLATE "default" NOT NULL REFERENCES "public"."t_ems_mock_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
"user_id" varchar(32) COLLATE "default" NOT NULL REFERENCES "public"."t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
"score" float8,
"highest_score" float8,
"lowest_score" float8,
"pass_count" int4,
"paper_id" varchar(32) COLLATE "default" NOT NULL REFERENCES "public"."t_ems_paper" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
"last_result_detail_id" varchar(32) COLLATE "default",
UNIQUE ("exam_id", "user_id")
)
CREATE INDEX "i_ems_mock_result_corpCode" ON "public"."t_ems_mock_exam_result" USING btree (corp_code);
CREATE INDEX "i_ems_mock_result_examId" ON "public"."t_ems_mock_exam_result" USING btree (exam_id);
CREATE INDEX "i_ems_mock_result_userId" ON "public"."t_ems_mock_exam_result" USING btree (user_id);
COMMENT ON TABLE "public"."t_ems_mock_exam_result" IS '模拟考试结果表';
COMMENT ON COLUMN "public"."t_ems_mock_exam_result"."id" IS '主键';
COMMENT ON COLUMN "public"."t_ems_mock_exam_result"."exam_count" IS '考试次数';
COMMENT ON COLUMN "public"."t_ems_mock_exam_result"."total_score" IS '最后一次考试的试卷总分';
COMMENT ON COLUMN "public"."t_ems_mock_exam_result"."exam_id" IS '考试ID';
COMMENT ON COLUMN "public"."t_ems_mock_exam_result"."user_id" IS '学员ID';
COMMENT ON COLUMN "public"."t_ems_mock_exam_result"."score" IS '最后一次考试的考试真实成绩';
COMMENT ON COLUMN "public"."t_ems_mock_exam_result"."highest_score" IS '最高成绩';
COMMENT ON COLUMN "public"."t_ems_mock_exam_result"."lowest_score" IS '最低成绩';
COMMENT ON COLUMN "public"."t_ems_mock_exam_result"."pass_count" IS '通过次数';

CREATE TABLE "public"."t_ems_mock_exam_result_detail" (
"id" varchar(32) COLLATE "default" NOT NULL PRIMARY KEY,
"corp_code" varchar(50) COLLATE "default" NOT NULL,
"create_by" varchar(32) COLLATE "default" NOT NULL,
"create_time" timestamp(6) NOT NULL,
"update_by" varchar(32) COLLATE "default" NOT NULL,
"update_time" timestamp(6) NOT NULL,
"score" float8,
"total_score" float8,
"exam_id" varchar(32) COLLATE "default" NOT NULL REFERENCES "public"."t_ems_mock_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
"paper_id" varchar(32) COLLATE "default" NOT NULL REFERENCES "public"."t_ems_paper" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
"user_id" varchar(32) COLLATE "default" NOT NULL REFERENCES "public"."t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
"pass" bool,
"result_id" varchar(32) COLLATE "default" NOT NULL REFERENCES "public"."t_ems_mock_exam_result" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
"is_over" bool
)

CREATE INDEX "i_ems_exam_result_detail_corpCode" ON "public"."t_ems_mock_exam_result_detail" USING btree (corp_code);
CREATE INDEX "i_ems_exam_result_detail_examId" ON "public"."t_ems_mock_exam_result_detail" USING btree (exam_id);
CREATE INDEX "i_ems_exam_result_detail_paperId" ON "public"."t_ems_mock_exam_result_detail" USING btree (paper_id);
CREATE INDEX "i_ems_exam_result_detail_userId" ON "public"."t_ems_mock_exam_result_detail" USING btree (user_id);
CREATE INDEX "i_ems_exam_result_resultId" ON "public"."t_ems_mock_exam_result_detail" USING btree (result_id);
COMMENT ON TABLE "public"."t_ems_mock_exam_result_detail" IS '模拟考试结果详情表';
COMMENT ON COLUMN "public"."t_ems_mock_exam_result_detail"."id" IS '主键';
COMMENT ON COLUMN "public"."t_ems_mock_exam_result_detail"."score" IS '分数';
COMMENT ON COLUMN "public"."t_ems_mock_exam_result_detail"."total_score" IS '总分';
COMMENT ON COLUMN "public"."t_ems_mock_exam_result_detail"."pass" IS '是否通过';
COMMENT ON COLUMN "public"."t_ems_mock_exam_result_detail"."result_id" IS '考试结果表的外键';

CREATE TABLE "public"."t_ems_mock_exam_user" (
"id" varchar(32) COLLATE "default" NOT NULL,
"corp_code" varchar(50) COLLATE "default" NOT NULL,
"create_by" varchar(32) COLLATE "default" NOT NULL,
"create_time" timestamp(6) NOT NULL,
"update_by" varchar(32) COLLATE "default" NOT NULL,
"update_time" timestamp(6) NOT NULL,
"refer_id" varchar(50) COLLATE "default" NOT NULL REFERENCES "public"."t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
"refer_type" varchar(20) COLLATE "default" NOT NULL,
"mock_exam_id" varchar(32) COLLATE "default" NOT NULL REFERENCES "public"."t_ems_mock_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
"show_order" float8 NOT NULL,
"paper_id" varchar(32) COLLATE "default" REFERENCES "public"."t_ems_paper" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
)

COMMENT ON TABLE "public"."t_ems_mock_exam_user" IS '模拟考试安排人员表';
COMMENT ON COLUMN "public"."t_ems_mock_exam_user"."id" IS '主键';
COMMENT ON COLUMN "public"."t_ems_mock_exam_user"."refer_id" IS '关联ID';
COMMENT ON COLUMN "public"."t_ems_mock_exam_user"."refer_type" IS '关联类型USER("用户"), ORGANIZE("组织")';
COMMENT ON COLUMN "public"."t_ems_mock_exam_user"."mock_exam_id" IS '考试ID';
CREATE INDEX "i_ems_exam_user_corpCode" ON "public"."t_ems_mock_exam_user" USING btree (corp_code);
CREATE INDEX "i_ems_exam_user_examId" ON "public"."t_ems_mock_exam_user" USING btree (mock_exam_id);
CREATE INDEX "i_ems_exam_user_paperId" ON "public"."t_ems_mock_exam_user" USING btree (paper_id);
CREATE INDEX "i_ems_exam_user_referId" ON "public"."t_ems_mock_exam_user" USING btree (refer_id);


CREATE TABLE "t_ems_mock_exam_setting" (
  "id"              VARCHAR(32) PRIMARY KEY,
  "corp_code"       VARCHAR(50)  NOT NULL,
  "create_by"       VARCHAR(32)  NOT NULL,
  "create_time"     TIMESTAMP(6) NOT NULL,
  "update_by"       VARCHAR(32)  NOT NULL,
  "update_time"     TIMESTAMP(6) NOT NULL,
  "score_setting"  VARCHAR(20) NOT NULL,
	"answerlimit"     BOOL         NOT NULL,
	"usable_range" VARCHAR(20) NOT NULL,
	"examlength"			INT4			not NULL,
	"passrate"   INT4  NOT NULL,
  "mock_exam_id"         VARCHAR(32)  NOT NULL REFERENCES "t_ems_mock_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  UNIQUE ("corp_code", "mock_exam_id")
);
CREATE INDEX "i_ems_mock_exam_setting_createBy" ON "t_ems_mock_exam_setting" USING BTREE (create_by);
CREATE INDEX "i_ems_mock_exam_setting_examId" ON "t_ems_mock_exam_setting" USING BTREE (mock_exam_id);
COMMENT ON TABLE "t_ems_mock_exam_setting" IS '模拟考试设置表';
COMMENT ON COLUMN t_ems_mock_exam_setting.id IS '主键';
COMMENT ON COLUMN t_ems_mock_exam_setting.score_setting IS '试卷分数设置';
COMMENT ON COLUMN t_ems_mock_exam_setting.usable_range IS '可用范围';
COMMENT ON COLUMN t_ems_mock_exam_setting.answerlimit IS '答案是否可见设置';
COMMENT ON COLUMN t_ems_mock_exam_setting.examlength IS '考试时长';
COMMENT ON COLUMN t_ems_mock_exam_setting.passrate IS '通过率';
COMMENT ON COLUMN t_ems_mock_exam_setting.mock_exam_id IS '模拟考试ID';

CREATE TABLE "t_ems_exam_illegal_record" (
  "id"              VARCHAR(32) PRIMARY KEY,
  "corp_code"       VARCHAR(50)  NOT NULL,
  "create_by"       VARCHAR(32)  NOT NULL,
  "create_time"     TIMESTAMP(6) NOT NULL,
  "update_by"       VARCHAR(32)  NOT NULL,
  "update_time"     TIMESTAMP(6) NOT NULL,
  "illegal_type"    VARCHAR(20)  NOT NULL,
  "illegal_content" VARCHAR(500),
  "process_user_id" VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "monitor_id"      VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam_monitor" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX "i_ems_exam_illegal_record_corpCode"
  ON "t_ems_exam_illegal_record" USING BTREE (corp_code);
CREATE INDEX "i_ems_exam_illegal_record_monitorId"
  ON "t_ems_exam_illegal_record" USING BTREE (monitor_id);
CREATE INDEX "i_ems_exam_illegal_record_processUserId"
  ON "t_ems_exam_illegal_record" USING BTREE (process_user_id);
COMMENT ON TABLE "t_ems_exam_illegal_record" IS '下发监控表';
COMMENT ON COLUMN t_ems_exam_illegal_record.id IS '主键';
COMMENT ON COLUMN t_ems_exam_illegal_record.process_user_id IS '处理人';
COMMENT ON COLUMN t_ems_exam_illegal_record.monitor_id IS '监控ID';
COMMENT ON COLUMN t_ems_exam_illegal_record.illegal_type IS '违纪类型(STATUS:状态异常,IDENTITY:身份异常,OTHER:其他)';
COMMENT ON COLUMN t_ems_exam_illegal_record.illegal_content IS '其他内容';


CREATE TABLE "t_ems_user_exam_record" (
  "id"          VARCHAR(32) PRIMARY KEY,
  "corp_code"   VARCHAR(50)  NOT NULL,
  "create_by"   VARCHAR(32)  NOT NULL,
  "create_time" TIMESTAMP(6) NOT NULL,
  "update_by"   VARCHAR(32)  NOT NULL,
  "update_time" TIMESTAMP(6) NOT NULL,
  "score"       FLOAT8,
  "total_score" FLOAT8,
  "exam_id"     VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "item_id"     VARCHAR(32)  NOT NULL REFERENCES "t_ems_item" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "user_id"     VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "answer"      TEXT,
  "sign"        BOOL,
  "paper_id"    VARCHAR(32)  NOT NULL REFERENCES "t_ems_paper" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "real_score"  FLOAT4,
  "detail_id"   VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam_result_detail" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE INDEX "i_ems_user_exam_record_corpCode"
  ON "t_ems_user_exam_record" USING BTREE (corp_code);
CREATE INDEX "i_ems_user_exam_record_examId"
  ON "t_ems_user_exam_record" USING BTREE (exam_id);
CREATE INDEX "i_ems_user_exam_record_itemId"
  ON "t_ems_user_exam_record" USING BTREE (item_id);
CREATE INDEX "i_ems_user_exam_record_userId"
  ON "t_ems_user_exam_record" USING BTREE (user_id);
CREATE INDEX "i_ems_user_exam_record_paperId"
  ON "t_ems_user_exam_record" USING BTREE (paper_id);
CREATE INDEX "i_ems_user_exam_record_detailId"
  ON "t_ems_user_exam_record" USING BTREE (detail_id);
COMMENT ON TABLE "t_ems_user_exam_record" IS '学员试题答题记录表';
COMMENT ON COLUMN t_ems_user_exam_record.id IS '主键';
COMMENT ON COLUMN t_ems_user_exam_record.id IS '主键';
COMMENT ON COLUMN t_ems_user_exam_record.score IS '折合分';
COMMENT ON COLUMN t_ems_user_exam_record.real_score IS '真实分数';
COMMENT ON COLUMN t_ems_user_exam_record.real_score IS '真实分数';
COMMENT ON COLUMN t_ems_user_exam_record.answer IS '学员答案';
COMMENT ON COLUMN t_ems_user_exam_record.sign IS '是否标记';
COMMENT ON COLUMN t_ems_user_exam_record.total_score IS '满分';

CREATE TABLE "t_pe_job" (
  "id"              VARCHAR(32) PRIMARY KEY,
  "corp_code"       VARCHAR(50)  NOT NULL,
  "create_by"       VARCHAR(32)  NOT NULL,
  "create_time"     TIMESTAMP(6) NOT NULL,
  "update_by"       VARCHAR(32)  NOT NULL,
  "update_time"     TIMESTAMP(6) NOT NULL,
  "cron_expression" VARCHAR(100) NOT NULL,
  "cycle"           BOOL,
  "execute_status"  VARCHAR(20)  NOT NULL,
  "function_code"   VARCHAR(50)  NOT NULL,
  "job_name"        VARCHAR(100),
  "source_id"       VARCHAR(32)
);

CREATE INDEX "i_pe_job_corpCode"
  ON "t_pe_job" USING BTREE (corp_code);
CREATE INDEX "i_pe_job_sourceId"
  ON "t_pe_job" USING BTREE (source_id);
COMMENT ON TABLE "t_pe_job" IS 'job表';
COMMENT ON COLUMN t_pe_job.id IS '主键';
COMMENT ON COLUMN t_pe_job.cron_expression IS '时间表达式';
COMMENT ON COLUMN t_pe_job.cycle IS '是否循环';
COMMENT ON COLUMN t_pe_job.execute_status IS '执行状态';
COMMENT ON COLUMN t_pe_job.function_code IS '编号';
COMMENT ON COLUMN t_pe_job.job_name IS '名称';
COMMENT ON COLUMN t_pe_job.source_id IS '源ID';

CREATE TABLE "t_pe_job_log" (
  "id"             VARCHAR(32) PRIMARY KEY,
  "corp_code"      VARCHAR(50)   NOT NULL,
  "create_by"      VARCHAR(32)   NOT NULL,
  "create_time"    TIMESTAMP(6)  NOT NULL,
  "update_by"      VARCHAR(32)   NOT NULL,
  "update_time"    TIMESTAMP(6)  NOT NULL,
  "execute_status" VARCHAR(20)   NOT NULL,
  "msg_detail"     VARCHAR(1300) NOT NULL,
  "job_id"         VARCHAR(32)   NOT NULL REFERENCES "t_pe_job" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE INDEX "i_pe_job_log_corpCode"
  ON "t_pe_job_log" USING BTREE (corp_code);
CREATE INDEX "i_pe_job_log_jobId"
  ON "t_pe_job_log" USING BTREE (job_id);
COMMENT ON TABLE "t_pe_job_log" IS '日志表';
COMMENT ON COLUMN t_pe_job_log.id IS '主键';
COMMENT ON COLUMN t_pe_job_log.execute_status IS '执行状态';
COMMENT ON COLUMN t_pe_job_log.msg_detail IS '详细信息';
COMMENT ON COLUMN t_pe_job_log.job_id IS '源ID';

CREATE TABLE "t_pe_message" (
  "id"          VARCHAR(32) PRIMARY KEY,
  "corp_code"   VARCHAR(50)   NOT NULL,
  "create_by"   VARCHAR(32)   NOT NULL,
  "create_time" TIMESTAMP(6)  NOT NULL,
  "update_by"   VARCHAR(32)   NOT NULL,
  "update_time" TIMESTAMP(6)  NOT NULL,
  "content"     VARCHAR(1300) NOT NULL,
  "user_id"     VARCHAR(32)   NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "is_read"     BOOL          NOT NULL
);

CREATE INDEX "i_pe_message_corpCode"
  ON "t_pe_message" USING BTREE (corp_code);
CREATE INDEX "i_pe_message_userId"
  ON "t_pe_message" USING BTREE (user_id);
COMMENT ON TABLE "t_pe_message" IS '站内信标';
COMMENT ON COLUMN t_pe_message.id IS '主键';
COMMENT ON COLUMN t_pe_message.content IS '内容';
COMMENT ON COLUMN t_pe_message.user_id IS '学员';
COMMENT ON COLUMN t_pe_message.is_read IS '是否已读';

CREATE TABLE t_pe_corp_info (
  id                VARCHAR(32) PRIMARY KEY,
  corp_code         VARCHAR(50)  NOT NULL,
  create_by         VARCHAR(32)  NOT NULL,
  create_time       TIMESTAMP(6) NOT NULL,
  update_by         VARCHAR(32)  NOT NULL,
  update_time       TIMESTAMP(6) NOT NULL,
  address           VARCHAR(200),
  comments          VARCHAR(1300),
  concurrent_num    INT8         NOT NULL,
  contacts          VARCHAR(20),
  contacts_mobile   VARCHAR(20),
  contacts_position VARCHAR(20),
  corp_name         VARCHAR(50),
  corp_status       VARCHAR(20)  NOT NULL,
  domain_name       VARCHAR(200) NOT NULL,
  email             VARCHAR(200),
  end_time          TIMESTAMP(6),
  industry          VARCHAR(200),
  pay_apps          VARCHAR(200),
  register_num      INT8         NOT NULL,
  start_time        TIMESTAMP(6) NOT NULL,
  from_app_type      VARACHAR(20) NOT NULL
);

CREATE INDEX "i_pe_corp_info_corpCode"
  ON "t_pe_corp_info" USING BTREE (corp_code);
COMMENT ON TABLE "t_pe_corp_info" IS '公司表';
COMMENT ON COLUMN t_pe_corp_info.id IS '主键';
COMMENT ON COLUMN t_pe_corp_info.address IS '公司地址';
COMMENT ON COLUMN t_pe_corp_info.comments IS '备注';
COMMENT ON COLUMN t_pe_corp_info.concurrent_num IS '最大并发数';
COMMENT ON COLUMN t_pe_corp_info.contacts IS '联系人';
COMMENT ON COLUMN t_pe_corp_info.contacts_mobile IS '联系人联系方式';
COMMENT ON COLUMN t_pe_corp_info.contacts_position IS '联系人手机号码';
COMMENT ON COLUMN t_pe_corp_info.corp_name IS '公司名称';
COMMENT ON COLUMN t_pe_corp_info.corp_status IS '状态';
COMMENT ON COLUMN t_pe_corp_info.domain_name IS '域名';
COMMENT ON COLUMN t_pe_corp_info.email IS '邮件';
COMMENT ON COLUMN t_pe_corp_info.end_time IS '结束时间';
COMMENT ON COLUMN t_pe_corp_info.industry IS '行业';
COMMENT ON COLUMN t_pe_corp_info.register_num IS '注册数';
COMMENT ON COLUMN t_pe_corp_info.start_time IS '开始时间';
COMMENT ON COLUMN t_pe_corp_info.pay_apps IS '付费项目';
COMMENT ON COLUMN t_pe_corp_info.from_app_type IS '来源(PE:博易考,ELP:ELP)';

CREATE TABLE t_ems_exam_temporary (
  id          VARCHAR(32) PRIMARY KEY,
  exam_id     VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  user_id     VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  arrange_id  VARCHAR(32)  NOT NULL REFERENCES "t_ems_exam_arrange" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  exam_data   TEXT,
  corp_code   VARCHAR(50)  NOT NULL,
  create_by   VARCHAR(32)  NOT NULL,
  create_time TIMESTAMP(6) NOT NULL,
  update_by   VARCHAR(32)  NOT NULL,
  update_time TIMESTAMP(6) NOT NULL
);

CREATE INDEX "i_ems_exam_temporary_corpCode"
  ON "t_ems_exam_temporary" USING BTREE (corp_code);
CREATE INDEX "i_ems_exam_temporary_userId"
  ON "t_ems_exam_temporary" USING BTREE (user_id);
CREATE INDEX "i_ems_exam_temporary_exam_id"
  ON "t_ems_exam_temporary" USING BTREE (exam_id);
CREATE INDEX "i_ems_exam_temporary_arrange_id"
  ON "t_ems_exam_temporary" USING BTREE (arrange_id);
COMMENT ON TABLE "t_ems_exam_temporary" IS '公司表';
COMMENT ON COLUMN t_ems_exam_temporary.id IS '主键';
;
COMMENT ON COLUMN t_ems_exam_temporary.exam_id IS '考试Id';
COMMENT ON COLUMN t_ems_exam_temporary.user_id IS '人员Id';
COMMENT ON COLUMN t_ems_exam_temporary.exam_data IS '考试数据';
COMMENT ON COLUMN t_ems_exam_temporary.arrange_id IS '考试安排';



CREATE TABLE "t_ems_exercise" (
  "id"                VARCHAR(32) PRIMARY KEY,
  "corp_code"         VARCHAR(50)  NOT NULL,
  "create_by"         VARCHAR(32)  NOT NULL,
  "create_time"       TIMESTAMP(6) NOT NULL,
  "update_by"         VARCHAR(32)  NOT NULL,
  "update_time"       TIMESTAMP(6) NOT NULL,
  "exercise_code"     VARCHAR(50)  NOT NULL,
  "exercise_name"     VARCHAR(50)  NOT NULL,
  "status"            VARCHAR(20)  NOT NULL,
  "application_scope" VARCHAR(20)  NOT NULL,
  "end_time"          TIMESTAMP(6),
  "see_answer"        BOOL         NOT NULL,
  "item_count"        INT4,
  UNIQUE ("exercise_code")
);
CREATE INDEX "i_exe_exercise_corpCode" ON "t_ems_exercise" USING BTREE (corp_code);

CREATE INDEX "i_exe_exercise_createBy" ON "t_ems_exercise" USING BTREE (create_by);
COMMENT ON TABLE "t_ems_exercise" IS '练习实体表';
COMMENT ON COLUMN t_ems_exercise.id IS '主键';
COMMENT ON COLUMN t_ems_exercise.exercise_code IS '练习的编号';
COMMENT ON COLUMN t_ems_exercise.exercise_name IS '练习的名字';
COMMENT ON COLUMN t_ems_exercise.status IS '状态';
COMMENT ON COLUMN t_ems_exercise.application_scope IS '使用范围';
COMMENT ON COLUMN t_ems_exercise.end_time IS '结束时间';
COMMENT ON COLUMN t_ems_exercise.see_answer IS '是否可见答案';
COMMENT ON COLUMN t_ems_exercise.item_count IS '试题的总数';

CREATE TABLE "t_ems_exercise_user" (
  "id"          VARCHAR(32) PRIMARY KEY,
  "corp_code"   VARCHAR(50)  NOT NULL,
  "create_by"   VARCHAR(32)  NOT NULL,
  "create_time" TIMESTAMP(6) NOT NULL,
  "update_by"   VARCHAR(32)  NOT NULL,
  "update_time" TIMESTAMP(6) NOT NULL,
  "refer_id"    VARCHAR(50)  NOT NULL,
  "refer_type"  VARCHAR(20)  NOT NULL,
  "exercise_id" VARCHAR(32)  NOT NULL REFERENCES "t_ems_exercise" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX "i_ems_exercise_user_corpCode" ON "t_ems_exercise_user" USING BTREE (corp_code);

CREATE INDEX "i_ems_exercise_user_referId" ON "t_ems_exercise_user" USING BTREE (refer_id);

CREATE INDEX "i_ems_exercise_user_exerciseId" ON "t_ems_exercise_user" USING BTREE (exercise_id);
COMMENT ON TABLE "t_ems_exercise_user" IS '练习人员关联表';
COMMENT ON COLUMN t_ems_exercise_user.id IS '主键';
COMMENT ON COLUMN t_ems_exercise_user.exercise_id IS '练习主键';
COMMENT ON COLUMN t_ems_exercise_user.refer_type IS '关联的类型';
COMMENT ON COLUMN t_ems_exercise_user.refer_id IS '关联的id';

CREATE TABLE "t_ems_exercise_strategy" (
  "id"            VARCHAR(32) PRIMARY KEY,
  "corp_code"     VARCHAR(50)  NOT NULL,
  "create_by"     VARCHAR(32)  NOT NULL,
  "create_time"   TIMESTAMP(6) NOT NULL,
  "update_by"     VARCHAR(32)  NOT NULL,
  "update_time"   TIMESTAMP(6) NOT NULL,
  "object_id"     VARCHAR(32)  NOT NULL,
  "strategy_type" VARCHAR(20)  NOT NULL,
  "exercise_id"   VARCHAR(32)  NOT NULL,
  UNIQUE ("exercise_id", "object_id")
);

CREATE INDEX "i_ems_exercise_strategy_corpCode" ON "t_ems_exercise_strategy" USING BTREE (corp_code);

CREATE INDEX "i_ems_exercise_strategy_createBy" ON "t_ems_exercise_strategy" USING BTREE (create_by);

CREATE INDEX "i_ems_exercise_strategy_objectId" ON "t_ems_exercise_strategy" USING BTREE (object_id);
COMMENT ON TABLE "t_ems_exercise_strategy" IS '练习的题库知识点关联表';
COMMENT ON COLUMN t_ems_exercise_strategy.id IS '主键';
COMMENT ON COLUMN t_ems_exercise_strategy.exercise_id IS '练习ID';
COMMENT ON COLUMN t_ems_exercise_strategy.object_id IS '题库ID、知识点ID';
COMMENT ON COLUMN t_ems_exercise_strategy.strategy_type IS '类型:ITEM_BANK("题库"), KNOWLEDGE("知识点")';


CREATE TABLE "t_ems_exercise_setting" (
  "id"               VARCHAR(32) PRIMARY KEY,
  "corp_code"        VARCHAR(50)  NOT NULL,
  "create_by"        VARCHAR(32)  NOT NULL,
  "create_time"      TIMESTAMP(6) NOT NULL,
  "update_by"        VARCHAR(32)  NOT NULL,
  "update_time"      TIMESTAMP(6) NOT NULL,
  "item_number_type" VARCHAR(20)  NOT NULL,
  "speed_type"       VARCHAR(20)  NOT NULL,
  "question_answer" VARCHAR(20),
  "speed"            INT4,
  "item_number"      INT4,
  "has_submit"       BOOL,
  "exercise_id"      VARCHAR(32)  NOT NULL REFERENCES "t_ems_exercise" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "user_id"          VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  UNIQUE ("exercise_id", "user_id")
);

CREATE INDEX "i_ems_exercise_setting_createBy" ON "t_ems_exercise_setting" USING BTREE (create_by);

CREATE INDEX "i_ems_exercise_setting_exerciseId" ON "t_ems_exercise_setting" USING BTREE (exercise_id);

COMMENT ON TABLE "t_ems_exercise_setting" IS '练习的设置表';
COMMENT ON COLUMN t_ems_exercise_setting.id IS '主键';
COMMENT ON COLUMN t_ems_exercise_setting.item_number_type IS '试题数量设置：ALL("全部"), PORTION("部分")';
COMMENT ON COLUMN t_ems_exercise_setting.speed_type IS '做题速度设置 :LIMIT("限制"), UNLIMIT("不限制")';
COMMENT ON COLUMN t_ems_exercise_setting.next_question IS '下一题跳转设置:AUTOMATIC("自动"), NONAUTOMATIC("手动")';
COMMENT ON COLUMN t_ems_exercise_setting.speed IS '速度';
COMMENT ON COLUMN t_ems_exercise_setting.item_number IS '数量';
COMMENT ON COLUMN t_ems_exercise_setting.exercise_id IS '关联练习的id';
COMMENT ON COLUMN t_ems_exercise_setting.user_id IS '学员id';

CREATE TABLE "t_ems_exercise_item" (
  "id"          VARCHAR(32) PRIMARY KEY,
  "corp_code"   VARCHAR(50)  NOT NULL,
  "create_by"   VARCHAR(32)  NOT NULL,
  "create_time" TIMESTAMP(6) NOT NULL,
  "update_by"   VARCHAR(32)  NOT NULL,
  "update_time" TIMESTAMP(6) NOT NULL,
  "show_order"  FLOAT8       NOT NULL,
  "item_id"     VARCHAR(32)  NOT NULL REFERENCES "t_ems_item" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "exercise_id" VARCHAR(32)  NOT NULL REFERENCES "t_ems_exercise" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "user_id"     VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
COMMENT ON TABLE "t_ems_exercise_item" IS '练习试题关联表';
COMMENT ON COLUMN t_ems_exercise_item.id IS '主键';
COMMENT ON COLUMN t_ems_exercise_item.exercise_id IS '练习ID';
COMMENT ON COLUMN t_ems_exercise_item.item_id IS '试题ID';
COMMENT ON COLUMN t_ems_exercise_item.show_order IS '排序';
CREATE INDEX "i_ems_exercise_item_corpCode" ON "t_ems_exercise_item" USING BTREE (corp_code);
CREATE INDEX "i_ems_exercise_item_itemId" ON "t_ems_exercise_item" USING BTREE (item_id);

CREATE TABLE "t_ems_exercise_result_detail" (
  "id"                  VARCHAR(32) PRIMARY KEY,
  "corp_code"           VARCHAR(50)  NOT NULL,
  "create_by"           VARCHAR(32)  NOT NULL,
  "create_time"         TIMESTAMP(6) NOT NULL,
  "update_by"           VARCHAR(32)  NOT NULL,
  "update_time"         TIMESTAMP(6) NOT NULL,
  "exercise_id"         VARCHAR(32)  NOT NULL REFERENCES "t_ems_exercise" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "setting_id" VARCHAR(32)  NOT NULL,
  "user_id"             VARCHAR(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "accuracy"            FLOAT8       NOT NULL,
  "completion_rate"      FLOAT8       NOT NULL
);
CREATE INDEX "i_ems_exercise_result_corpCode" ON "t_ems_exercise_result_detail" USING BTREE (corp_code);
CREATE INDEX "i_ems_exercise_result_exerciseId" ON "t_ems_exercise_result_detail" USING BTREE (exercise_id);
CREATE INDEX "i_ems_exercise_result_userId" ON "t_ems_exercise_result_detail" USING BTREE (user_id);
CREATE INDEX "i_ems_exercise_result_settingId" ON "t_ems_exercise_result_detail" USING BTREE (setting_id);
COMMENT ON TABLE "t_ems_exercise_result_detail" IS '练习结果详情表';
COMMENT ON COLUMN t_ems_exercise_result_detail.id IS '主键';
COMMENT ON COLUMN t_ems_exercise_result_detail.exercise_id IS '练习Id';
COMMENT ON COLUMN t_ems_exercise_result_detail.setting_id IS '练习设置的ID';
COMMENT ON COLUMN t_ems_exercise_result_detail.user_id IS '用户ID';
COMMENT ON COLUMN t_ems_exercise_result_detail.accuracy IS '正确率';
COMMENT ON COLUMN t_ems_exercise_result_detail.completion_rate IS '完成率';

CREATE TABLE"t_ems_user_exercise_record" (
  "id" varchar(32) PRIMARY KEY,
  "corp_code" varchar(50)  NOT NULL,
  "create_by" varchar(32)  NOT NULL,
  "create_time" timestamp(6) NOT NULL,
  "update_by" varchar(32)  NOT NULL,
  "update_time" timestamp(6) NOT NULL,
  "answer" varchar(1300),
  "sign" bool NOT NULL,
  "correct" bool NOT NULL,
  "total_score" FLOAT8 NOT NULL,
  "score" FLOAT8 NOT NULL,
  "exercise_id" varchar(32)  NOT NULL REFERENCES "t_ems_exercise" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "item_id" varchar(32)  NOT NULL REFERENCES "t_ems_item" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "setting_id" varchar(32)  NOT NULL ,
  "user_id" varchar(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX "i_ems_user_exercise_record_corpCode" ON "t_ems_user_exercise_record" USING btree (corp_code);

CREATE INDEX "i_ems_user_exercise_record_exerciseId" ON "t_ems_user_exercise_record" USING btree (exercise_id);

CREATE INDEX "i_ems_user_exercise_record_settingId" ON "t_ems_user_exercise_record" USING btree (setting_id);

CREATE INDEX "i_ems_user_exercise_record_itemId" ON "t_ems_user_exercise_record" USING btree (item_id);

CREATE INDEX "i_ems_user_exercise_record_userId" ON "t_ems_user_exercise_record" USING btree (user_id);

COMMENT ON TABLE "t_ems_user_exercise_record" IS '学员试题答题记录表';
COMMENT ON COLUMN t_ems_user_exercise_record.id  IS '主键';
COMMENT ON COLUMN t_ems_user_exercise_record.exercise_id  IS '练习ID';
COMMENT ON COLUMN t_ems_user_exercise_record.item_id  IS '试题ID';
COMMENT ON COLUMN t_ems_user_exercise_record.setting_id  IS '设置ID';
COMMENT ON COLUMN t_ems_user_exercise_record.user_id  IS '学员ID';
COMMENT ON COLUMN t_ems_user_exercise_record.answer  IS '学员答案';
COMMENT ON COLUMN t_ems_user_exercise_record.correct IS '是否正确';
COMMENT ON COLUMN t_ems_user_exercise_record.sign  IS '是否标记';
COMMENT ON COLUMN t_ems_user_exercise_record.total_score  IS '试题总分';
COMMENT ON COLUMN t_ems_user_exercise_record.score  IS '试题得分';


CREATE TABLE"t_ems_user_exercise_record_detail" (
  "id" varchar(32) PRIMARY KEY,
  "corp_code" varchar(50)  NOT NULL,
  "create_by" varchar(32)  NOT NULL,
  "create_time" timestamp(6) NOT NULL,
  "update_by" varchar(32)  NOT NULL,
  "update_time" timestamp(6) NOT NULL,
  "answer" varchar(1300),
  "correct" bool NOT NULL,
  "total_score" FLOAT8 NOT NULL,
  "score" FLOAT8 NOT NULL,
  "sign" bool NOT NULL,
  "exercise_id" varchar(32)  NOT NULL REFERENCES "t_ems_exercise" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "item_id" varchar(32)  NOT NULL REFERENCES "t_ems_item" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "user_id" varchar(32)  NOT NULL REFERENCES "t_uc_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX "i_ems_user_exercise_record_detail_corpCode" ON "t_ems_user_exercise_record_detail" USING btree (corp_code);

CREATE INDEX "i_ems_user_exercise_record_detail_exerciseId" ON "t_ems_user_exercise_record_detail" USING btree (exercise_id);

CREATE INDEX "i_ems_user_exercise_record_detail_itemId" ON "t_ems_user_exercise_record_detail" USING btree (item_id);

CREATE INDEX "i_ems_user_exercise_record_detail_userId" ON "t_ems_user_exercise_record_detail" USING btree (user_id);

COMMENT ON TABLE "t_ems_user_exercise_record_detail" IS '学员试题答题详情记录表';
COMMENT ON COLUMN t_ems_user_exercise_record_detail.id  IS '主键';
COMMENT ON COLUMN t_ems_user_exercise_record_detail.exercise_id  IS '练习ID';
COMMENT ON COLUMN t_ems_user_exercise_record_detail.item_id  IS '试题ID';
COMMENT ON COLUMN t_ems_user_exercise_record_detail.user_id  IS '学员ID';
COMMENT ON COLUMN t_ems_user_exercise_record_detail.answer  IS '学员答案';
COMMENT ON COLUMN t_ems_user_exercise_record_detail.correct IS '是否正确';
COMMENT ON COLUMN t_ems_user_exercise_record_detail.total_score IS '试题总分';
COMMENT ON COLUMN t_ems_user_exercise_record_detail.score IS '得分';
COMMENT ON COLUMN t_ems_user_exercise_record_detail.sign IS '是否标记';
/** 同步ELP 数据*/
alter table t_uc_user alter column password type varchar(100);
alter table t_pe_corp_info add from_app_type varchar(20) default 'PE';
COMMENT ON COLUMN t_pe_corp_info.from_app_type IS '公司来源,ELP,PE';




