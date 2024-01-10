@EndUserText.label: 'Projection view for Feeds Content'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZC_DEMO_FEEDS_CONTENT as projection on ZI_DEMO_FEEDS_CONTENT

{
    @UI.facet: [{ id: 'Feeds',
                  purpose: #STANDARD,
                  type: #IDENTIFICATION_REFERENCE,
                  position: 1 }]
    
    @UI : { lineItem: [{ position: 10, label: 'Feed Content UUID' }],
            identification: [{ position: 10, label: 'Feed Content UUID' }] }            
    key FeedContentUuid,
    
    @UI : { lineItem: [{ position: 20, label: 'Project UUID' }],
            identification: [{ position: 20, label: 'Feed Content UUID' }] }
    key ProjectUuid,
    
    @UI : { lineItem: [{ position: 30, label: 'User' }],
            identification: [{ position: 30, label: 'User' }] }
    Sender,
    
    @UI : { lineItem: [{ position: 40, label: 'Info' }],
            identification: [{ position: 40, label: 'Info' }] }
    Info,
    
    @UI : { lineItem: [{ position: 50, label: 'Content' }],
            identification: [{ position: 50, label: 'Content' }] }
    Content,
    
    @UI : { lineItem: [{ position: 60, label: 'Created By' }],
            identification: [{ position: 60, label: 'Created By' }] }
    CreatedBy,
    
    @UI : { lineItem: [{ position: 70, label: 'Created By' }],
            identification: [{ position: 70, label: 'Created By' }] }
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Projects : redirected to parent ZC_DEMO_S4_PROJECT_INTERFACE
}
