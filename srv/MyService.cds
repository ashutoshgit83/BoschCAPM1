using { ashutosh.db.master } from '../db/model';

service MyService @(path : 'MyService') {

function api(name: String) returns String;

@readonly
entity EmployeeSrv as projection on master.employees;
    

}