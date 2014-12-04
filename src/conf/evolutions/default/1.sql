# --- Created by Slick DDL
# To stop Slick DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table "analyzer_instances" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_instance_id" BIGINT NOT NULL,"analyzer_id" BIGINT NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "analyzers" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_id" BIGINT NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "component_instances" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"uri" VARCHAR NOT NULL,"configuration" VARCHAR,"component_id" BIGINT NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "components" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"uri" VARCHAR NOT NULL,"title" VARCHAR NOT NULL,"description" VARCHAR,"default_configuration" VARCHAR,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "dataport_binding_sets" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "dataport_binding_to_binding_set" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"set_id" BIGINT NOT NULL,"binding_id" BIGINT NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "dataport_bindings" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"start_port_id" BIGINT NOT NULL,"end_input_id" BIGINT NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "dataport_instances" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_instance_id" BIGINT NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "dataports" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_id" BIGINT NOT NULL,"title" VARCHAR NOT NULL,"description" VARCHAR,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "datasource_instances" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_instance_id" BIGINT NOT NULL,"datasource_id" BIGINT NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "datasources" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_id" BIGINT NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "feature_to_component" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_id" BIGINT NOT NULL,"feature_id" BIGINT NOT NULL,"ordering" INTEGER,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "features" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"uri" VARCHAR NOT NULL,"is_mandatory" BOOLEAN NOT NULL,"title" VARCHAR NOT NULL,"description" VARCHAR,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "input_instances" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"dataport_instance_id" BIGINT NOT NULL,"component_instance_id" BIGINT NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "inputs" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"dataport_id" BIGINT NOT NULL,"component_id" BIGINT NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "output_instances" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"dataport_instance_id" BIGINT NOT NULL,"component_instance_id" BIGINT NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "outputs" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"output_data_sample" VARCHAR,"dataport_id" BIGINT NOT NULL,"component_id" BIGINT NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "pipelines" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"binding_set_id" BIGINT NOT NULL,"uri" VARCHAR NOT NULL,"title" VARCHAR NOT NULL,"description" VARCHAR,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "signatures" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"feature_id" BIGINT NOT NULL,"input_id" BIGINT NOT NULL,"query" VARCHAR NOT NULL,"title" VARCHAR NOT NULL,"description" VARCHAR,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "transformer" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_id" BIGINT NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "transformer_instances" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_instance_id" BIGINT NOT NULL,"transformer_id" BIGINT NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "visualizer" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_id" BIGINT NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "visualizer_instances" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_instance_id" BIGINT NOT NULL,"visualizer_id" BIGINT NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
alter table "analyzer_instances" add constraint "fk_ait_at_analyzer_id" foreign key("analyzer_id") references "analyzers"("id") on update NO ACTION on delete NO ACTION;
alter table "analyzer_instances" add constraint "fk_ait_cit_component_instance_id" foreign key("component_instance_id") references "component_instances"("id") on update NO ACTION on delete NO ACTION;
alter table "analyzers" add constraint "fk_at_ct_component_id" foreign key("component_id") references "components"("id") on update NO ACTION on delete NO ACTION;
alter table "component_instances" add constraint "fk_cit_ct_component_id" foreign key("component_id") references "components"("id") on update NO ACTION on delete NO ACTION;
alter table "dataport_binding_to_binding_set" add constraint "fk_dpbtbs_dpb_binding_id" foreign key("binding_id") references "dataport_bindings"("id") on update NO ACTION on delete NO ACTION;
alter table "dataport_binding_to_binding_set" add constraint "fk_dpbtbs_dpbs_binding_set_id" foreign key("set_id") references "dataport_binding_sets"("id") on update NO ACTION on delete NO ACTION;
alter table "dataport_bindings" add constraint "fk_dpbt_dpt_end_input_id" foreign key("end_input_id") references "input_instances"("id") on update NO ACTION on delete NO ACTION;
alter table "dataport_bindings" add constraint "fk_dpbt_dpt_start_port_id" foreign key("start_port_id") references "dataport_instances"("id") on update NO ACTION on delete NO ACTION;
alter table "datasource_instances" add constraint "fk_dsit_cit_component_instance_id" foreign key("component_instance_id") references "component_instances"("id") on update NO ACTION on delete NO ACTION;
alter table "datasource_instances" add constraint "fk_dsit_dst_component_id" foreign key("datasource_id") references "datasources"("id") on update NO ACTION on delete NO ACTION;
alter table "datasources" add constraint "fk_dst_ct_component_id" foreign key("component_id") references "components"("id") on update NO ACTION on delete NO ACTION;
alter table "feature_to_component" add constraint "fk_ftc_ct_component_id" foreign key("component_id") references "components"("id") on update NO ACTION on delete NO ACTION;
alter table "feature_to_component" add constraint "fk_ftc_ft_feature_id" foreign key("feature_id") references "features"("id") on update NO ACTION on delete NO ACTION;
alter table "pipelines" add constraint "fk_pt_bst_id" foreign key("binding_set_id") references "dataport_binding_sets"("id") on update NO ACTION on delete NO ACTION;
alter table "signatures" add constraint "fk_st_ft_feature_id" foreign key("feature_id") references "features"("id") on update NO ACTION on delete NO ACTION;
alter table "signatures" add constraint "fk_st_it_input_id" foreign key("input_id") references "inputs"("id") on update NO ACTION on delete NO ACTION;
alter table "transformer" add constraint "fk_tt_ct_component_id" foreign key("component_id") references "components"("id") on update NO ACTION on delete NO ACTION;
alter table "transformer_instances" add constraint "fk_tit_cit_component_instance_id" foreign key("component_instance_id") references "component_instances"("id") on update NO ACTION on delete NO ACTION;
alter table "transformer_instances" add constraint "fk_tit_dst_component_id" foreign key("transformer_id") references "transformer"("id") on update NO ACTION on delete NO ACTION;
alter table "visualizer" add constraint "fk_vt_ct_component_id" foreign key("component_id") references "components"("id") on update NO ACTION on delete NO ACTION;
alter table "visualizer_instances" add constraint "fk_vit_cit_component_instance_id" foreign key("component_instance_id") references "component_instances"("id") on update NO ACTION on delete NO ACTION;
alter table "visualizer_instances" add constraint "fk_vit_dst_component_id" foreign key("visualizer_id") references "visualizer"("id") on update NO ACTION on delete NO ACTION;

# --- !Downs

alter table "visualizer_instances" drop constraint "fk_vit_cit_component_instance_id";
alter table "visualizer_instances" drop constraint "fk_vit_dst_component_id";
alter table "visualizer" drop constraint "fk_vt_ct_component_id";
alter table "transformer_instances" drop constraint "fk_tit_cit_component_instance_id";
alter table "transformer_instances" drop constraint "fk_tit_dst_component_id";
alter table "transformer" drop constraint "fk_tt_ct_component_id";
alter table "signatures" drop constraint "fk_st_ft_feature_id";
alter table "signatures" drop constraint "fk_st_it_input_id";
alter table "pipelines" drop constraint "fk_pt_bst_id";
alter table "feature_to_component" drop constraint "fk_ftc_ct_component_id";
alter table "feature_to_component" drop constraint "fk_ftc_ft_feature_id";
alter table "datasources" drop constraint "fk_dst_ct_component_id";
alter table "datasource_instances" drop constraint "fk_dsit_cit_component_instance_id";
alter table "datasource_instances" drop constraint "fk_dsit_dst_component_id";
alter table "dataport_bindings" drop constraint "fk_dpbt_dpt_end_input_id";
alter table "dataport_bindings" drop constraint "fk_dpbt_dpt_start_port_id";
alter table "dataport_binding_to_binding_set" drop constraint "fk_dpbtbs_dpb_binding_id";
alter table "dataport_binding_to_binding_set" drop constraint "fk_dpbtbs_dpbs_binding_set_id";
alter table "component_instances" drop constraint "fk_cit_ct_component_id";
alter table "analyzers" drop constraint "fk_at_ct_component_id";
alter table "analyzer_instances" drop constraint "fk_ait_at_analyzer_id";
alter table "analyzer_instances" drop constraint "fk_ait_cit_component_instance_id";
drop table "visualizer_instances";
drop table "visualizer";
drop table "transformer_instances";
drop table "transformer";
drop table "signatures";
drop table "pipelines";
drop table "outputs";
drop table "output_instances";
drop table "inputs";
drop table "input_instances";
drop table "features";
drop table "feature_to_component";
drop table "datasources";
drop table "datasource_instances";
drop table "dataports";
drop table "dataport_instances";
drop table "dataport_bindings";
drop table "dataport_binding_to_binding_set";
drop table "dataport_binding_sets";
drop table "components";
drop table "component_instances";
drop table "analyzers";
drop table "analyzer_instances";

