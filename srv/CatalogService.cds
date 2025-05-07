using { ashutosh.db.master, ashutosh.db.transaction } from '../db/model';
using { ashutosh.cds.CDSViews } from '../db/CDSViews';


service CatalogService @( path: 'CatalogService') {

    entity employeeSet as projection on master.employees ;
    entity poworklistSet @(odata.draft.enabled : true,
    Common.DefaultValuesFunction: 'loadInitials' ) as projection on transaction.purchaseorder{
    *,
    case OVERALL_STATUS
      when 'A' then 'Approved'
      when 'P' then 'Pending'
      when 'D' then 'Delivered'
      when 'X' then 'Rrejected'
      when 'A' then 'New'
      end as overallstatus : String(10),
      case OVERALL_STATUS
      when 'A' then 3
      when 'P' then 2
      when 'D' then 3
      when 'X' then 1
      when 'A' then 2
      end as IconColor : Integer
    }
    actions {
        action boost() returns poworklistSet; 
        //function getpodetails(poworklistSet : poworklist) returns poworklistSet;
        function updatePO() returns poworklistSet;   
    };
    entity poitems as projection on transaction.poitems;
    entity ProductSet as projection on master.product;
    entity businessPartnerSet as projection on master.businesspartner;
    //product view from cdsview service
    //entity cdsproductset as projection on CDSViews.ProductView;

    function getLargestPO() returns poworklistSet;
    function loadInitials() returns poworklistSet;

}
