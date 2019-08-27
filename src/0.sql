# 取得＆インクリメント
.param init
.headers off
.mode list
.output ./schema_version.txt
pragma schema_version;
.output stdout
insert into sqlite_parameters values('@schema_version', (
  select (cast(rtrim(data, x'0A') as integer) + 1)
  from fsdir('./schema_version.txt')));
.param list

# 設定
.output ./pragma_schema_version.sql
select 'pragma schema_version = ' || @schema_version || ';';
.output stdout
.read ./pragma_schema_version.sql

# 確認
pragma schema_version;

