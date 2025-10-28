#Nested querries
# employee id who sold more than 30k
use company;


#clients handled by branch michael scott manages

select client.client_name
from client
where client.branch_id = (
	select branch.branch_id
    from branch
    where branch.mgr_id = 102
);
  
  #deleting entries
  #on delete cascade
  # on delete null
  
  #Triggers
  create table trigger_test (
      message varchar(100)
  );
  
DELIMITER $$
CREATE
TRIGGER my_trigger BEFORE INSERT
ON employee
FOR EACH ROW BEGIN
INSERT INTO trigger_test VALUES('added new employee');
END$$
DELIMITER ;
  
  


