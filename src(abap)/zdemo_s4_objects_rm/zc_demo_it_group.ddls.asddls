@EndUserText.label: 'Projection View for IT Group'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@UI: {
  headerInfo: {
                typeName: 'IT Group',
                typeNamePlural: 'IT Groups',
                title: { type: #STANDARD, label: 'IT Group', value: 'ItGroup'} } }
define root view entity ZC_DEMO_IT_GROUP provider contract transactional_query 
as projection on ZI_DEMO_ITGROUP

{
    @UI.facet: [{ id: 'ITGroups',
                  purpose: #STANDARD,
                  label: 'IT Group Details',
                  type: #IDENTIFICATION_REFERENCE,
                  position: 1 }]
                
    @UI.hidden: true
    key ItgroupUuid,
    
    @UI : { lineItem: [{ position: 10, label: 'IT Group' }],
            identification: [{ position: 10, label: 'IT Group' }] }
    ItGroup,
    
    @UI : { lineItem: [{ position: 20, label: 'Created By' }],
            identification: [{ position: 20, label: 'Created By' }] }
    CreatedBy,
    
    @UI : { lineItem: [{ position: 30, label: 'Created At' }],
            identification: [{ position: 30, label: 'Created At' }] }
    CreatedAt,
    
    @UI : { lineItem: [{ position: 40, label: 'Last Changed By' }],
            identification: [{ position: 40, label: 'Last Changed By' }] }
    LastChangedBy,
    
    @UI : { lineItem: [{ position: 50, label: 'Last Changed At' }],
            identification: [{ position: 50, label: 'Last Changed At' }] }
    LastChangedAt, 
    LocalLastChangedAt
}
