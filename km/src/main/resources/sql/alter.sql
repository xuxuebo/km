ALTER TABLE t_km_share DROP  share_library_id;
ALTER TABLE t_km_knowledge_rel add column share_id varchar(32);

CREATE TABLE t_km_library_detail (
  id             VARCHAR(32) PRIMARY KEY,
  corp_code      VARCHAR(50)  NOT NULL,
  create_by      VARCHAR(32)  NOT NULL,
  create_time    TIMESTAMP(6) NOT NULL,
  update_by      VARCHAR(32)  NOT NULL,
  update_time    TIMESTAMP(6) NOT NULL,
  library_id     VARCHAR(32)  NOT NULL,
  charge_ids     VARCHAR(1300),
  face_id        VARCHAR(50),
  face_name        VARCHAR(200),
  summary        VARCHAR
);

COMMENT ON TABLE t_km_library_detail IS '知识库扩展信息表';
COMMENT ON COLUMN t_km_library_detail."id" IS '主键';
COMMENT ON COLUMN t_km_library_detail."library_id" IS '知识库Id';
COMMENT ON COLUMN t_km_library_detail."charge_ids" IS '负责人Ids';
COMMENT ON COLUMN t_km_library_detail."face_id" IS '封面Id';
COMMENT ON COLUMN t_km_library_detail."face_name" IS '封面名称';
COMMENT ON COLUMN t_km_library_detail."summary" IS '简介';

CREATE INDEX "i_km_library_detail_corpCode" ON t_km_library_detail USING btree (corp_code);

CREATE TABLE t_km_knowledge_log (
  id             VARCHAR(32) PRIMARY KEY,
  corp_code      VARCHAR(50)  NOT NULL,
  create_by      VARCHAR(32)  NOT NULL,
  create_time    TIMESTAMP(6) NOT NULL,
  update_by      VARCHAR(32)  NOT NULL,
  update_time    TIMESTAMP(6) NOT NULL,
  knowledge_id   VARCHAR(32)  NOT NULL,
  library_id     VARCHAR(32)  NOT NULL,
  type           VARCHAR(20)  NOT NULL,
  remark         VARCHAR(1300)
);

COMMENT ON TABLE t_km_knowledge_log IS '知识操作日志表';
COMMENT ON COLUMN t_km_knowledge_log."id" IS '主键';
COMMENT ON COLUMN t_km_knowledge_log."library_id" IS '知识库Id';
COMMENT ON COLUMN t_km_knowledge_log."knowledge_id" IS '知识Id';
COMMENT ON COLUMN t_km_knowledge_log."type" IS '操作类型，DELETE:删除，UPLOAD:上传，DOWNLOAD:下载，SHARE:分享，COPY:复制';
COMMENT ON COLUMN t_km_knowledge_log."remark" IS '备注';

CREATE INDEX "i_km_knowledge_log_corpCode" ON t_km_knowledge_log USING btree (corp_code);

CREATE TABLE t_km_score_rule (
  id             VARCHAR(32) PRIMARY KEY,
  corp_code      VARCHAR(50)  NOT NULL,
  create_by      VARCHAR(32)  NOT NULL,
  create_time    TIMESTAMP(6) NOT NULL,
  update_by      VARCHAR(32)  NOT NULL,
  update_time    TIMESTAMP(6) NOT NULL,
  code           VARCHAR(50)  NOT NULL,
  name           VARCHAR(100) NOT NULL,
  score      int4         NOT NULL
);

COMMENT ON TABLE t_km_score_rule IS '积分规则表';
COMMENT ON COLUMN t_km_score_rule."id" IS '主键';
COMMENT ON COLUMN t_km_score_rule."code" IS '规则编号';
COMMENT ON COLUMN t_km_score_rule."name" IS '规则名称';
COMMENT ON COLUMN t_km_score_rule."score" IS '该规则获得的积分，正数为获得积分，负数位扣除积分';

CREATE INDEX "i_km_score_rule_corpCode" ON t_km_score_rule USING btree (corp_code);

CREATE TABLE t_km_score_detail (
  id             VARCHAR(32) PRIMARY KEY,
  corp_code      VARCHAR(50)  NOT NULL,
  create_by      VARCHAR(32)  NOT NULL,
  create_time    TIMESTAMP(6) NOT NULL,
  update_by      VARCHAR(32)  NOT NULL,
  update_time    TIMESTAMP(6) NOT NULL,
  rule_id        VARCHAR(32)  NOT NULL,
  user_id        VARCHAR(32)  NOT NULL,
  opt_user_id    vARCHAR(32)  NOT NULL,
  knowledge_id   VARCHAR(32)  NOT NULL,
  score          int4         NOT NULL
);

COMMENT ON TABLE t_km_score_detail IS '积分明细表';
COMMENT ON COLUMN t_km_score_detail."id" IS '主键';
COMMENT ON COLUMN t_km_score_detail."rule_id" IS '规则Id';
COMMENT ON COLUMN t_km_score_detail."user_id" IS '获取积分的人员Id';
COMMENT ON COLUMN t_km_score_detail."opt_user_id" IS '操作人员Id';
COMMENT ON COLUMN t_km_score_detail."knowledge_id" IS '操作的知识Id';
COMMENT ON COLUMN t_km_score_detail."score" IS '实际获得的积分数';

CREATE INDEX "i_km_score_detail_corpCode" ON t_km_score_detail USING btree (corp_code);

INSERT INTO "public"."t_km_score_rule" ("id","corp_code","create_by","create_time","update_by","update_time","code","name","score")
VALUES(	'11111111111111111111',	'default',	'admin',	'2018-08-21 16:14:59',	'admin',	'2018-08-21 16:15:03',	'upload',	'上传知识',	'10'),
(	'2222222222222222222222',	'default',	'admin',	'2018-08-21 16:14:59',	'admin',	'2018-08-21 16:15:03',	'download',	'知识被下载',	'10'),
(	'3333333333333333333333',	'default',	'admin',	'2018-08-21 16:14:59',	'admin',	'2018-08-21 16:15:03',	'share',	'分享知识',	'10'),
(	'4444444444444444444444',	'default',	'admin',	'2018-08-21 16:14:59',	'admin',	'2018-08-21 16:15:03',	'delete',	'删除知识',	'-10'),
(	'5555555555555555555555',	'default',	'admin',	'2018-08-21 16:14:59',	'admin',	'2018-08-21 16:15:03',	'cancel_share',	'取消知识分享',	'-10'),
(	'6666666666666666666666',	'default',	'admin',	'2018-08-21 16:14:59',	'admin',	'2018-08-21 16:15:03',	'recycle',	'知识从回收站还原',	'10');