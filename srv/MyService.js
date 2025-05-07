// export default function(srv) {
//     srv.on('api', (req,res) => {
//         return 'Hello Amigo, your name is ' + req.params.name;
//     });
//     }
const cds = require('@sap/cds');
module.exports = 

function (srv){

    srv.on('api', (req, res) => { 

        return 'Hello Amigo, your name is'+ req.data.name;
    });    

    const { employees } = cds.entities('ashutosh.db.master');
    srv.on('READ', 'EmployeeSrv', async (req, res) => {

        //example 1 hardcoded return
        // return res.send([
        //     {
        //         id: 1,
        //         name: 'John Doe',
        //         department: 'IT',
        //         salary: 50000
        //     }
        // ]);
        //example 2 fetch data from a database
        try {
            const tx = await srv.tx(req);
            //const employeesdata = await tx.run(`SELECT * FROM employees`).limit(2);
            const employeesdata = await tx.run(SELECT.from(employees).limit(2));
            return employeesdata;
        } catch (error) {
            res.status(500).send(error);
        }

        //example 3 update records using map 
        const tx = await srv.tx(req);
        const employeeData = await tx.run(SELECT.from(employees));
        const updateEmployees = employeeData.map(record => ({
                ...record,
                salaryAmount: record.salaryAmount * 0.88
    }));
    return updateEmployees;
});


// function(srv){
//     //implementation
//     srv.on('api', (req, res) => {
//         return 'Hello Amigo:, your name is ' + req.data.name;
//     });
// }
}