drop table if exists gh_ost_test;
create table gh_ost_test (
  id binary(4) NOT NULL,
  primary key (id)
) auto_increment=1;

drop event if exists gh_ost_test;
delimiter ;;
create event gh_ost_test
  on schedule at current_timestamp + interval 10 second -- set to 1/2 the value in ./postpone-cut-over
  on completion not preserve
  enable
  do
begin
  DELETE FROM gh_ost_test WHERE id = X'ffffff00';
end ;;

delimiter ;

INSERT INTO gh_ost_test (id) VALUES (X'ffffff00');
