
const cds = require('@sap/cds');
// module.exports = cds.service.impl( async function () {

// const { POs } = this.entities;

// this.on('boost', async (req, res) => {
//     try {
//         const ID = req.data.id;
//         // console.log('Boosting PO:', ID);
//         const Tx = await cds.tx(req);
//         //let test = await Tx.update(POs).where({ id: ID }).set({ status: 'Boosted' }).execute();
//         let test = await Tx.update(POs).with({
//             GROSS_AMOUNT: { '+=' : 20000 }
//         }).where({ id: ID });
//         let reply = await Tx.read(POs).where({ id: ID });
//     } catch (error) {
        
//     }
// });
// })

module.exports = cds.service.impl( async function(){


    const { poworklistSet, employeeSet } = this.entities;
    // const { poworklist } = this.entities;


    // BEFORE employeeSet data is UPDATED using before event DO check validation
    this.before(['CREATE','UPDATE'], employeeSet, async (req, res) => {
        console.log('Updating employee:', JSON.stringify(req.data));
        if (parseFloat(req.data.salaryAmount) > 1000000) {
            req.error('Salary amount cannot be more than 1,000,000');
        }
    });

    this.on('boost', async (req,res) => {
        try {
            //since its instance bound we will get the key
            const ID = req.params[0];
            console.log("Bro this is your key " + JSON.stringify(ID));
            //start a transaction using cds ql - https://cap.cloud.sap/docs/node.js/cds-tx
            const tx = await cds.tx(req);
            let test = await tx.update(poworklistSet).with({
                GROSS_AMOUNT: { '+=' : 20000 }
            }).where({ID: ID});
            let reply = await tx.read(poworklistSet).where({ID: ID});
            return reply;
           
        } catch (error) {
           return error.toString();
        }
    });

    this.on('getLargestPO', async (req, res) => {
        try {
            const tx = await cds.tx(req);
            // let reply = await tx.run(
            //     `SELECT * FROM ${poworklistSet} ORDER BY GROSS_AMOUNT DESC LIMIT 1`
            // );
            let reply = await tx.read(poworklistSet).orderBy('GROSS_AMOUNT DESC').limit(1);
            return reply;
        } catch (error) {
            return error;
        }
    });

    this.on('getpodetails', async (req, res) => {
        try {
            const ID = req.params[0];
            const tx = await cds.tx(req);
            let reply = await tx.read(poworklistSet).where(ID);
            return reply;
            
        } catch (error) {
            return error;
        }
    });

    this.on('loadInitials', async (req, res) => {
        try {
        
            return {
                OVERALL_STATUS : 'N'
            };
        } catch (error) {
            return error;
        }
    });

    // this.on('addnew', async (req, res) => {
    //     try {
    //         const tx = await cds.tx(req);
    //         let test = await tx.insert(poworklist).into(req.data);
    //         let reply = await tx.read(poworklist).where(test.id);
    //         return reply;
    //     } catch (error) {
    //         return error;
    //     }

    // });

    this.on('updatePO', async (req, res) => {
        try {
            const tx = cds.tx(req);
            const ID = req.params[0];
            console.log("Bro this is your key " + JSON.stringify(ID));
            let test = await tx.update(poworklistSet).with({
                 GROSS_AMOUNT: { '+=' : 2999 }
            }).where(ID);
            let reply = await tx.read(poworklistSet).where(ID);
            return reply;
        } catch (error) {
            return error;
        }
})


this.on('updatePO', async (req,res) => {
    try {
        //since its instance bound we will get the key
        const ID = req.params[0];
        console.log("Bro this is your key " + JSON.stringify(ID));
        //start a transaction using cds ql - https://cap.cloud.sap/docs/node.js/cds-tx
        const tx = await cds.tx(req);
        let test = await tx.update(poworklistSet).with({
            GROSS_AMOUNT: { '+=' : 20000 }
        }).where(ID);
        let reply = await tx.read(poworklistSet).where(ID);
        return reply;
       
    } catch (error) {
       
    }
});




})
