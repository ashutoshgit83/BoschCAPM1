using CatalogService as service from '../../srv/CatalogService';

annotate service.poworklistSet with @(

    UI.SelectionFields      : [
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY.code,
        GROSS_AMOUNT,
        OVERALL_STATUS
    ],

    UI.LineItem             : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
          {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY.code,
        },

        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Boost',
            Inline: true,
            Action: 'CatalogService.boost'
        },

        {
            $Type      : 'UI.DataField',
            Value      : overallstatus,
            Criticality: IconColor
        },

    ],

    UI.HeaderInfo           : {
        TypeName      : 'Purchase Orer',
        TypeNamePlural: 'Purchase Orders',
        Title         : {Value: PO_ID},
        Description   : {Value: PARTNER_GUID.COMPANY_NAME}
    },

    UI.Facets               : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Additional Info',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More Info',
                    Target: '@UI.Identification',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Pricing',
                    Target: '@UI.FieldGroup#Spiderman',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Status Info',
                    Target: '@UI.FieldGroup#Superman',
                },
            ],
        },
            {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'PO Items',
                    Target: 'Items/@UI.LineItem',
            },
    ],

    UI.Identification       : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.ADDRESS_GUID.ADDRESS_TYPE,
        },
        {
            $Type: 'UI.DataField',
            Value: LIFECYCLE_STATUS,
        },
                {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID_ID,
        },
    ],
    UI.FieldGroup#Spiderman: {
        Label: 'Pricing',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: GROSS_AMOUNT,
            },
            {
                $Type: 'UI.DataField',
                Value: NET_AMOUNT,
            },
            {
                $Type: 'UI.DataField',
                Value: TAX_AMOUNT,
            }

        ],
    },

    UI.FieldGroup#Superman : {
        Label: 'Status',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: CURRENCY_code,
            },
            {
                $Type: 'UI.DataField',
                Value: OVERALL_STATUS,
            }
        ],
    }
);

annotate service.poitems with @(
    UI.LineItem: [
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID_ID,
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code,
        },
    ],
     UI.HeaderInfo: {
        TypeName : 'PO Item',
        TypeNamePlural : 'PO Items',
        Title : { Value : PO_ITEM_POS },
        Description : { Value : PRODUCT_GUID.Description }
    },
     UI.Facets: [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Item Details',
            Target : '@UI.Identification',
        },
    ],
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
    ]

);


annotate service.poworklistSet with {
    PARTNER_GUID @(Common.Text: PARTNER_GUID.COMPANY_NAME,
    ValueList.entity: service.businessPartnerSet)
}


annotate service.poitems with {
    PRODUCT_GUID @(Common.Text: PRODUCT_GUID.DESCRIPTION,
    ValueList.entity: service.ProductSet)
}

//define value help
@cds.odata.valuelist
annotate service.businessPartnerSet with @(
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : COMPANY_NAME,
        }
    ]

 ) ;

 @cds.odata.valuelist
 annotate service.ProductSet with @( 

    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : DESCRIPTION,
        }
    ]
 ) ;
 
