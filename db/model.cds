namespace ashutosh.db;

using { cuid, managed, temporal, Currency, Country } from '@sap/cds/common';
using { ashutosh.common } from './commons';

context master {
    
    entity businesspartner : cuid{
       // key NODE_KEY: common.Guid;
        BP_ROLE: String(2);
        EMAIL_ADDRESS: String(105);
        PHONE_NUMBER: String(32);
        FAX_NUMBER: String(32);
        WEB_ADDRESS: String(44);
        ADDRESS_GUID: Association to address;
        BP_ID: String(32);
        COMPANY_NAME: String(250) @title : '{i18n>XCEL_COMPANY_NAME}';
    }

    entity address : cuid{
        //key NODE_KEY: common.Guid;
        CITY: String(44);
        POSTAL_CODE: String(8);
        STREET: String(44);
        BUILDING: String(128);
        COUNTRY: Country;//String(44);
        ADDRESS_TYPE: String(44);
        VAL_START_DATE: Date;
        VAL_END_DATE: Date;
        LATITUDE: Decimal;
        LONGITUDE: Decimal;
        businesspartner: Association to one businesspartner on
        businesspartner.ADDRESS_GUID = $self;
    }

    entity product : cuid{
        //key NODE_KEY: common.Guid;
        PRODUCT_ID: String(28);
        TYPE_CODE: String(2);
        CATEGORY: String(32);
        DESCRIPTION: localized String(255);
        SUPPLIER_GUID: Association to master.businesspartner;
        TAX_TARIF_CODE: Integer;
        MEASURE_UNIT: String(2);
        WEIGHT_MEASURE: Decimal(5,2);
        WEIGHT_UNIT: String(2);
        CURRENCY_CODE: Currency; //String(4);
        PRICE:Decimal(15,2);
        WIDTH:Decimal(5,2);
        DEPTH:Decimal(5,2);
        HEIGHT:Decimal(5,2);
        DIM_UNIT:String(2);
    }

    entity employees: cuid {
        nameFirst: String(40);
        nameMiddle: String(40);
        nameLast: String(40);
        nameInitials: String(40);
        sex: common.Gender;
        language: String(1);
        phoneNumber: common.PhoneNumber;
        email: common.Email;
        loginName: String(12);
        Currency: Currency;
        salaryAmount: common.AmountT;
        accountNumber: String(16);
        bankId: String(10);
        bankName: String(64);
    }
}

context transaction {
    entity purchaseorder: cuid,common.Amount, managed{
        //key NODE_KEY: common.Guid;
        PO_ID: String(40) @title : '{i18n>XCEL_PO_ID}';
        PARTNER_GUID: Association to master.businesspartner;
        LIFECYCLE_STATUS: String(1);
        OVERALL_STATUS: String(1) @title : '{i18n>XCEL_OVERALL_STATUS}';
        Items: composition of many poitems on Items.PARENT_KEY = $self;
    }

    entity poitems: cuid, common.Amount, managed{
       // key NODE_KEY: common.Guid;
        PARENT_KEY: Association to purchaseorder;
        PO_ITEM_POS: Integer;
        PRODUCT_GUID: Association to master.product;
    }
}

