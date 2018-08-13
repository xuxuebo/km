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