# --- Created by Slick DDL
# To stop Slick DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table "analyzer_instances" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_instance_id" BIGINT NOT NULL,"analyzer_id" BIGINT NOT NULL,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "analyzer_templates" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_template_id" BIGINT NOT NULL,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "component_instance_compatibility_checks" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_instance_id" BIGINT NOT NULL,"data_port_binding_set_id" BIGINT NOT NULL,"is_finished" BOOLEAN NOT NULL,"is_success" BOOLEAN,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "component_instances" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"uri" VARCHAR NOT NULL,"title" VARCHAR NOT NULL,"description" VARCHAR,"component_id" BIGINT NOT NULL,"configuration" VARCHAR,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "component_instances_membership" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"data_port_binding_set_id" BIGINT NOT NULL,"component_instance_id" BIGINT NOT NULL,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "component_templates" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"uri" VARCHAR NOT NULL,"title" VARCHAR NOT NULL,"description" VARCHAR,"data_port_binding_set_id" BIGINT,"is_temporary" BOOLEAN NOT NULL,"default_configuration" VARCHAR,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "data_port_binding_set_compatibility_checks" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"data_port_binding_set_id" BIGINT NOT NULL,"is_finished" BOOLEAN NOT NULL,"is_success" BOOLEAN,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "dataport_binding_sets" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "dataport_bindings" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"binding_set_id" BIGINT NOT NULL,"source_data_port_id" BIGINT NOT NULL,"target_data_port_id" BIGINT NOT NULL,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "dataport_instances" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"uri" VARCHAR NOT NULL,"title" VARCHAR NOT NULL,"description" VARCHAR,"component_instance_id" BIGINT NOT NULL,"data_port_id" BIGINT NOT NULL,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "dataport_templates" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"uri" VARCHAR NOT NULL,"title" VARCHAR NOT NULL,"description" VARCHAR,"component_template_id" BIGINT NOT NULL,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "datasource_instances" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_instance_id" BIGINT NOT NULL,"datasource_id" BIGINT NOT NULL,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "datasource_templates" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_template_id" BIGINT NOT NULL,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "descriptor_compatibility_checks" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"descriptor_id" BIGINT NOT NULL,"feature_id" BIGINT NOT NULL,"component_instance_id" BIGINT NOT NULL,"data_port_binding_set_id" BIGINT NOT NULL,"is_finished" BOOLEAN NOT NULL,"is_success" BOOLEAN,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "descriptors" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"feature_id" BIGINT NOT NULL,"input_template_id" BIGINT NOT NULL,"query" VARCHAR NOT NULL,"title" VARCHAR NOT NULL,"description" VARCHAR,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "feature_compatibility_checks" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"feature_id" BIGINT NOT NULL,"component_instance_id" BIGINT NOT NULL,"data_port_binding_set_id" BIGINT NOT NULL,"is_finished" BOOLEAN NOT NULL,"is_success" BOOLEAN,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "feature_to_component" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_id" BIGINT NOT NULL,"feature_id" BIGINT NOT NULL,"ordering" INTEGER,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "features" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"uri" VARCHAR NOT NULL,"is_mandatory" BOOLEAN NOT NULL,"title" VARCHAR NOT NULL,"description" VARCHAR,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "input_instances" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"dataport_instance_id" BIGINT NOT NULL,"input_id" BIGINT NOT NULL,"component_instance_id" BIGINT NOT NULL,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "input_templates" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"dataport_template_id" BIGINT NOT NULL,"component_id" BIGINT NOT NULL,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "nested_dataport_bindings" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"binding_set_id" BIGINT NOT NULL,"source_data_port_template_id" BIGINT,"target_data_port_template_id" BIGINT,"source_data_port_instance_id" BIGINT,"target_data_port_instance_id" BIGINT,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "output_instances" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"dataport_instance_id" BIGINT NOT NULL,"output_id" BIGINT NOT NULL,"component_instance_id" BIGINT NOT NULL,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "output_templates" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"output_data_sample" VARCHAR,"dataport_template_id" BIGINT NOT NULL,"component_template_id" BIGINT NOT NULL,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "pipeline_discovery" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"is_finished" BOOLEAN NOT NULL,"is_success" BOOLEAN,"last_performed_iteration" INTEGER,"pipelines_discovered_count" INTEGER,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "pipeline_evaluation" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"pipeline_id" BIGINT NOT NULL,"is_finished" BOOLEAN NOT NULL,"is_success" BOOLEAN,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "pipeline_evaluation_result" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"pipeline_evaluation_id" BIGINT NOT NULL,"component_template_id" BIGINT NOT NULL,"port_id" BIGINT NOT NULL,"endpoint_url" VARCHAR NOT NULL,"graph_uri" VARCHAR,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "pipelines" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"binding_set_id" BIGINT NOT NULL,"uri" VARCHAR NOT NULL,"title" VARCHAR NOT NULL,"description" VARCHAR,"is_temporary" BOOLEAN NOT NULL,"pipeline_discovery_id" BIGINT,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "transformer_instances" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_instance_id" BIGINT NOT NULL,"transformer_id" BIGINT NOT NULL,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "transformer_templates" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_template_id" BIGINT NOT NULL,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "visualizer_instances" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_instance_id" BIGINT NOT NULL,"visualizer_id" BIGINT NOT NULL,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
create table "visualizer_templates" ("id" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,"component_id" BIGINT NOT NULL,"uuid" VARCHAR NOT NULL,"created" TIMESTAMP,"modified" TIMESTAMP);
alter table "analyzer_instances" add constraint "fk_ait_at_analyzer_id" foreign key("analyzer_id") references "analyzer_templates"("id") on update NO ACTION on delete NO ACTION;
alter table "analyzer_instances" add constraint "fk_ait_cit_component_instance_id" foreign key("component_instance_id") references "component_instances"("id") on update NO ACTION on delete NO ACTION;
alter table "analyzer_templates" add constraint "fk_at_ctt_component_template_id" foreign key("component_template_id") references "component_templates"("id") on update NO ACTION on delete NO ACTION;
alter table "component_instances" add constraint "fk_cit_ct_component_id" foreign key("component_id") references "component_templates"("id") on update NO ACTION on delete NO ACTION;
alter table "component_instances_membership" add constraint "fk_cimt_cit_component_id" foreign key("component_instance_id") references "component_instances"("id") on update NO ACTION on delete NO ACTION;
alter table "component_instances_membership" add constraint "fk_cimt_dpbst_component_id" foreign key("data_port_binding_set_id") references "dataport_binding_sets"("id") on update NO ACTION on delete NO ACTION;
alter table "dataport_bindings" add constraint "fk_dpbt_dpbst_binding_set_id" foreign key("binding_set_id") references "dataport_binding_sets"("id") on update NO ACTION on delete NO ACTION;
alter table "dataport_bindings" add constraint "fk_dpbt_dpt_source_port_id" foreign key("source_data_port_id") references "dataport_instances"("id") on update NO ACTION on delete NO ACTION;
alter table "dataport_bindings" add constraint "fk_dpbt_dpt_target_data_port_id" foreign key("target_data_port_id") references "dataport_instances"("id") on update NO ACTION on delete NO ACTION;
alter table "datasource_instances" add constraint "fk_dsit_cit_component_instance_id" foreign key("component_instance_id") references "component_instances"("id") on update NO ACTION on delete NO ACTION;
alter table "datasource_instances" add constraint "fk_dsit_dst_component_id" foreign key("datasource_id") references "datasource_templates"("id") on update NO ACTION on delete NO ACTION;
alter table "datasource_templates" add constraint "fk_dst_ctt_component_template_id" foreign key("component_template_id") references "component_templates"("id") on update NO ACTION on delete NO ACTION;
alter table "descriptors" add constraint "fk_dt_ft_feature_id" foreign key("feature_id") references "features"("id") on update NO ACTION on delete NO ACTION;
alter table "descriptors" add constraint "fk_dt_itt_input_template_id" foreign key("input_template_id") references "input_templates"("id") on update NO ACTION on delete NO ACTION;
alter table "feature_to_component" add constraint "fk_ftc_ct_component_id" foreign key("component_id") references "component_templates"("id") on update NO ACTION on delete NO ACTION;
alter table "feature_to_component" add constraint "fk_ftc_ft_feature_id" foreign key("feature_id") references "features"("id") on update NO ACTION on delete NO ACTION;
alter table "nested_dataport_bindings" add constraint "fk_ndbt_dpbst_binding_set_id" foreign key("binding_set_id") references "dataport_binding_sets"("id") on update NO ACTION on delete NO ACTION;
alter table "nested_dataport_bindings" add constraint "fk_ndbt_dpit_source_port_instance_id" foreign key("source_data_port_instance_id") references "dataport_instances"("id") on update NO ACTION on delete NO ACTION;
alter table "nested_dataport_bindings" add constraint "fk_ndbt_dpit_target_port_instance_id" foreign key("target_data_port_instance_id") references "dataport_instances"("id") on update NO ACTION on delete NO ACTION;
alter table "nested_dataport_bindings" add constraint "fk_ndbt_dptt_source_port_template_id" foreign key("source_data_port_template_id") references "dataport_templates"("id") on update NO ACTION on delete NO ACTION;
alter table "nested_dataport_bindings" add constraint "fk_ndbt_dptt_target_port_template_id" foreign key("target_data_port_template_id") references "dataport_templates"("id") on update NO ACTION on delete NO ACTION;
alter table "pipeline_evaluation" add constraint "pipeline" foreign key("pipeline_id") references "pipelines"("id") on update NO ACTION on delete NO ACTION;
alter table "pipeline_evaluation_result" add constraint "pipeline_evaluation" foreign key("pipeline_evaluation_id") references "pipeline_evaluation"("id") on update NO ACTION on delete NO ACTION;
alter table "pipeline_evaluation_result" add constraint "port" foreign key("port_id") references "dataport_templates"("id") on update NO ACTION on delete NO ACTION;
alter table "pipeline_evaluation_result" add constraint "visualizer" foreign key("component_template_id") references "component_templates"("id") on update NO ACTION on delete NO ACTION;
alter table "pipelines" add constraint "fk_pt_bst_id" foreign key("binding_set_id") references "dataport_binding_sets"("id") on update NO ACTION on delete NO ACTION;
alter table "pipelines" add constraint "pipeline_discovery" foreign key("pipeline_discovery_id") references "pipeline_discovery"("id") on update NO ACTION on delete NO ACTION;
alter table "transformer_instances" add constraint "fk_tit_cit_component_instance_id" foreign key("component_instance_id") references "component_instances"("id") on update NO ACTION on delete NO ACTION;
alter table "transformer_instances" add constraint "fk_tit_dst_component_id" foreign key("transformer_id") references "transformer_templates"("id") on update NO ACTION on delete NO ACTION;
alter table "transformer_templates" add constraint "fk_tt_ctt_component_template_id" foreign key("component_template_id") references "component_templates"("id") on update NO ACTION on delete NO ACTION;
alter table "visualizer_instances" add constraint "fk_vit_cit_component_instance_id" foreign key("component_instance_id") references "component_instances"("id") on update NO ACTION on delete NO ACTION;
alter table "visualizer_instances" add constraint "fk_vit_dst_visualizer_id" foreign key("visualizer_id") references "visualizer_templates"("id") on update NO ACTION on delete NO ACTION;
alter table "visualizer_templates" add constraint "fk_vt_ctt_component_template_id" foreign key("component_id") references "component_templates"("id") on update NO ACTION on delete NO ACTION;

# --- !Downs

alter table "visualizer_templates" drop constraint "fk_vt_ctt_component_template_id";
alter table "visualizer_instances" drop constraint "fk_vit_cit_component_instance_id";
alter table "visualizer_instances" drop constraint "fk_vit_dst_visualizer_id";
alter table "transformer_templates" drop constraint "fk_tt_ctt_component_template_id";
alter table "transformer_instances" drop constraint "fk_tit_cit_component_instance_id";
alter table "transformer_instances" drop constraint "fk_tit_dst_component_id";
alter table "pipelines" drop constraint "fk_pt_bst_id";
alter table "pipelines" drop constraint "pipeline_discovery";
alter table "pipeline_evaluation_result" drop constraint "pipeline_evaluation";
alter table "pipeline_evaluation_result" drop constraint "port";
alter table "pipeline_evaluation_result" drop constraint "visualizer";
alter table "pipeline_evaluation" drop constraint "pipeline";
alter table "nested_dataport_bindings" drop constraint "fk_ndbt_dpbst_binding_set_id";
alter table "nested_dataport_bindings" drop constraint "fk_ndbt_dpit_source_port_instance_id";
alter table "nested_dataport_bindings" drop constraint "fk_ndbt_dpit_target_port_instance_id";
alter table "nested_dataport_bindings" drop constraint "fk_ndbt_dptt_source_port_template_id";
alter table "nested_dataport_bindings" drop constraint "fk_ndbt_dptt_target_port_template_id";
alter table "feature_to_component" drop constraint "fk_ftc_ct_component_id";
alter table "feature_to_component" drop constraint "fk_ftc_ft_feature_id";
alter table "descriptors" drop constraint "fk_dt_ft_feature_id";
alter table "descriptors" drop constraint "fk_dt_itt_input_template_id";
alter table "datasource_templates" drop constraint "fk_dst_ctt_component_template_id";
alter table "datasource_instances" drop constraint "fk_dsit_cit_component_instance_id";
alter table "datasource_instances" drop constraint "fk_dsit_dst_component_id";
alter table "dataport_bindings" drop constraint "fk_dpbt_dpbst_binding_set_id";
alter table "dataport_bindings" drop constraint "fk_dpbt_dpt_source_port_id";
alter table "dataport_bindings" drop constraint "fk_dpbt_dpt_target_data_port_id";
alter table "component_instances_membership" drop constraint "fk_cimt_cit_component_id";
alter table "component_instances_membership" drop constraint "fk_cimt_dpbst_component_id";
alter table "component_instances" drop constraint "fk_cit_ct_component_id";
alter table "analyzer_templates" drop constraint "fk_at_ctt_component_template_id";
alter table "analyzer_instances" drop constraint "fk_ait_at_analyzer_id";
alter table "analyzer_instances" drop constraint "fk_ait_cit_component_instance_id";
drop table "visualizer_templates";
drop table "visualizer_instances";
drop table "transformer_templates";
drop table "transformer_instances";
drop table "pipelines";
drop table "pipeline_evaluation_result";
drop table "pipeline_evaluation";
drop table "pipeline_discovery";
drop table "output_templates";
drop table "output_instances";
drop table "nested_dataport_bindings";
drop table "input_templates";
drop table "input_instances";
drop table "features";
drop table "feature_to_component";
drop table "feature_compatibility_checks";
drop table "descriptors";
drop table "descriptor_compatibility_checks";
drop table "datasource_templates";
drop table "datasource_instances";
drop table "dataport_templates";
drop table "dataport_instances";
drop table "dataport_bindings";
drop table "dataport_binding_sets";
drop table "data_port_binding_set_compatibility_checks";
drop table "component_templates";
drop table "component_instances_membership";
drop table "component_instances";
drop table "component_instance_compatibility_checks";
drop table "analyzer_templates";
drop table "analyzer_instances";

